module mips_cpu( input clk,reset,  output[31:0] pc_out, alu_result);  
  
    reg[31:0] pcIn;
      
    wire [31:0] pcout1, pcout2;  
    wire [31:0] ir; //Intructions
    wire [4:0] muxAout;
    wire [4:0] muxBout;
    wire [31:0] signExtOut;
    wire [31:0] outA;
    wire [31:0] outB;
    wire [31:0] muxCout;
    wire [5:0] aluCtrlOut;
    wire [31:0] aluOut;
    wire zFlag;
    wire [31:0] RAMout;
    wire [31:0] muxDout;

    wire [31:0] addAout;
    wire [27:0] shftLeft28Out;
    wire [31:0] shftLeftOut;
    wire [31:0] addBout;
    wire [31:0] muxEout;
    wire [31:0] muxFout;
    wire andOut;
    wire [4:0] HI, LO ;


    ////////// STATE FLAGS ////////////
    wire reg_dst;
    wire reg_write;
    wire alu_src;
    wire [5:0] alu_fnc;
    wire RAMEnable;
    wire RW;
    wire mem_to_reg;
    wire jump;  
    wire branch;  
    wire [1:0] HILO;
    wire MOC;
    wire MOV;






/////////////////////////COMPONENTS////////////////////////////////////

reg [511:0] PC = 512'd0;
//Intruction Memory
instructMem instruction(ir, clk, PC);

//Control Unit
control controlUnit( ir[31:26], reset, MOC, reg_dst, mem_to_reg, alu_fnc, HILO, MOV, RAMEnable, jump, branch, RW, alu_src, reg_write);

//Mux Connections
muxA BasicMux(muxAout, HILO, ir[25:21], LO, HI);
mux4 FourBitMux(muxBout, reg_dst, ir[20:16], ir[15:11]);
mux32 muxSE(muxCout, alu_src, outA, signExtOut);
mux32 muxRAM(muxCout,mem_to_reg, aluOut, RAMout);
mux32 MuxAdder(muxEout, andOut, addAout, addBout);
mux32 MuxF(muxFout, jump, muxEout, {shftLeft28Out, addAout[31:28]});

//Register File
RegisterFile RegisterFile(muxAout, ir[20:16], muxBout, muxDout, mem_to_reg, clk, outA, outB );

//ALU Modules
ALU alu(aluOut,zFlag, aluCtrlOut,outA, signExtOut);
aluCtrl aluControl(aluCtrlOut,ir[4:0], alu_fnc);

//RAM Module
RAM ram(RAMout, MOC, RAMEnable, MOV, RW, outB, aluOut);


//Util Modules
signExtender signExt(signExtOut, ir[15:0]);
shftLeft28 shftJump(shftLeft28Out, ir[25:0]);
shftLeft shftLeft(shftLeftOut,signExtOut);
addplus4 addFour(addAout, pcout2);
adder adder(addBout, addAout, shftLeftOut);
AND simpleAND(andOut, zFlag, branch);

endmodule  