//File Contaning all add modules

module addplus4 (output [31:0] result, input [31:0] pc);
  
  assign result = pc + 4;
endmodule

module adder (output reg [31:0] result, input [31:0] entry1, entry0);
  
  always @(entry1, entry0)
  result = entry0 + entry1 ;
endmodule

module AND (output reg result, input J, Z_flag);

  always @(J, Z_flag)
  result = J & Z_flag;
endmodule

module shftLeft28(output reg [27:0] result, input [25:0] in);

  always @(in)
  //hold = 27'd0 + in;
  result = in << 2;
endmodule

module signExtender (output reg [31:0] result, input [15:0] ins);

  reg [15:0] tempOnes = 16'b1111111111111111;
  reg [15:0] tempZero = 16'b0000000000000000;

  always @(ins)
  
  if (ins[15] == 0) begin
    result = {tempZero, ins};
  end else begin
    result = {tempOnes, ins};
  end

endmodule

module shftLeft(output reg [31:0] result, input [31:0] in);

  always @(in)

  result = in << 2;

endmodule