module ALU(Result, condition, operation, a, b); 
    input [31:0] a; 
    input [31:0] b; 
    //Function Code
    input [5:0] operation;
    
    output reg carryFlag;
    output reg condition;
    output reg negativeFlag;
    output reg overFlowFlag;
    output reg zeroFlag;
    output reg [31:0] Result;
    

    integer index;
    integer counter = 0;
    integer var = 0;
    reg [31:0] tempVar;

    initial begin
    zeroFlag = 1'b0;
    condition=0;
    end

    always@(a or b or operation) 
        begin
        /*case (aluCode)

            3'b001: //equals
                begin
                    if($signed(a) == $signed(b))
                    begin
                        zeroFlag = 1'd1;
                    end
                    else
                    begin
                        zeroFlag = 1'd0;
                    end
                end

            3'b010: //Less than
                begin
                    Result = ($signed(a) < $signed(b)) ? 1: 0;
                    zeroFlag = (Result == 0) ? 1'b1 : 1'b0;
                    //overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                end    

            3'b011: //Greater than
                begin
                    Result = ($signed(a) > $signed(b)) ? 1: 0;
                    zeroFlag = (Result == 0) ? 1'b1 : 1'b0;
                    //overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                end

            3'b100: //CLO and CLZ
                begin
                    //CLO
                    if(operation == 6'b100001) 
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
                    //CLZ
                    else if(operation == 6'b100000)
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
                end

            3'b101: //add immediate
                begin
                    Result = a + b;
                    //overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                end

            3'b110: //add immediate signed
                begin
                    Result = $signed(a) + $signed(b);
                    //overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                    //negativeFlag = (Result[31] == 1)? 1 : 0 ; 
                end*/

            //3'b000: //Arithmetic
                //begin            
                    case (operation)

                    6'b011111: //always
                        begin
                            if(1)
                            condition=1;
                        else
                            condition=0;
                        end
                    
                    6'b011011: //equal 0
                        begin
                            if($signed(a) == 0)
                            condition=1;
                        else
                            condition=0;
                        end

                    6'b110111: //Less than
                    begin
                    Result = ($signed(a) < $signed(b)) ? 1: 0;
                    zeroFlag = (Result == 0) ? 1'b1 : 1'b0;
                    negativeFlag = (Result[31] == 1)? 1 : 0 ; 
                    //overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                    end    

                    6'b001111: //Greater than
                    begin
                        $display("Whats happeining in here");
                        $display("The question is %d grater than %d", $signed(a), $signed(b));
                        // Result = ($signed(a) > $signed(b)) ? 0: 1;
                        // zeroFlag = (Result == 0) ? 1'b1 : 1'b0;
                        // negativeFlag = (Result[31] == 1)? 1 : 0 ;
                        // condition = (zeroFlag == 0 && negativeFlag==0)? 1:0; 
                        //overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                        if ($signed(a) > $signed(b)) begin
                            $display("It works");
                            condition=1;
                        end
                        else begin
                            $display("It dont work");
                            condition=0;
                        end
                    end

                    6'b001101: //Greater than Zero
                    begin
                        $display("Whats happeining in here");
                        $display("The question is %d grater than %d", $signed(a), $signed(b));
                        // Result = ($signed(a) > $signed(b)) ? 0: 1;
                        // zeroFlag = (Result == 0) ? 1'b1 : 1'b0;
                        // negativeFlag = (Result[31] == 1)? 1 : 0 ;
                        // condition = (zeroFlag == 0 && negativeFlag==0)? 1:0; 
                        //overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                        if ($signed(a) > 0) begin
                            $display("It works");
                            condition=1;
                        end
                        else begin
                            $display("It dont work");
                            condition=0;
                        end
                    end

                    6'b010011: //Less than Zero or equal
                    begin
                        $display("Whats happeining in here");
                        $display("The question is %d less than %d", $signed(a), $signed(b));
                        if ($signed(a) <= 0) begin
                            $display("It works");
                            condition=1;
                        end
                        else begin
                            $display("It dont work");
                            condition=0;
                        end
                    end


                    //Move
                        6'b111111: // MOVN
                            begin 
                                Result = b;
                            end
                    //Move
                        6'b001011: // MOVN
                            begin 
                                if(b != 0)
                                begin
                                    Result = a;
                                end
                            end

                        6'b001010: // MOVZ
                            begin
                                if(b == 0)
                                begin
                                    Result = a;
                                end
                            end

                    //Logic 
                        6'b100100: // AND
                            begin 
                                Result = a & b;
                            end       

                        6'b100101: // OR 
                        begin 
                            Result = a | b;
                        end

                        6'b100110: // XOR
                        begin 
                            Result = a ^ b;
                        end

                        6'b100111: // NOR
                        begin 
                            Result = ~(a | b);
                        end
                    
                    //Arithmethic Unsigned
                        6'b100001: // addition
                        begin
                            {carryFlag, Result} = a + b;
                            overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                        end

                        6'b100011: // subtraction
                        begin 
                            {carryFlag, Result} = a - b;
                            overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                        end
                    
                    //Arithmethic Signed
                        6'b100000: // addition
                        begin
                            Result = $signed(a) + $signed(b);
                            overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                            negativeFlag = (Result[31] == 1)? 1 : 0 ; 
                            zeroFlag = (Result == 0) ? 1'b1 : 1'b0;
                        end

                        6'b100010: // subtraction
                        begin
                            tempVar = (~b  + 1'b1);
                            Result = $signed(a) + $signed(tempVar);
                            overFlowFlag = (a[31]!= tempVar[31])? 0 : (tempVar[31] == Result[31]) ? 0: 1 ;
                            negativeFlag = (Result[31] == 1)? 1 : 0 ; 
                            zeroFlag = (Result == 0) ? 1'b1 : 1'b0;
                        end

                    //Shifts
                        6'b000000: // SLL
                        begin 
                            Result = b << 1;
                        end
                        
                        6'b000100: // SLLV
                        begin
                            Result = b << a;
                        end
                        
                        6'b000010: // SRL
                        begin 
                            Result = b >> 1;
                        end

                        6'b000110: // SRLV
                        begin
                            Result = b >> a;
                        end

                        6'b101010: // SLT 0 == true 1 == false because of verilog
                        begin
                            if ((a < b) == 0) begin
                                Result = 1;
                            end else begin
                                Result = 0;
                            end
                        end

                        6'b101011: // SLTU
                        begin
                            if ((a < b) == 0) begin
                                Result = 1;
                            end else begin
                                Result = 0;
                            end
                        end

                        6'b011100: //CLO
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

                        6'b011101: //CLZ
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
                    
                        6'b000011: // SRA
                        begin 
                            Result = a >>> 1;
                        end

                        6'b000111: // SRAV
                        begin
                            Result = a >>> b;
                        end

                    endcase                
                end
endmodule