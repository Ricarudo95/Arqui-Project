module ALU_32_bit(Result, carryFlag, negativeFlag, overFlowFlag, zeroFlag, operation, a, b); 
    input [31:0] a; 
    input [31:0] b; 
    input [3:0] operation;
    
    output reg carryFlag;
    output reg negativeFlag;
    output reg overFlowFlag;
    output reg zeroFlag;
    output reg [31:0] Result; 
    

    integer index;
    integer counter = 0;
    integer val = 0;
    reg [31:0 ]temp1;

    always@(a or b or operation) 
        begin 
            case (operation) 
            //Logic 
                4'b0000: // AND
                begin 
                    Result = a & b;
                end       

                4'b0001: // OR 
                begin 
                    Result = a | b;
                end

                4'b0010: // XOR
                begin 
                    Result = a ^ b;
                end

                4'b0011: // NOR
                begin 
                    Result = ~(a | b);
                end
               
            //Arithmethic Unsigned
                4'b0100: // addition
                begin 
                    {carryFlag, Result} = a + b;
                end

                4'b0101: // subtraction
                begin 
                    {carryFlag, Result} = a - b;
                end
            
            //Arithmethic Signed
                4'b0110: // addition
                begin
                    Result = $signed(a) + $signed(b);
                    overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                    negativeFlag = (Result[31] == 1)? 1 : 0 ; 
                    zeroFlag = (Result == 0) ? 1 : 0;
                end

                4'b0111: // subtraction
                begin
                    temp1 = (~b  + 1'b1);
                    Result = $signed(a) + $signed(temp1);
                    overFlowFlag = (a[31]!= temp1[31])? 0 : (temp1[31] == Result[31]) ? 0: 1 ;
                    negativeFlag = (Result[31] == 1)? 1 : 0 ; 
                    zeroFlag = (Result == 0) ? 1 : 0;
                end

            //Shifts
                4'b1000: // SLL
                begin 
                    Result = a << 1;
                end
                
                4'b1001: // SLLV
                begin
                    {carryFlag, Result} = a << b;
                end
                
                4'b1010: // SRL
                begin 
                    Result = a >> 1;
                end

                4'b1011: // SRLV
                begin
                    Result = a >> b;
                end

                4'b1100: // SLT: if Result of a < b then return 1 else 0.
                        // SIGNED OPERATION. In verilog 0 == true, 1 == false
                begin
                    if ((a < b) == 0) begin
                        Result = 1;
                    end else begin
                        Result = 0;
                    end
                end

                4'b1101: // SLTU: if Result of a < b then return 1 else 0.
                        // UNSIGNED OPERATION. In verilog 0 == true, 1 == false
                begin
                    if ((a < b) == 0) begin
                        Result = 1;
                    end else begin
                        Result = 0;
                    end
                end

                4'b1110: // CLO: count of leading ones in a, return in "Result" the number of leading ones;
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
                    Result = counter;
                end
                

                4'b1111: // CLZ: count of leading zeros in a, return in "Result" the number of leading zeros.
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
                    Result = counter;
                end

            endcase 
        end
endmodule


