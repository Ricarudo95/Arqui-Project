module mips_cpu( input clk,reset,  output[31:0] pc_out, alu_result);  
  
    reg[31:0] next; //reg[31:0] pcIn; 
    wire [31:0] pcOut; //wire [31:0] pcout1, pcout2;  
    wire [31:0] instruction; //Intructions
    wire [4:0] regMuxOut; //wire [4:0] muxAout;
    //wire [4:0] muxBout; //    wire [4:0] muxBout;
    wire [31:0] signExtOut;
    wire [31:0] regOutA; //    wire [31:0] outA;
    wire [31:0] regOutB; //    wire [31:0] outB;
    wire [31:0] aluMuxOut; //    wire [31:0] muxCout;
    //wire [5:0] aluCtrlOut;
    wire [31:0] aluOut;
    wire zFlag;
    wire [31:0] RAMout;
    wire [31:0] ramMuxOut; //    wire [31:0] muxDout;

    wire [31:0] pcAdd4; //    wire [31:0] addAout;
    wire [27:0] shftLeft28Out;
    wire [31:0] shftLeftOut;
    wire [31:0] branchAddOut; //    wire [31:0] addBout;
    wire [31:0] branchMuxOut; //muxEout
    wire [31:0] jumpMuxOut; //muxFout
    wire andOut;
    //wire [4:0] HI, LO ;


    ////////// STATE FLAGS ////////////
    wire reg_dst;
    wire reg_write;
    wire aluSource;
    wire memRead;
    wire memWrite; //RW
    wire mem_to_reg;
    wire jump;  
    wire branch;  
    wire aluCode [2:0];
    //wire [1:0] HILO;
    //wire MOC;
    //wire MOV;

/////////////////////////COMPONENTS////////////////////////////////////

//Program Counter
ProgramCounter programCounter(next, pcOut, Reset, Clk, 1'b1);

//reg [511:0] PC = 512'd0;
//Intruction Memory
instructMemTest1 instruction(instruction, clk, pcOut);

//Control Unit
control controlUnit( instruction[31:26], reset, reg_dst, reg_write, aluSource, memRead, memWrite, mem_to_reg,jump, branch,aluCode);

//Mux Connections
//muxA BasicMux(muxAout, HILO, instruction[25:21], LO, HI); //not used
mux4 RegisterMux(regMuxOut, reg_dst, instruction[20:16], instruction[15:11]); //present
mux32 aluMux(aluMuxOut, aluSource, regOutB, signExtOut);
mux32 muxRAM(ramMuxOut, mem_to_reg, aluOut, RAMout);
mux32 branchMux(branchMuxOut, andOut, pcAdd4, branchAddOut);
//change muxFout name to next, muxEout to branchMuxOut, addAout to PCAdd4
mux32 jumpMux(jumpMuxOut, jump, branchMuxOut, {pcAdd4[31:28], shftLeft28Out}); 

//Register File
RegisterFile RegisterFile(muxAout, instruction[20:16], muxBout, muxDout, mem_to_reg, clk, outA, outB );

//ALU Modules
ALU alu(aluOut, zFlag, instruction[5:0], outA, signExtOut, aluCode);

//RAM Module
RAM ram(RAMout, MOC, RAMEnable, MOV, RW, outB, aluOut);


//Util Modules
signExtender signExt(signExtOut, instruction[15:0]);
shftLeft28 shftJump(shftLeft28Out, instruction[25:0]);
shftLeft shftLeft(shftLeftOut,signExtOut);
addplus4 addFour(addAout, pcout2);
adder adder(addBout, addAout, shftLeftOut);
AND simpleAND(andOut, zFlag, branch);

endmodule  