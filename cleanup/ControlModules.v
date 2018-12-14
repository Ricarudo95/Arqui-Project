module control( input clk,
  input reset, MOC,
  input[5:0] opCode, 
  output reg irLoad, pcLoad,npcLoad, rfSource, regWrite, jump, branch, immediate, RW, marLoad,mdrLoad, mdrSource, pcSelect,
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
                $display("State 0: Reset state");
                pcSelect = 0;
                state <= 5'd0;
                aluSrc <= 2'b00;
                aluCode <= 000000;
                immediate = 0;
                irLoad =0;
                pcLoad = 0;
                npcLoad = 0;
                rfSource = 0;
                regWrite = 0;
                jump = 0;
                RW = 0;
                marLoad = 0;
                mdrLoad = 0;
                mdrSource = 0;

                state <= 5'd1;
                end

        5'd1: begin
                $display("State 1: Load PC ro MAR");
                pcSelect = 1;
                aluSrc <= 2'b11;
                aluCode <= 001010;
                immediate = 1;
                marLoad = 1;

                state <= 5'd2;
                end

        5'd2: begin
                $display("State 2: Read Memory");
                marLoad = 0;
                RW = 1;
                state <= 5'd3;
        end
        5'd3: begin
                $display("State 3: Load to Instrction Register");
                if (MOC == 1)
                        begin
                        state = 5'd4;
                        irLoad = 1;
                        end
        end

        5'd4: begin
                $display("State 4: Decode Instruction");
                marLoad = 0;
                RW = 0;
                irLoad = 0;
                immediate = 0;
                pcSelect=0;
                aluSrc = 2'd0;
                aluCode = 6'd0;
                state <= 5'd3;

                npcLoad = 1;
                pcLoad = 1;

                state <= 5'd1;

        end

        

                // case(opCode)   
                // 6'b0000000: begin // ADD, ADDU, SUB, SUBU, SLT, SLTU, AND, OR, NOR, SLL, SLLV, SRL, SRLV, SRA, 
                //         reg_dst = 1;
                //         reg_write = 1;
                //         alu_src = 0;
                //         aluCode = 3'b000;
                //         memRead = 0;
                //         memWrite = 0;
                //         mem_to_reg = 1;
                //         jump = 0;  
                //         branch = 0;
                //         imidiate = 0;
                //         $display("Current Instruction: Aritmetic");
                //         end  
                // 6'b011100: begin // CLO, CLZ
                //         reg_dst = 1;
                //         reg_write = 1;
                //         alu_src = 0;
                //         aluCode = 3'b100;
                //         memRead = 0;
                //         memWrite = 0;
                //         mem_to_reg = 0;
                //         jump = 0;  
                //         branch = 0;
                //         unSign=0;
                //         $display("Current Instruction: CLO, CLZ");
                //         end  

                // 6'b000010: begin // JMP 
                //         reg_dst = 0;
                //         reg_write = 0;
                //         alu_src = 0;
                //         aluCode = 3'b000;
                //         memRead = 0;
                //         memWrite = 0;
                //         mem_to_reg = 0;
                //         jump = 0;  
                //         branch = 0;
                //         unSign=0;
                //         $display("Current Instruction: JUMP");
                //         end  

                // 6'b101011: begin // SW
                //         reg_write = 0;
                //         alu_src = 0;
                //         aluCode = 3'b101;
                //         memRead = 0;
                //         memWrite = 1;
                //         mem_to_reg = 0;
                //         jump = 0;  
                //         branch = 0;
                //         unSign=0;
                //         $display("Current Instruction: Save Word");
                //         end

                // 6'b101000: begin // SB
                //         reg_write = 0;
                //         alu_src = 1;
                //         aluCode = 3'b110;
                //         memRead = 0;
                //         memWrite = 1;
                //         mem_to_reg = 0;
                //         jump = 0;  
                //         branch = 0;
                //         unSign=0;
                //         $display("Current Instruction: Save Byte");
                //         end
        
                // 6'b100011: begin // LW: Load Word
                //         reg_write = 0;
                //         alu_src = 0;
                //         aluCode = 3'b101;
                //         memRead = 0;
                //         memWrite = 1;
                //         mem_to_reg = 0;
                //         jump = 0;  
                //         branch = 0;
                //         unSign=0;
                //         $display("Current Instruction: Load Word");
                //         end


                // 6'b100000: begin // LB: Load Byte
                //         reg_write = 0;
                //         alu_src = 0;
                //         aluCode = 3'b101;
                //         memRead = 0;
                //         memWrite = 1;
                //         mem_to_reg = 0;
                //         jump = 0;  
                //         branch = 0;
                //         unSign=0;
                //         $display("Current Instruction: Load Byte");
                //         end

                // 6'b100100: begin // LBU: Load Byte Unsigned
                //         reg_write = 1;
                //         alu_src = 0;
                //         aluCode = 3'b101;
                //         memRead = 1;
                //         memWrite = 0;
                //         mem_to_reg = 0;
                //         jump = 0;  
                //         branch = 0;
                //         unSign=1;
                //         $display("Current Instruction: Load Byte Unsigned");
                //         end

                // 6'b000100: begin // BEQ
                //         reg_dst = 0;
                //         reg_write = 0;
                //         alu_src = 0;
                //         aluCode = 3'b001;
                //         memRead = 0;
                //         memWrite = 0;
                //         mem_to_reg = 0;
                //         jump = 0;  
                //         branch = 1;
                //         unSign=0;
                //         $display("Current Instruction: Branch if Equal");
                //         end

                // 6'b000001: begin // BEQZ
                //         reg_dst = 0;
                //         reg_write = 0;
                //         alu_src = 0;
                //         aluCode = 3'b001;
                //         memRead = 0;
                //         memWrite = 0;
                //         mem_to_reg = 0;
                //         jump = 0;  
                //         branch = 1;
                //         unSign=0;
                //         $display("Current Instruction: Branch if Equal to Zero");
                //         end

                // 6'b000110: begin // BLEZ
                //         reg_dst = 0;
                //         reg_write = 0;
                //         alu_src = 0;
                //         aluCode = 3'b010;
                //         memRead = 0;
                //         memWrite = 0;
                //         mem_to_reg = 0;
                //         jump = 0;  
                //         branch = 1;
                //         unSign=0;
                //         $display("Current Instruction: Branch if Less Than Zero");
                //         end

                // 6'b000111: begin // BGTZ
                //         reg_dst = 0;
                //         reg_write = 0;
                //         alu_src = 0;
                //         aluCode = 3'b011;
                //         memRead = 0;
                //         memWrite = 0;
                //         mem_to_reg = 0;
                //         jump = 0;  
                //         branch = 1;
                //         unSign=0;
                //         $display("Current Instruction: Branch if Greater Than Zero");
                //         end
                
                // 6'b001001: begin // add Imidiate unsigned
                //         reg_dst = 0;
                //         reg_write = 1;
                //         alu_src = 1;
                //         aluCode = 3'b101;
                //         memRead = 0;
                //         memWrite = 0;
                //         mem_to_reg = 1;
                //         jump = 0;  
                //         branch = 0;
                //         unSign=1;
                //         $display("Current Instruction: ADDIU");
                //         end

                // 6'b001000: begin // add Imidiate signed
                //         reg_dst = 0;
                //         reg_write = 1;
                //         alu_src = 1;
                //         aluCode = 3'b101;
                //         memRead = 0;
                //         memWrite = 0;
                //         mem_to_reg = 1;
                //         jump = 0;  
                //         branch = 0;
                //         unSign=0;
                //         $display("Current Instruction: ADDI");
                //         end
                

                // default: begin  
                //         reg_dst = 0;
                //         reg_write = 0;
                //         alu_src = 0;
                //         aluCode = 3'b000;
                //         memRead = 0;
                //         memWrite = 0;
                //         mem_to_reg = 0;
                //         jump = 0;  
                //         branch = 0;
                //         unSign=0;
                //         end  
                // endcase  
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

    always @(posedge Clk)
    begin
    	if (Reset == 1)
    	        begin
    		PCResult <= 32'h00000000;
    	        end
    	if (Load == 1)
    	        begin
		PCResult <= PCNext;	
    	        end
        else
                begin
		PCResult <= PCResult;	
    	        end
        $display("PC: Result %d", PCResult);
    end

endmodule