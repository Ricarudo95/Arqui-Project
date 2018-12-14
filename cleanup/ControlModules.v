module control( input clk,
  input reset, MOC,
  input[5:0] opCode, 
  output reg unSign, memEnable, irLoad, pcLoad,npcLoad, rfSource, regWrite, jump, branch, immediate, RW, byte, marLoad,mdrLoad, mdrSource, pcSelect,
  output reg[1:0] aluSrc, 
  output reg[5:0] aluCode);  

        reg[4:0] state;

 initial begin
       state <= 5'd0;
 end
 
 always @(posedge clk)
        begin
        case(state)
        5'd0: begin
                //$display("State 0: Reset state");
                byte=0;
                pcLoad = 0;
                npcLoad =0;
                unSign=0;
                memEnable = 0; 
                pcSelect = 0;
                state <= 5'd0;
                aluSrc <= 2'b00;
                immediate = 0;
                irLoad =0;
                pcLoad = 0;
                npcLoad = 0;
                rfSource = 0;
                regWrite = 0;
                jump = 0;
                branch = 0;
                RW = 0;
                marLoad = 0;
                mdrLoad = 0;
                mdrSource = 0;

                #1 state <= 5'd1;
                end

        5'd1: begin
                //$display("State 1: Load PC ro MAR");
                pcSelect = 1;
                npcLoad = 1;
                mdrLoad = 0;
                pcLoad = 0;
                unSign=0;
                
                aluSrc <= 2'b11;
                aluCode <= 100001;
                immediate = 1;
                pcLoad = 0;
                npcLoad =0;
                
                #1 marLoad = 1;
               

                #1 state <= 5'd2;
                end

        5'd2: begin
                //$display("State 2: Read Memory");
                npcLoad=0;
                marLoad = 0;
                memEnable = 1;
                
                RW = 0;
                #1 state <= 5'd3;
        end
        5'd3: begin
               // $display("State 3: Load to Instrction Register");
                if (MOC == 1)
                        begin
                        memEnable=0;
                        #1 irLoad = 1;
                        #1 state = 5'd4;
                        
                        end
        end

        5'd4: begin
               // $display("State 4: Decode Instruction");
                marLoad = 0;
                RW = 0;
                regWrite = 0;
                mdrSource = 0;
                irLoad = 0;
                immediate = 0;
                pcSelect=0;
                aluSrc = 2'd0;
                aluCode = 6'd0;


                case(opCode)   
                6'b000000: begin // ADD, ADDU, SUB, SUBU, SLT, SLTU, AND, OR, NOR, SLL, SLLV, SRL, SRLV, SRA, 
                        #1 state <= 5'd5;
                end

                6'b001000: begin // add Imidiate signed
                        aluCode=6'b100000;
                        #1 state <= 5'd6;
                        
                end

                6'b001001: begin // add Imidiate unsigned
                        unSign=1;
                        aluCode=6'b100001;
                        #1 state <= 5'd6;
                end

                6'b011100: begin // CLO
                        aluCode = 6'b011100;
                        #1 state <= 5'd15;
                end

                6'b011101: begin // CLZ
                        aluCode = 6'b011101;
                        #1 state <= 5'd15;
                end
                

                6'b000010: begin // JMP 
                        #1 state <= 5'd10;
                end

                6'b101011: begin // SW: Save Word
                        aluCode <= 100000;
                        #1 state <= 5'd10;
                end

                6'b101000: begin // SB: Save Byte
                        byte= 1;
                        #1 state <= 5'd10;
                end


                6'b100011: begin // LW: Load Word
                        aluCode <= 100000;
                        #1 state <= 5'd7;
                end

                6'b100000: begin // LB: Load Byte
                        byte=1;
                        aluCode <= 100000;
                        #1 state <= 5'd17;
                end

                6'b100100: begin // LBU: Load Byte Unsigned
                        unSign=1;
                        byte=1;
                        aluCode <= 100001;
                        #1 state <= 5'd7;
                end

                6'b000100: begin // BEQ
                        aluCode <=000001;
                        #1 state <= 5'd16;

                end

                6'b000001: begin // BEQZ
                        #1 state <= 5'd16;
                end

                6'b000110: begin // BLEZ
                        #1 state <= 5'd16;
                end

                6'b000111: begin // BGTZ
                        aluCode<=001111;
                        #1 state <= 5'd16;
                end







                endcase
        end
        

        5'd5: begin // ARITHMETIC CASE: ADD, ADDU, SUB, SUBU, SLT, SLTU, AND, OR, NOR, SLL, SLLV, SRL, SRLV, SRA, 
                memEnable=0;
                rfSource=1;
                jump=0;
                branch=0;
                immediate=0;
                RW=0;
                
                mdrLoad=1;
                mdrSource=1;
                pcSelect=0;
                aluSrc=2'b00;

                #1
                marLoad=0;
                regWrite=1;
                npcLoad = 1;
                pcLoad = 1;
                #1 state <= 5'd1;
        end

        5'd6: begin // Arithmetic Immidiates
                memEnable=0;
                rfSource=0;
                
                jump=0;
                branch=0;
                immediate=1;
                RW=0;
                marLoad=0;
                mdrSource=1;
                pcSelect=0;
                aluSrc=2'b01;
                
                #1 
                mdrLoad=1;
                regWrite=1;
                npcLoad = 1;
                pcLoad = 1;
                #1 state = 5'd1;
        end

        5'd7: begin // Load Data Step 1: Load to MAR
                
                aluSrc <= 2'b01;
                aluCode <= 100000;
                immediate = 1;
                #1 marLoad = 1;

                #1 state <= 5'd8;
        end

        5'd8: begin // Load Data Step 2: Read Memory
                marLoad = 0;
                memEnable = 1;
                RW = 0;
                if (MOC == 1) begin
                #1 state <= 5'd9;
                end
        end

        5'd9: begin // Load Data Step 3: Save to Register
                
                #1 mdrLoad=1;
                memEnable=0;
                mdrSource=0;
                regWrite = 1;

                npcLoad = 1;
                pcLoad = 1;
                #1 state = 5'd1;
                
        end

        5'd10: begin // Save Data Step 1: Load to MAR
                aluSrc <= 2'b01;
                aluCode <= 100000;
                immediate = 1;

                
                #1 marLoad = 1;
                #1 state <= 5'd11;
   
        end

        5'd11: begin // Save Data Step 2: Load to MDR
                marLoad = 0;
                mdrSource=1;
                aluSrc <= 2'b00;
                aluCode <= 111111;
                immediate = 1;

                
                #1; mdrLoad = 1;
                #1 state <= 5'd12;

        end

        5'd12: begin // Save Data Step 3: Save to Mem

                mdrLoad = 0;
                aluCode <= 000000;
                memEnable = 1;
                RW = 1;
                        
                if (MOC==1) begin
                        memEnable=0;
                        npcLoad = 1;
                        pcLoad = 1;
                        #1 state <= 5'd1;
                end

        end

        5'd14: begin // Jump
                jump = 1;

                npcLoad = 1;
                pcLoad = 1;
                #1 state <= 5'd1;

        end

        5'd15: begin // CLO CLZ
                memEnable=0;
                rfSource=1;
                regWrite=1;
                jump=0;
                branch=0;
                immediate=1;
                RW=0;
                marLoad=0;
                mdrLoad=1;
                mdrSource=1;
                pcSelect=0;
                aluSrc=2'b00;

                npcLoad = 1;
                pcLoad = 1;
                #1 state <= 5'd1;
        end

        5'd16: begin // Branch
                branch=1;
                #1 state <= 5'd1;
        end



        

                
        endcase
        end  
  
endmodule  



module ProgramCounter(PCNext, PCResult, Reset, Clk, Load);

	input       [31:0]  PCNext;
	input               Reset, Clk, Load;

	output reg  [31:0]  PCResult;

    /* Please fill in the implementation here... */

	initial begin
	
		PCResult <= 32'h00000000;
	end

    always @(posedge Load)
    begin
    	if (Reset == 1)
    	        begin
    		PCResult = 32'h00000000;
    	        end
        assign PCResult = PCNext;	       
        //$display("PC: Result %d", PCResult);
    end

endmodule