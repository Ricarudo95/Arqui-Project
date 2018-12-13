module muxA (output reg [4:0] result, input [1:0] s, input [4:0] zero, one, two);

  always @*
  case (s)
    2'b00: result = zero;
    2'b01: result =  one;
    2'b10: result = two;
    
    default: result = zero;
  endcase
endmodule

module mux4 (output reg [4:0] result, input s, input [4:0] zero, one);

  always @*
    if (s == 0) begin
      result = zero;
    end else begin
      result = one;
    end
endmodule

module mux32 (output reg [31:0] result, input s, input [31:0] zero, one);
  always @* 
  begin
    if (s == 1'b0) 
      begin
        result = zero;
      end
    else 
      begin
        result = one;
      end
  end
endmodule


