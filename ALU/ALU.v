module ALU_32_bit(a, b, operation, Result); 
    input [31:0] a; 
    input [31:0] b; 
    input [3:0] operation;
    
    output carryFlag;
    output overFlowFlag;
    output zeroFlag;
    output [31:0] Result; 
    reg [31:0] Result;

    integer index;
    integer counter = 0;
    integer val = 0;

    always@(a or b or operation) 
        begin 
            case (operation) 
            //Logic 
                4'b0000: // AND
                begin 
                    assign Result = a & b;
                end       

                4'b0001: // OR 
                begin 
                    assign Result = a | b;
                end

                4'b0010: // XOR
                begin 
                    assign Result = a ^ b;
                end

                4'b0011: // NOR
                begin 
                    assign Result = ~(a | b);
                end
               
            //Arithmethic Unsigned
                4'b0100: // addition
                begin 
                    assign {carryFlag, Result} = a + b;
                end

                4'b0101: // subtraction
                begin 
                    assign {carryFlag, Result} = a - b;
                end
            
            //Arithmethic Signed
                4'b0110: // addition
                begin 
                    assign Result = a + b;
                    assign overFlowFlag = (a[31]!= b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                    assign negativeFlag = (Result[31] == 1)? 1 : 0 ; 
                    assign zeroFlag = (Result == 0) ? 1 : 0;
                end

                4'b0111: // subtraction
                begin 
                    assign Result = a - b;
                    assign overFlowFlag = (a[31]!= b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                    assign negativeFlag = (Result[31] == 1)? 1 : 0 ; 
                    assign zeroFlag = (Result == 0) ? 1 : 0;
                end

            //Shifts
                4'b1000: // SLL
                begin 
                    assign Result = a << 1;
                end
                
                4'b1001: // SLLV
                begin
                    assign {carryFlag, Result} = a << b;
                end
                
                4'b1010: // SRL
                begin 
                    assign Result = a >> 1;
                end

                4'b1011: // SRLV
                begin
                    assign Result = a >> b;
                end

                4'b1100: // SLT: if result of a < b then return 1 else 0.
                        // SIGNED OPERATION. In verilog 0 == true, 1 == false
                begin
                    if ((a < b) == 0) begin
                        result = 1;
                    end else begin
                        result = 0;
                    end
                end

                4'b1101: // SLTU: if result of a < b then return 1 else 0.
                        // UNSIGNED OPERATION. In verilog 0 == true, 1 == false
                begin
                    if ((a < b) == 0) begin
                        result = 1;
                    end else begin
                        result = 0;
                    end
                end

                4'b1110: // CLO: count of leading ones in a, return in "result" the number of leading ones;
                begin
                    for(index = 31; index >= 0; index = index-1) begin  
                        if(a[index] == 1'b0) begin
                            val = 1;
                            index = -1;
                        end 
                        if(val == 0) begin
                            counter = counter + 1;
                        end
                    end
                    result = c;
                end
                end

                4'b1111: // CLZ: count of leading zeros in a, return in "result" the number of leading zeros.
                begin
                    for(index = 31; index >= 0; index = index-1) begin  
                        if(a[index] == 1'b1) begin
                            val = 1;
                            index = -1;
                        end 
                        if(val == 0) begin
                            counter = counter + 1;
                        end
                    end
                    result = c;
                end

            endcase 
        end
endmodule


//Main work is here
module main ();

  //Declare vars
  wire [31:0] out;
  wire carry;
  reg [31:0]in1, in2;
  reg [3:0]code;

  //Initialize vars
  initial begin
    in1 = 32 'b11111111111111111111111111111111;
    in2 = 32 'b11111111111111111111111111110000;
    code = 4'b0000;
  end

  ALU test(out, carry, code, in1, in2);

  initial begin
    #1
    $display("in1 = %b, in2 = %b, out = %b carry = %b", in1, in2, out, carry);
  end
endmodule