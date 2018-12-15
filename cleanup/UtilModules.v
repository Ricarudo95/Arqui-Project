//File Contaning all add modules

module addplus4 (output [31:0] result, input [31:0] pc);
    assign result = pc + 4;
endmodule

module adder (output reg [31:0] result, input [31:0] entry1, entry0);
  
  always @(entry1, entry0)
  result = entry0 + entry1 ;
endmodule

module AND (output reg result, input branch, condition);

  always @*
  result = branch & condition;
endmodule

module shftLeft28(output reg [27:0] result, input [25:0] in);

  always @(in)
  //hold = 27'd0 + in;
  result = in << 2;
endmodule

module signExtender (output reg [31:0] result, input [15:0] ins, input unSign);

  reg [15:0] tempOnes = 16'b1111111111111111;
  reg [15:0] tempZero = 16'b0000000000000000;

  always @(ins)
  
  if (ins[15] == 1 || unSign == 1'b0) begin
    result = {tempOnes, ins};
  end else begin
    result = {tempZero, ins};
  end

endmodule

module shftLeft(output reg [31:0] result, input [31:0] in);

  always @(in)

  result = in << 2;

endmodule

module register(output reg [31:0] result, input [31:0] in, input load, clk); 
  always @(posedge clk) begin
    if(load==1)
      result = in;
  end
endmodule