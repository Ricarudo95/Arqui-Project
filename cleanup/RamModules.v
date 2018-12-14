module MemoryTest1(address, output_destination, dataIn, rw, MOC, memEnable);
 
input[31:0]   address;
input[31:0]   dataIn;
input rw, memEnable;

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
	
	$display("We got In guys.... rw: %d", rw);
	if (rw == 0) begin
        	assign MOC = 0;
		$display("verify memory : %b%b%b%b", Mem[address],Mem[address+1],Mem[address+2],Mem[address+3]);
		$display("verify next memory : %b%b%b%b", Mem[address+5],Mem[address+6],Mem[address+7],Mem[address+8]);

		output_destination = {Mem[address], Mem[address+1], Mem[address+2], Mem[address+3]};
		$display("Output: %b",output_destination);
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
endmodule

//Loading Memory
module instructMemTest1(output [31:0] Instruction, input Enable, input[31:0]  PC);

	reg [7:0] Mem[0:511];

        initial begin
		$readmemb("Input/testcode_mips1.txt", Mem);
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