module ALU(Result, carryFlag, negativeFlag, overFlowFlag, zeroFlag, operation, a, b); 
    input [31:0] a; 
    input [31:0] b; 
    input [4:0] operation;
    
    output reg carryFlag;
    output reg negativeFlag;
    output reg overFlowFlag;
    output reg zeroFlag;
    output reg [31:0] Result; 
    

    integer index;
    integer counter = 0;
    integer var = 0;
    reg [31:0 ]tempVar;

    always@(a or b or operation) 
        begin 
            case (operation) 
            //Logic 
                5'b00000: // AND
                begin 
                    Result = a & b;
                end       

                5'b00001: // OR 
                begin 
                    Result = a | b;
                end

                5'b00010: // XOR
                begin 
                    Result = a ^ b;
                end

                5'b00011: // NOR
                begin 
                    Result = ~(a | b);
                end
               
            //Arithmethic Unsigned
                5'b00100: // addition
                begin 
                    {carryFlag, Result} = a + b;
                    overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                end

                5'b00101: // subtraction
                begin 
                    {carryFlag, Result} = a - b;
                    overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                end
            
            //Arithmethic Signed
                5'b00110: // addition
                begin
                    Result = $signed(a) + $signed(b);
                    overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                    negativeFlag = (Result[31] == 1)? 1 : 0 ; 
                    zeroFlag = (Result == 0) ? 1 : 0;
                end

                5'b00111: // subtraction
                begin
                    tempVar = (~b  + 1'b1);
                    Result = $signed(a) + $signed(tempVar);
                    overFlowFlag = (a[31]!= tempVar[31])? 0 : (tempVar[31] == Result[31]) ? 0: 1 ;
                    negativeFlag = (Result[31] == 1)? 1 : 0 ; 
                    zeroFlag = (Result == 0) ? 1 : 0;
                end

            //Shifts
                5'b01000: // SLL
                begin 
                    Result = a << 1;
                end
                
                5'b01001: // SLLV
                begin
                    {carryFlag, Result} = a << b;
                end
                
                5'b01010: // SRL
                begin 
                    Result = a >> 1;
                end

                5'b01011: // SRLV
                begin
                    Result = a >> b;
                end

                5'b01100: // SLT 0 == true 1 == false because of verilog
                begin
                    if ((a < b) == 0) begin
                        Result = 1;
                    end else begin
                        Result = 0;
                    end
                end

                5'b01101: // SLTU
                begin
                    if ((a < b) == 0) begin
                        Result = 1;
                    end else begin
                        Result = 0;
                    end
                end

                5'b01110: // CLO
                begin
                    for(index = 31; index >= 0; index = index-1) begin  
                        if(a[index] == 1'b0) begin
                            var = 1;
                            index = -1;
                        end 
                        if(var == 0) begin
                            counter = counter + 1;
                        end
                    end
                    Result = counter;
                end
                

                5'b01111: // CLZ
                begin
                    for(index = 31; index >= 0; index = index-1) begin  
                        if(a[index] == 1'b1) begin
                            var = 1;
                            index = -1;
                        end 
                        if(var == 0) begin
                            counter = counter + 1;
                        end
                    end
                    Result = counter;
                end

                5'b10000: // SRA
                begin 
                    Result = a >>> 1;
                end

                5'b10001: // SRAV
                begin
                    Result = a >>> b;
                end

            endcase 
        end
endmodule


