module main ();

  reg [31:0] a, b;
  reg [3:0] op;

  wire  [31:0] ans;
  wire carry;
  wire neg;
  wire zero;
  wire over;
  reg [8*6:1] operation;
  parameter timer = 1900;

  ALU test(ans, carry, neg, zero, over, op, a, b); //ALU

  initial #timer $finish;

  initial begin
    operation = "AND"; a = 32'h0; b = 32'd0; op = 5'd0;
    #10 operation = "AND"; a = 32'h00000000; b = 32'hFFFFFFFF; 
    #10 operation = "AND"; a = 32'hFFFFFFFF; b = 32'h00000000;
    #10 operation = "AND"; a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;
    #10 $display("");

    operation = "OR"; a = 32'h0; b = 32'd0; op = 5'd1;
    #10 operation = "OR"; a = 32'h00000000; b = 32'hFFFFFFFF; 
    #10 operation = "OR"; a = 32'hFFFFFFFF; b = 32'h00000000;
    #10 operation = "OR"; a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;
    #10 $display("");

    operation = "XOR"; a = 32'h0; b = 32'd0; op = 5'd2;
    #10 operation = "XOR"; a = 32'h00000000; b = 32'hFFFFFFFF; 
    #10 operation = "XOR"; a = 32'hFFFFFFFF; b = 32'h00000000;
    #10 operation = "XOR"; a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;
    #10 $display("");

    operation = "NOR"; a = 32'h0; b = 32'd0; op = 5'd3;
    #10 operation = "NOR"; a = 32'h00000000; b = 32'hFFFFFFFF; 
    #10 operation = "NOR"; a = 32'hFFFFFFFF; b = 32'h00000000;
    #10 operation = "NOR"; a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;
    #10 $display("");
    
    operation = "ADDU"; a = 32'h7; b = 32'd3; op = 5'd4;
    #10 $display("");

    operation = "SUBU"; a = 32'h2; b = 32'd1; op = 5'd5;
    #10 $display("");
    
    operation = "ADD"; a = 32'h9; b = 32'd1; op = 5'd6;
    #10 $display("");

    operation = "SUB"; a = 32'h9; b = 32'd3; op = 5'd7;
    #10 $display("");

    operation = "SLL"; a = 32'h1; b = 32'd1; op = 5'd8;
    #10 $display("");

    operation = "SLLV"; a = 32'h1; b = 32'd1; op = 5'd9;
    #10 $display("");

    operation = "SRL"; a = 32'h1; b = 32'd1; op = 5'd10;
    #10 $display("");

    operation = "SRLV"; a = 32'h1; b = 32'd2; op = 5'd11;
    #10 $display("");

    operation = "SLT"; a = 32'h1; b = 32'd1; op = 5'd12;
    #10 $display("");

    operation = "SLTU"; a = 32'h1; b = 32'd1; op = 5'd13;
    #10 $display("");

    operation = "CLO"; a = 32'h1; b = 32'd1; op = 5'd14;
    #10 $display("");

    operation = "CLZ"; a = 32'h1; b = 32'd1; op = 5'd15;
    #10 $display("");

  end

  initial begin
    $display ("time      operation       a       b        carry      opCode     N-Z-C-V       binary                      decimal");
    $monitor ("%4d     %s      %h  %h        %b         %b     %b%b%b%b      %b      %d", $time, operation, a, b, carry, op, neg, zero, carry, over, ans, ans);
  end

endmodule