module ALU(Result, zeroFlag, operation, a, b); 
    input [31:0] a; 
    input [31:0] b; 
    input [5:0] operation;
    
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
            case (operation) 
            //Logic 
                6'b000000: // AND
                begin 
                    Result = a & b;
                end       

                6'b000001: // OR 
                begin 
                    Result = a | b;
                end

                6'b000010: // XOR
                begin 
                    Result = a ^ b;
                end

                6'b000011: // NOR
                begin 
                    Result = ~(a | b);
                end
               
            //Arithmethic Unsigned
                6'b000100: // addition
                begin 
                    //{carryFlag, Result} = a + b;
                    //overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                end

                6'b000101: // subtraction
                begin 
                    //{carryFlag, Result} = a - b;
                    //overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                end
            
            //Arithmethic Signed
                6'b000110: // addition
                begin
                    Result = $signed(a) + $signed(b);
                    //overFlowFlag = (a[31] != b[31])? 0 : (b[31] == Result[31]) ? 0: 1 ;
                    //negativeFlag = (Result[31] == 1)? 1 : 0 ; 
                    zeroFlag = (Result == 0) ? 1 : 0;
                end

                6'b000111: // subtraction
                begin
                    tempVar = (~b  + 1'b1);
                    Result = $signed(a) + $signed(tempVar);
                    //overFlowFlag = (a[31]!= tempVar[31])? 0 : (tempVar[31] == Result[31]) ? 0: 1 ;
                    //negativeFlag = (Result[31] == 1)? 1 : 0 ; 
                    zeroFlag = (Result == 0) ? 1 : 0;
                end

            //Shifts
                6'b001000: // SLL
                begin 
                    Result = a << 1;
                end
                
                6'b001001: // SLLV
                begin
                    //{carryFlag, Result} = a << b;
                end
                
                6'b001010: // SRL
                begin 
                    Result = a >> 1;
                end

                6'b001011: // SRLV
                begin
                    Result = a >> b;
                end

                6'b001100: // SLT 0 == true 1 == false because of verilog
                begin
                    if ((a < b) == 0) begin
                        Result = 1;
                    end else begin
                        Result = 0;
                    end
                end

                6'b001101: // SLTU
                begin
                    if ((a < b) == 0) begin
                        Result = 1;
                    end else begin
                        Result = 0;
                    end
                end

                6'b001110: // CLO
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
                

                6'b001111: // CLZ
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

                6'b010000: // SRA
                begin 
                    Result = a >>> 1;
                end

                6'b010001: // SRAV
                begin
                    Result = a >>> b;
                end

            endcase 
        end
endmodule

module aluCtrl (output reg [5:0] result, input [4:0] aluOp, input [5:0]funcIn);

  always @(aluOp, funcIn)
    case (aluOp)
      
      6'b000000: assign result = funcIn;

      ///////////////////////EXCEPTIONS///////////////////////////////////
      6'b000001: //functions for CLO and CLZ
        
        if (funcIn == 6'b100001) begin
          result = 6'b111000;
        end else if (funcIn == 6'b100000) begin
          result = 6'b000111;
        end
      ///////////////////////EXCEPTIONS///////////////////////////////////

      ///////////////////////IMMEDIATES///////////////////////////////////
      6'b000010: // ADDI and ADDIU
        assign result = 6'b100000; // simply use ADD function regardless of result
      
      6'b000011: // SLTI and SLTIU
        assign result = 6'b100000; // (rs < imm16) ? rt = 1 : rt = 0; ...  for comparison operation, subtract values
      
      6'b000100: // ANDI
        assign result = 6'b100100; // use AND function
      
      6'b000101: // ORI
        assign result = 6'b100101; // use OR function
      
      6'b000110: // XORI
        assign result = 6'b100110; // use XOR function
      
      // 6'000111: // LUI, primeros rt[31:16] = imm16 ..... rt[15:0] = 0
      //   assign result = 6'b100110; // use LUI function
      ///////////////////////IMMEDIATES///////////////////////////////////

      ///////////////////////STORE AND LOADS///////////////////////////////////

      6'b001000: // LW
        assign result = 6'b100000; // load value in memory [rs + imm16]
      
      // 6'b01000: // LH
      //   assign result = 6'b100000; // load half word with sign extention in memory [rs + imm16]
      
      6'b001001: // LHU
        assign result = 6'b100000; // load half word with NO sign extention in memory [rs + imm16]
      
      6'b001010: // LB
        assign result = 6'b100000; // load byte in memory with sign extended [rs + imm16]
      6'b001011: // LBU
        assign result = 6'b100000; // load byte in memory NO sign extended [rs + imm16]

      6'b001100: // SD 
        assign result = 6'b100000; // STORE double word in memory [rs + imm16]
      
      6'b001101: // SW
        assign result = 6'b100000; // STORE word in memory [rs + imm16]
      
      6'b001110: // SH
        assign result = 6'b100000; // STORE half word in memory [rs + imm16]

      6'b001111: // SB
        assign result = 6'b100000; // STORE byte in memory [rs + imm16]
      
      6'b010000: // B
        assign result = 6'd52; // BRANCH
      
      // 6'b10001: // BAL
      //   assign result = 6'b100000; // 

      // 6'b10010: // BEQ
      //   assign result = 6'b100000; // 

      // 6'b10011: // BGEZ
      //   assign result = 6'b100000; // 

      // 6'b10100: // BGEZAL
      //   assign result = 6'b100000; // 

      6'b010101: // BGTZ
        assign result = 6'd50; // 

      6'b010110: // BLEZ
        assign result = 6'd54; // 
      
      6'b010111: // BLTZ
        assign result = 6'b100000; // 

    default: assign result = funcIn;
    endcase
endmodule

