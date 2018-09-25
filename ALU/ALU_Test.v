// //Author: Roberto Y.  Guzmán Ortíz

// module ALU32bit(output reg [31:0] result, output reg C_flag, N_flag, Z_flag, V_flag, input [4:0]opCode, input [31:0] a, b);
//   reg [31:0 ]temp1;
//   integer index;
//   integer counter = 0;
//   integer val = 0;

//   always @(opCode,a, b)
//     case(opCode)
//       5'd0: // AND 
//         begin
//           assign result = a & b;
//         end

//       5'd1: // OR
//         begin
//           assign result = a | b;
//         end

//       5'd2: // XOR
//         begin
//           assign result = a ^ b;
//         end

//       5'd3: // NOR 
//         begin
//           assign result = ~(a | b);
//         end

//       5'd4: // SLL
//         begin
//           assign {C_flag,result} = a << 1;
//         end

//       5'd5: // SLLV
//         begin
//           assign {C_flag, result} = a << b;
//         end

//       5'd6: // SRL
//         begin
//           assign {C_flag, result} = a >> 1;
//         end

//       5'd7: // SRLV
//         begin
//           assign {C_flag, result} = a >> b;
//         end

//       5'd8: // ADDU: sum unsigned
//         begin
//           assign {C_flag,result} = a + b;
//         end

//       5'd9: // SUBU: sub unsigned
//         begin 
//           assign {C_flag,result} = a - b;      
//         end

//       5'd10: // ADD: addition signed
//         begin
//           assign result = $signed(a) + $signed(b);
//           assign V_flag = (a[31] != b[31])? 0 : (b[31] == result[31]) ? 0: 1 ;
//           assign N_flag = (result[31] == 1)? 1 : 0 ; 
//           assign Z_flag = (result == 0) ? 1 : 0;
//         end

//       5'd11: // SUB: subtract signed
//         begin
//           temp1 = (~b  + 1'b1);
//           assign result = $signed(a) + $signed(temp1);
//           assign V_flag = (a[31]!= temp1[31])? 0 : (temp1[31] == result[31]) ? 0: 1 ;
//           assign N_flag = (result[31] == 1)? 1 : 0 ; 
//           assign Z_flag = (result == 0) ? 1 : 0;
//         end
//       5'd12:
//         begin
//           // SLT: if result of a < b then return 1 else 0.
//           assign result = ($signed(a) < $signed(b)) ? 1 : 0;
//         end

//       5'd13:
//         begin
//           // SLTU: if result of a < b then return 1 else 0.
//           assign result = (a < b) ? 1 : 0;
//         end

//       5'd14:
//          begin
//           // CLO: count of leading ones in a, return in "result" the number of leading ones;
//           counter = 0;
//           index = 0;
//           while (a[index] == 1'b1) begin
//             counter = counter + 1;
//             index = index + 1;
//           end
//           assign result = counter;
//         end

//       5'd15:
//         begin
//           // CLZ: count of leading zeros in a, return in "result" the number of leading zeros.
//           counter = 0;
//           index = 0;
//           while (a[index] == 1'b0) begin
//             counter = counter + 1;
//             index = index + 1;
//           end
//           assign result = counter;
//         end
//     endcase
// endmodule

