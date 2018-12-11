module control( 
  input[5:0] opcode,  
  input reset, MOC,
  output reg reg_dst, mem_to_reg,
  output reg[5:0] alu_fnc,
  output reg[1:0] HILO,
  output reg MOV, RAMEnable, jump, branch, RW, alu_src, reg_write);  

 always @(*)  
 begin  
      if(reset == 1'b1) begin // no Op 
                reg_dst = 0;
                reg_write = 0;
                alu_src = 0;
                alu_fnc = 5'b00000;
                RAMEnable = 0;
                RW = 0;
                mem_to_reg = 0;
                jump = 0;  
                branch = 0;  
                HILO = 2'b00;
      end  
      else begin  
        case(opcode)   
        6'b000000: begin // ADD, ADDU, SUB, SUBU, SLT, SLTU, AND, OR, NOR, SLL, SLLV, SRL, SRLV, SRA, 
                reg_dst = 1;
                reg_write = 1;
                alu_src = 0;
                alu_fnc = 5'b00000;
                RAMEnable = 0;
                RW = 0;
                mem_to_reg = 0;
                jump = 0;  
                branch = 0;  
                HILO = 2'b00;
                end  
        6'b011100: begin // CLO, CLZ
                reg_dst = 1;
                reg_write = 1;
                alu_src = 0;
                alu_fnc = 5'b00001;
                RAMEnable = 0;
                RW = 0;
                mem_to_reg = 0;
                jump = 0;  
                branch = 0;  
                HILO = 2'b00;
                end  
        6'b000010: begin // JMP 
                reg_dst = 0;
                reg_write = 0;
                alu_src = 0;
                alu_fnc = 5'b00000;
                RAMEnable = 0;
                RW = 0;
                mem_to_reg = 0;
                jump = 1;  
                branch = 0;  
                HILO = 2'b00;

                end 

        6'b101011: begin // SW
                reg_dst = 0;
                reg_write = 1;
                alu_src = 1;
                alu_fnc = 5'b01101;
                RAMEnable = 1;
                RW = 0;
                mem_to_reg = 1;
                jump = 0;  
                branch = 0;  
                HILO = 2'b00;
 
                end

        6'b101001: begin // SH 
                reg_dst = 0;
                reg_write = 1;
                alu_src = 1;
                alu_fnc = 5'b01110;
                RAMEnable = 1;
                RW = 0;
                mem_to_reg = 1;
                jump = 0;  
                branch = 0;  
                HILO = 2'b00;
                end

        6'b101000: begin // SB
                reg_dst = 0;
                reg_write = 1;
                alu_src = 1;
                alu_fnc = 5'b01111;
                RAMEnable = 1;
                RW = 0;
                mem_to_reg = 1;
                jump = 0;  
                branch = 0;  
                HILO = 2'b00;
                end
      
        6'b100011: begin // LW 
                reg_dst = 0;
                reg_write = 0;
                alu_src = 1;
                alu_fnc = 5'b01000;
                RAMEnable = 1;
                RW = 1;
                mem_to_reg = 1;
                jump = 0;  
                branch = 0;  
                HILO = 2'b00;
                end

        6'b100011: begin // LH 
                reg_dst = 0;
                reg_write = 0;
                alu_src = 1;
                alu_fnc = 5'b01000;
                RAMEnable = 1;
                RW = 1;
                mem_to_reg = 1;
                jump = 0;  
                branch = 0;  
                HILO = 2'b00;
                end

        6'b100101: begin // LHU
                reg_dst = 0;
                reg_write = 0;
                alu_src = 1;
                alu_fnc = 5'b01001;
                RAMEnable = 1;
                RW = 1;
                mem_to_reg = 1;
                jump = 0;  
                branch = 0;  
                HILO = 2'b00;
                end

        6'b100000: begin // LB
                reg_dst = 0;
                reg_write = 0;
                alu_src = 1;
                alu_fnc = 5'b01010;
                RAMEnable = 1;
                RW = 1;
                mem_to_reg = 1;
                jump = 0;  
                branch = 0;  
                HILO = 2'b00;
                end

        6'b000100: begin // B
                reg_dst = 0;
                reg_write = 0;
                alu_src = 1;
                alu_fnc = 5'b10000;
                RAMEnable = 0;
                RW = 0;
                mem_to_reg = 0;
                jump = 0;  
                branch = 0;  
                HILO = 2'b00;
                end

        6'b000110: begin // BLEZ
                reg_dst = 0;
                reg_write = 0;
                alu_src = 1;
                alu_fnc = 5'b10110;
                RAMEnable = 0;
                RW = 0;
                mem_to_reg = 0;
                jump = 0;  
                branch = 1;  
                HILO = 2'b00;
                end

        6'b000111: begin // BGTZ
                reg_dst = 0;
                reg_write = 0;
                alu_src = 1;
                alu_fnc = 5'b10101;
                RAMEnable = 0;
                RW = 0;
                mem_to_reg = 0;
                jump = 0;  
                branch = 1;  
                HILO = 2'b00;
                end

      // 6'b000100: begin // B
      //           reg_dst = 0;  
      //           mem_to_reg = 0;  
      //           alu_op = 2'b11;  
      //           jump = 0;  
      //           branch = 1;  
      //           mem_read_write = 0;   
      //           alu_src = 1;  
      //           reg_write = 0;  
      //           end

      //  6'b000100: begin // SH
      //           reg_dst = 0;  
      //           mem_to_reg = 0;  
      //           alu_op = 2'b11;  
      //           jump = 0;  
      //           branch = 1;  
      //           mem_read_write = 0;   
      //           alu_src = 1;  
      //           reg_write = 0;  
      //           end 

      //  6'b000100: begin // SB
      //           reg_dst = 0;  
      //           mem_to_reg = 0;  
      //           alu_op = 2'b11;  
      //           jump = 0;  
      //           branch = 1;  
      //           mem_read_write = 0;   
      //           alu_src = 1;  
      //           reg_write = 0;  
      //           end                   

      default: begin  
                reg_dst = 2'b01;  
                mem_to_reg = 2'b00;  
                alu_fnc = 2'b00;  
                jump = 1'b0;  
                branch = 1'b0;  
                RW= 1'b0;  
                alu_src = 1'b0;  
                reg_write = 1'b1;  
                end  
      endcase  
      end  
 end  
endmodule  

module instructMemTest1(output reg [31:0] Instruction, input Enable, input[31:0]  PC);

	reg [7:0] Mem[0:511];

        initial begin


		Mem[0] <= 8'b00100100; //ADDIU
                Mem[1] <= 8'b00000001;
                Mem[2] <= 8'b00000000;
                Mem[3] <= 8'b00101100;

                Mem[4] <= 8'10010000; //LBU
                Mem[5] <= 8'b00100010;
                Mem[6] <= 8'b00000000;
                Mem[7] <= 8'b00000000;

                Mem[8] <= 8'b00100100; //LBU
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

                Mem[40] <= 8'b00011001; // BLEZ
                Mem[41] <= 8'b00000101;
                Mem[42] <= 8'b00000111;
                Mem[43] <= 8'b00000100;

                Mem[40] <= 8'b00010000; //B
                Mem[41] <= 8'b00000000;
                Mem[42] <= 8'b11111111;
                Mem[43] <= 8'b11111111;

                Mem[40] <= 8'b00000000; //sll
                Mem[41] <= 8'b00000000;
                Mem[42] <= 8'b00000000;
                Mem[43] <= 8'b00000000;

                

                

	end



	always @(Enable) //Whenever Enable and/or MOV is active
	if(Enable)
        Instruction = {Mem[PC], Mem[PC+1], Mem[PC+2], Mem[PC+3]};
endmodule


module ProgramCounter(PCNext, PCResult, Reset, Clk,PCWrite);

	input       [31:0]  PCNext;
	input               Reset, Clk,PCWrite;

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
			if (PCWrite == 1) begin
				PCResult <= PCNext;
			end
    	end

		$display("PC=%h",PCResult);
    end

endmodule