module RegisterFile(A_Address, B_Address, C_Address, C_Data, Write, Clk, A_Data, B_Data);

	/* Please fill in the implementation here... */ 
	input [3:0] A_Address,B_Address,C_Address;
	input [31:0] C_Data;
	input Write, Clk;
	
	output reg [31:0] A_Data,B_Data;
	
	
	//reg [31:0] Registers = new reg[32];
	reg [15:0] Registers [0:31];
	
	
	initial begin
		Registers[0] <= 32'd0;	
	end
	
	always @(posedge Clk)
	begin
		
		if (Write == 1 && C_Address != 4'd0) 
		begin
			Registers[C_Address] <= C_Data;
		end
	end
	
	always @(negedge Clk)
	begin
		A_Data <= Registers[A_Address];
		B_Data <= Registers[B_Address];
	end
	
	

endmodule