//MAIN MODULE
module main ();

  /////////////////////VARIABLE DECLARATION/////////////////////
  
  //inputs
  reg [31:0] r1, r2;
  reg [3:0] code;

  //outputs
  wire  [31:0] result;
  wire carry;
  wire negative;
  wire zero;
  wire overflow;

  //operation name
  reg [8*6:1] opName;

  // simulation time
  parameter sim_time = 1900;

  // ALU module initialization
  ALU_32_bit testALU(result, carry, negative, zero, overflow, code, r1, r2);

  initial #sim_time $finish;
  /////////////////////VARIABLE DECLARATION/////////////////////



  /////////////////////SET VALUES TO TEST/////////////////////
  initial begin
    opName = "AND"; r1 = 32'h0; r2 = 32'd0; code = 5'd0;
    #10 opName = "AND"; r1 = 32'h00000000; r2 = 32'hFFFFFFFF; 
    #10 opName = "AND"; r1 = 32'hFFFFFFFF; r2 = 32'h00000000;
    #10 opName = "AND"; r1 = 32'hFFFFFFFF; r2 = 32'hFFFFFFFF;
    #10 opName = "AND"; r1 = 32'hAAAAAAAA; r2 = 32'hFFFFFFFF;
    #10 opName = "AND"; r1 = 32'hAAAAAAAA; r2 = 32'h55555555;
    #10 opName = "AND"; r1 = 32'h12345678; r2 = 32'h9ABCDEF0;
    #10 $display("");

    opName = "OR"; r1 = 32'h0; r2 = 32'd0; code = 5'd1;
    #10 opName = "OR"; r1 = 32'h00000000; r2 = 32'hFFFFFFFF; 
    #10 opName = "OR"; r1 = 32'hFFFFFFFF; r2 = 32'h00000000;
    #10 opName = "OR"; r1 = 32'hFFFFFFFF; r2 = 32'hFFFFFFFF;
    #10 opName = "OR"; r1 = 32'hAAAAAAAA; r2 = 32'hFFFFFFFF;
    #10 opName = "OR"; r1 = 32'hAAAAAAAA; r2 = 32'h55555555;
    #10 opName = "OR"; r1 = 32'h12345678; r2 = 32'h9ABCDEF0;
    #10 $display("");

    opName = "XOR"; r1 = 32'h0; r2 = 32'd0; code = 5'd2;
    #10 opName = "XOR"; r1 = 32'h00000000; r2 = 32'hFFFFFFFF; 
    #10 opName = "XOR"; r1 = 32'hFFFFFFFF; r2 = 32'h00000000;
    #10 opName = "XOR"; r1 = 32'hFFFFFFFF; r2 = 32'hFFFFFFFF;
    #10 opName = "XOR"; r1 = 32'hAAAAAAAA; r2 = 32'hFFFFFFFF;
    #10 opName = "XOR"; r1 = 32'hAAAAAAAA; r2 = 32'h55555555;
    #10 opName = "XOR"; r1 = 32'h12345678; r2 = 32'h9ABCDEF0;
    #10 $display("");

    opName = "NOR"; r1 = 32'h0; r2 = 32'd0; code = 5'd3;
    #10 opName = "XOR"; r1 = 32'h00000000; r2 = 32'hFFFFFFFF; 
    #10 opName = "XOR"; r1 = 32'hFFFFFFFF; r2 = 32'h00000000;
    #10 opName = "XOR"; r1 = 32'hFFFFFFFF; r2 = 32'hFFFFFFFF;
    #10 opName = "XOR"; r1 = 32'hAAAAAAAA; r2 = 32'hFFFFFFFF;
    #10 opName = "XOR"; r1 = 32'hAAAAAAAA; r2 = 32'h55555555;
    #10 opName = "XOR"; r1 = 32'h12345678; r2 = 32'h9ABCDEF0;
    #10 $display("");
    
    opName = "SLL"; r1 = 32'h0; r2 = 32'd0; code = 5'd4;
    #10 $display("");

    opName = "SLLV"; r1 = 32'h0; r2 = 32'd0; code = 5'd5;
    #10 $display("");

    opName = "SRL"; r1 = 32'h0; r2 = 32'd0; code = 5'd6;
    #10 $display("");

    opName = "SRLV"; r1 = 32'h0; r2 = 32'd0; code = 5'd7;
    #10 $display("");

    opName = "ADDU"; r1 = 32'h0; r2 = 32'd0; code = 5'd8;
    #10 $display("");

    opName = "SUBU"; r1 = 32'h0; r2 = 32'd0; code = 5'd9;
    #10 $display("");

    opName = "ADD"; r1 = 32'h0; r2 = 32'd0; code = 5'd10;
    #10 $display("");

    opName = "SUB"; r1 = 32'h0; r2 = 32'd0; code = 5'd11;
    #10 $display("");

    opName = "SLT"; r1 = 32'h0; r2 = 32'd0; code = 5'd12;
    #10 $display("");

    opName = "SLTU"; r1 = 32'h0; r2 = 32'd0; code = 5'd13;
    #10 $display("");

    opName = "CLO"; r1 = 32'h0; r2 = 32'd0; code = 5'd14;
    #10 $display("");

    opName = "CLZ"; r1 = 32'h0; r2 = 32'd0; code = 5'd15;
    #10 $display("");

  end
  /////////////////////SET VALUES TO TEST/////////////////////


  /////////////////////DO THE THING/////////////////////

  initial begin
    $display ("time         opName          r1          r2          carry         code          FLAGS(NZCV)                    out-bin                       out-decimal");
    $monitor ("%4d        %s         %h    %h        %b           %b            %b%b%b%b            %b          %d", $time, opName, r1, r2, carry, code, negative, zero, carry, overflow, result, result);
  end
 /////////////////////DO THE THING/////////////////////

endmodule