module control( input clk,
  input[5:0] opCode,  
  input reset,
  output reg regWrite, flagLoad, instRegLoad, marLoad, mdrLoad, RW, MOV, regSrc, mem_to_reg,  jump, branch,
  output reg[1:0] aluSrc; 
  output reg[5:0] aluCode);  

 initial begin
        regWrite=0;
        flagLoad=0;
        instRegLoad = 0;
        marLoad=0;
        mdrLoad=0;
        RW=0;
        MOV=0;
        regSrc=0;
        aluSrc=2'b11;
        mem_to_reg=0;
        jump= 0
        branch = 0;
        aluCode=6'b111111;
 end
 
 always @* 
 begin  
        $display("State 1: Loading MAR")
        marLoad=1;

        $display("State 2: Reading From Memory")
        RW=1;

        $display("State 1: Loading Instruction")
        instRegLoad=1;

        case(opCode)   
        6'b000000: begin // ADD, ADDU, SUB, SUBU, SLT, SLTU, AND, OR, NOR, SLL, SLLV, SRL, SRLV, SRA, 
                reg_dst = 1;
                reg_write = 1;
                alu_src = 0;
                aluCode = 3'b000;
                memRead = 0;
                memWrite = 0;
                mem_to_reg = 1;
                jump = 0;  
                branch = 0;
                unSign = 0;
                $display("Current Instruction: Aritmetic");
                end  
        6'b011100: begin // CLO, CLZ
                reg_dst = 1;
                reg_write = 1;
                alu_src = 0;
                aluCode = 3'b100;
                memRead = 0;
                memWrite = 0;
                mem_to_reg = 0;
                jump = 0;  
                branch = 0;
                unSign=0;
                $display("Current Instruction: CLO, CLZ");
                end  

        6'b000010: begin // JMP 
                reg_dst = 0;
                reg_write = 0;
                alu_src = 0;
                aluCode = 3'b000;
                memRead = 0;
                memWrite = 0;
                mem_to_reg = 0;
                jump = 0;  
                branch = 0;
                unSign=0;
                $display("Current Instruction: JUMP");
                end  

        6'b101011: begin // SW
                reg_write = 0;
                alu_src = 0;
                aluCode = 3'b101;
                memRead = 0;
                memWrite = 1;
                mem_to_reg = 0;
                jump = 0;  
                branch = 0;
                unSign=0;
                $display("Current Instruction: Save Word");
                end

        6'b101000: begin // SB
                reg_write = 0;
                alu_src = 1;
                aluCode = 3'b110;
                memRead = 0;
                memWrite = 1;
                mem_to_reg = 0;
                jump = 0;  
                branch = 0;
                unSign=0;
                $display("Current Instruction: Save Byte");
                end
      
        6'b100011: begin // LW: Load Word
                reg_write = 0;
                alu_src = 0;
                aluCode = 3'b101;
                memRead = 0;
                memWrite = 1;
                mem_to_reg = 0;
                jump = 0;  
                branch = 0;
                unSign=0;
                $display("Current Instruction: Load Word");
                end


        6'b100000: begin // LB: Load Byte
                reg_write = 0;
                alu_src = 0;
                aluCode = 3'b101;
                memRead = 0;
                memWrite = 1;
                mem_to_reg = 0;
                jump = 0;  
                branch = 0;
                unSign=0;
                $display("Current Instruction: Load Byte");
                end

        6'b100100: begin // LBU: Load Byte Unsigned
                reg_write = 1;
                alu_src = 0;
                aluCode = 3'b101;
                memRead = 1;
                memWrite = 0;
                mem_to_reg = 0;
                jump = 0;  
                branch = 0;
                unSign=1;
                $display("Current Instruction: Load Byte Unsigned");
                end

        6'b000100: begin // BEQ
                reg_dst = 0;
                reg_write = 0;
                alu_src = 0;
                aluCode = 3'b001;
                memRead = 0;
                memWrite = 0;
                mem_to_reg = 0;
                jump = 0;  
                branch = 1;
                unSign=0;
                $display("Current Instruction: Branch if Equal");
                end

        6'b000001: begin // BEQZ
                reg_dst = 0;
                reg_write = 0;
                alu_src = 0;
                aluCode = 3'b001;
                memRead = 0;
                memWrite = 0;
                mem_to_reg = 0;
                jump = 0;  
                branch = 1;
                unSign=0;
                $display("Current Instruction: Branch if Equal to Zero");
                end

        6'b000110: begin // BLEZ
                reg_dst = 0;
                reg_write = 0;
                alu_src = 0;
                aluCode = 3'b010;
                memRead = 0;
                memWrite = 0;
                mem_to_reg = 0;
                jump = 0;  
                branch = 1;
                unSign=0;
                $display("Current Instruction: Branch if Less Than Zero");
                end

        6'b000111: begin // BGTZ
                reg_dst = 0;
                reg_write = 0;
                alu_src = 0;
                aluCode = 3'b011;
                memRead = 0;
                memWrite = 0;
                mem_to_reg = 0;
                jump = 0;  
                branch = 1;
                unSign=0;
                $display("Current Instruction: Branch if Greater Than Zero");
                end
        
        6'b001001: begin // add Imidiate unsigned
                reg_dst = 0;
                reg_write = 1;
                alu_src = 1;
                aluCode = 3'b101;
                memRead = 0;
                memWrite = 0;
                mem_to_reg = 1;
                jump = 0;  
                branch = 0;
                unSign=1;
                $display("Current Instruction: ADDIU");
                end

        6'b001000: begin // add Imidiate signed
                reg_dst = 0;
                reg_write = 1;
                alu_src = 1;
                aluCode = 3'b101;
                memRead = 0;
                memWrite = 0;
                mem_to_reg = 1;
                jump = 0;  
                branch = 0;
                unSign=0;
                $display("Current Instruction: ADDI");
                end
        

      default: begin  
                reg_dst = 0;
                reg_write = 0;
                alu_src = 0;
                aluCode = 3'b000;
                memRead = 0;
                memWrite = 0;
                mem_to_reg = 0;
                jump = 0;  
                branch = 0;
                unSign=0;
                end  
      endcase  
      end  
 end  
