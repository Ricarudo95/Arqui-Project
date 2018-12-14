module MemoryTest1(address, output_destination, dataIn, rw, byte, MOC, memEnable);
 
input[31:0]   address;
input[31:0]   dataIn;
input rw, byte, memEnable;

output reg [31:0]  output_destination;
output reg MOC = 1;
  
//memory declaration
reg [7:0] Mem[0:511];

//Load Up Memory
initial begin
	$readmemb("Input/testcode_mips1.txt", Mem);
	$display("verify memory at 2: %b%b%b%b", Mem[0],Mem[1],Mem[2],Mem[3]);

end
 
// behavior
always@(posedge memEnable) begin
	
	if(byte==0) begin
		if (rw == 0) begin
			assign MOC = 0;
			output_destination = {Mem[address], Mem[address+1], Mem[address+2], Mem[address+3]};
			#13;
			assign MOC=1;
		end
		else begin
			assign MOC = 0;
			Mem[address] = dataIn[31:24];
			Mem[address+1] = dataIn[23:16];
			Mem[address+2] = dataIn[15:8];
			Mem[address+3] = dataIn[7:0];
			#13;
			assign MOC=1;
		end
	end

	else begin

		if (rw == 0) begin
				assign MOC = 0;
				output_destination = {Mem[address], 24'd0};
				#7;
				assign MOC=1;
			end
			else begin
				assign MOC = 0;
				Mem[address] = dataIn[31:24];
				#7;
				assign MOC=1;
		end
	end


end
endmodule

module MemoryTest2(address, output_destination, dataIn, rw, byte, MOC, memEnable);
 
input[31:0]   address;
input[31:0]   dataIn;
input rw, byte, memEnable;

output reg [31:0]  output_destination;
output reg MOC = 1;
  
//memory declaration
reg [7:0] Mem[0:511];

//Load Up Memory
initial begin
	$readmemb("Input/testcode_mips2.txt", Mem);
	$display("verify memory at 2: %b%b%b%b", Mem[0],Mem[1],Mem[2],Mem[3]);

end
 
// behavior
always@(posedge memEnable) begin
	
	if(byte==0) begin
		if (rw == 0) begin
			assign MOC = 0;
			output_destination = {Mem[address], Mem[address+1], Mem[address+2], Mem[address+3]};
			#13;
			assign MOC=1;
		end
		else begin
			assign MOC = 0;
			Mem[address] = dataIn[31:24];
			Mem[address+1] = dataIn[23:16];
			Mem[address+2] = dataIn[15:8];
			Mem[address+3] = dataIn[7:0];
			#13;
			assign MOC=1;
		end
	end

	else begin

		if (rw == 0) begin
				assign MOC = 0;
				output_destination = {Mem[address], 24'd0};
				#7;
				assign MOC=1;
			end
			else begin
				assign MOC = 0;
				Mem[address] = dataIn[31:24];
				#7;
				assign MOC=1;
		end
	end


end
endmodule

module MemoryTest3(address, output_destination, dataIn, rw, byte, MOC, memEnable);
 
input[31:0]   address;
input[31:0]   dataIn;
input rw, byte, memEnable;

output reg [31:0]  output_destination;
output reg MOC = 1;
  
//memory declaration
reg [7:0] Mem[0:511];

//Load Up Memory
initial begin
	$readmemb("Input/testcode_mips3.txt", Mem);
	$display("verify memory at 2: %b%b%b%b", Mem[0],Mem[1],Mem[2],Mem[3]);

end
 
// behavior
always@(posedge memEnable) begin
	
	if(byte==0) begin
		if (rw == 0) begin
			assign MOC = 0;
			output_destination = {Mem[address], Mem[address+1], Mem[address+2], Mem[address+3]};
			#13;
			assign MOC=1;
		end
		else begin
			assign MOC = 0;
			Mem[address] = dataIn[31:24];
			Mem[address+1] = dataIn[23:16];
			Mem[address+2] = dataIn[15:8];
			Mem[address+3] = dataIn[7:0];
			#13;
			assign MOC=1;
		end
	end

	else begin

		if (rw == 0) begin
				assign MOC = 0;
				output_destination = {Mem[address], 24'd0};
				#7;
				assign MOC=1;
			end
			else begin
				assign MOC = 0;
				Mem[address] = dataIn[31:24];
				#7;
				assign MOC=1;
		end
	end


end
endmodule