module ALU(Result, zeroFlag, operation, a, b, opCode); 
    input [31:0] a; 
    input [31:0] b; 
    //Function Code
    input [5:0] operation;
    //OpCode 
    input [1:0] opCode;
    
    // output reg carryFlag;
    // output reg negativeFlag;
    // output reg overFlowFlag;
    output reg zeroFlag;
    output reg [31:0] Result; 
    

    integer index;
    integer counter = 0;
    integer var = 0;
    reg [31:0 ]tempVar;

    always@(a or b or operation) 
        begin 
            case (operation and opCode) 
            //Logic 
                6'b100100 and 2'b00: // AND
                begin 
                    Result = a & b;
                end       

                6'b100101 and 2'b00: // OR 
                begin 
                    Result = a | b;
                end

                6'b100110 and 2'b00: // XOR
                begin 
                    Result = a ^ b;
                end

                6'b100111 and 2'b00: // NOR
                begin 
                    Result = ~(a | b);
                end
               
            //Arithmethic Unsigned
                6'b100001 and 2'b00: // addition
                begin 
                    //{carryFlag, Result} = a + b;
                    //overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                end

                6'b100011 and 2'b00: // subtraction
                begin 
                    //{carryFlag, Result} = a - b;
                    //overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                end
            
            //Arithmethic Signed
                6'b100000 and 2'b00: // addition
                begin
                    Result = $signed(a) + $signed(b);
                    //overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                    //negativeFlag = (Result[31] == 1)? 1 : 0 ; 
                    zeroFlag = (Result == 0) ? 1 : 0;
                end

                6'b100010 and 2'b00: // subtraction
                begin
                    tempVar = (~b  + 1'b1);
                    Result = $signed(a) + $signed(tempVar);
                    //overFlowFlag = (a[31]!= tempVar[31])? 0 : (tempVar[31] == Result[31]) ? 0: 1 ;
                    //negativeFlag = (Result[31] == 1)? 1 : 0 ; 
                    zeroFlag = (Result == 0) ? 1 : 0;
                end

            //Shifts
                6'b000000 and 2'b00: // SLL
                begin 
                    Result = a << 1;
                end
                
                6'b000100 and 2'b00: // SLLV
                begin
                    //{carryFlag, Result} = a << b;
                end
                
                6'b000010 and 2'b00: // SRL
                begin 
                    Result = a >> 1;
                end

                6'b000110 and 2'b00: // SRLV
                begin
                    Result = a >> b;
                end

                6'b101010 and 2'b00: // SLT 0 == true 1 == false because of verilog
                begin
                    if ((a < b) == 0) begin
                        Result = 1;
                    end else begin
                        Result = 0;
                    end
                end

                6'b101011 and 2'b00: // SLTU
                begin
                    if ((a < b) == 0) begin
                        Result = 1;
                    end else begin
                        Result = 0;
                    end
                end

                6'b100001 and 2'b01: // CLO
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
                

                6'b100000 and 2'b01: // CLZ
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

                6'b000011 and 2'b00: // SRA
                begin 
                    Result = a >>> 1;
                end

                6'b000111 and 2'b00: // SRAV
                begin
                    Result = a >>> b;
                end

            endcase 
        end
endmodule