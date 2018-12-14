module MemoryTest1(address, output_destination, dataIn, rw, MOC);
 
input[31:0]   address;
input[31:0]   dataIn;
input rw;


output reg [31:0]  output_destination;
output MOC = 1;
  
//memory declaration
reg [7:0] Mem[0:511];

//Load Up Memory
initial begin
	$readmemb("Input/testcode_mips1.txt", Mem);
end
 
// behavior
always@(posedge rw) begin
	

 	if (rw == 1) begin // to read a specific word, you need to address its number. 
        	MOC = 0;
		assign output_destination = {Mem[address], Mem[address+1], Mem[address+2], Mem[address+3]};
		assign mem[address] <= dataIn[31:24];
		assign mem[address+1] <= dataIn[23:16];
		assign mem[address+2] <= dataIn[15:8];
		assign mem[address+3] <= dataIn[7:0];
		#13;
		MOC=1;
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