endmodule  

module instructMemTest1(output [31:0] Instruction, input Enable, input[31:0]  PC);

	reg [7:0] Mem[0:511];

        initial begin
		Mem[0] <= 8'b00100100; //ADDIU
                Mem[1] <= 8'b00000001;
                Mem[2] <= 8'b00000000;
                Mem[3] <= 8'b00101100;

                Mem[4] <= 8'b10010000; //LBU
                Mem[5] <= 8'b00100010;
                Mem[6] <= 8'b00000000;
                Mem[7] <= 8'b00000000;

                Mem[8] <= 8'b00100100; //ADDIU
                Mem[9] <= 8'b00100100;
                Mem[10] <= 8'b00000000;
                Mem[11] <= 8'b00100100;

                Mem[12] <= 8'b00000000; //ADDU
                Mem[13] <= 8'b00000000;
                Mem[14] <= 8'b00101000;
                Mem[15] <= 8'b00100001;

                Mem[16] <= 8'b00000000; //ADDU
                Mem[17] <= 8'b10100010;
                Mem[18] <= 8'b00101000;
                Mem[19] <= 8'b00100001;

                Mem[20] <= 8'b00100100; //ADDIU
                Mem[21] <= 8'b01100011;
                Mem[22] <= 8'b11111111;
                Mem[23] <= 8'b11111111;

                Mem[24] <= 8'b00011100; // BGTZ 
                Mem[25] <= 8'b01100000;
                Mem[26] <= 8'b11111111;
                Mem[27] <= 8'b11111101;

                Mem[28] <= 8'b00000000; // SLL
                Mem[29] <= 8'b00000000;
                Mem[30] <= 8'b00000000;
                Mem[31] <= 8'b00000000;
                
                Mem[32] <= 8'b10100000; //SB
                Mem[33] <= 8'b00100101;
                Mem[34] <= 8'b00000000;
                Mem[35] <= 8'b00000001;

                Mem[36] <= 8'b00010000; //B
                Mem[37] <= 8'b00000000;
                Mem[38] <= 8'b00000000;
                Mem[39] <= 8'b00000010;

                Mem[40] <= 8'b00000000; // sll
                Mem[41] <= 8'b00000000;
                Mem[42] <= 8'b00000000;
                Mem[43] <= 8'b00000000;

                Mem[44] <= 8'b00011001; // BLEZ
                Mem[45] <= 8'b00000101;
                Mem[46] <= 8'b00000111;
                Mem[47] <= 8'b00000100;

                Mem[48] <= 8'b00010000; //B
                Mem[49] <= 8'b00000000;
                Mem[50] <= 8'b11111111;
                Mem[51] <= 8'b11111111;

                Mem[52] <= 8'b00000000; //sll
                Mem[53] <= 8'b00000000;
                Mem[54] <= 8'b00000000;
                Mem[55] <= 8'b00000000;

	end
        assign Instruction = {Mem[PC], Mem[PC+1], Mem[PC+2], Mem[PC+3]};
endmodule

module instructMemTest2(output [31:0] Instruction, input Enable, input[31:0]  PC);

	reg [7:0] Mem[0:511];

        initial begin
		$readmemb("Input/testcode_mips2.txt", Mem);
	end
        assign Instruction = {Mem[PC], Mem[PC+1], Mem[PC+2], Mem[PC+3]};
endmodule

module instructMemTest3(output [31:0] Instruction, input Enable, input[31:0]  PC);

	reg [7:0] Mem[0:511];

        initial begin
		$readmemb("Input/testcode_mips3.txt", Mem);
	end
        assign Instruction = {Mem[PC], Mem[PC+1], Mem[PC+2], Mem[PC+3]};
endmodule

module ProgramCounter(PCNext, PCResult, Reset, Clk);

	input       [31:0]  PCNext;
	input               Reset, Clk;

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
    	else
    	        begin
		PCResult <= PCNext;	
    	        end
    end

endmodule