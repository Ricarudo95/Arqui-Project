module RegisterFile(A_Address, B_Address, C_Address, C_Data, Write, Clk, A_Data, B_Data);

	/* Please fill in the implementation here... */ 
	input [4:0] A_Address,B_Address,C_Address;
	input [31:0] C_Data;
	input Write, Clk;
	
	output reg [31:0] A_Data,B_Data;
	
	
	//reg [31:0] Registers = new reg[32];
	reg [31:0] Registers [0:31];
	
	
	initial begin
		Registers[0] <= 32'd0;
		Registers[1] <= 32'd0;
		Registers[2] <= 32'd0;
		Registers[3] <= 32'd0;
		Registers[4] <= 32'd0;
		Registers[5] <= 32'd0;
		Registers[6] <= 32'd0;
		Registers[7] <= 32'd0;
		Registers[8] <= 32'd0;
		Registers[9] <= 32'd0;
		Registers[10] <= 32'd0;
		Registers[11] <= 32'd0;
		Registers[12] <= 32'd0;
		Registers[13] <= 32'd0;
		Registers[14] <= 32'd0;
		Registers[15] <= 32'd0;
		Registers[16] <= 32'd0;
		Registers[17] <= 32'd0;
		Registers[18] <= 32'd0;
		Registers[19] <= 32'd0;
		Registers[20] <= 32'd0;
		Registers[21] <= 32'd0;
		Registers[22] <= 32'd0;
		Registers[23] <= 32'd0;
		Registers[24] <= 32'd0;
		Registers[25] <= 32'd0;
		Registers[26] <= 32'd0;
		Registers[27] <= 32'd0;
		Registers[28] <= 32'd0;
		Registers[29] <= 32'd0;
		Registers[30] <= 32'd0;
		Registers[31] <= 32'd0;
			
	end
	
	always @(posedge Write)
	begin
		
		if (C_Address != 5'd0) 
		begin
			#1 Registers[C_Address] <= C_Data;
		end
	end
	
	always @*
	begin
		A_Data <= Registers[A_Address];
		B_Data <= Registers[B_Address];
		// $display("\n\n~Recorded Change~ \n");
		// $display("Register 1 - Current Value: %d", Registers[1]);
		// $display("Register 2 - Current Value: %d", Registers[2]);
		// $display("Register 3 - Current Value: %d", Registers[3]);
		// $display("Register 4 - Current Value: %d", Registers[4]);
		// $display("Register 5 - Current Value: %d", Registers[5]);
		// $display("Register 6 - Current Value: %d", Registers[6]);
		// $display("Register 7 - Current Value: %d", Registers[7]);
	end
	
	

endmodule