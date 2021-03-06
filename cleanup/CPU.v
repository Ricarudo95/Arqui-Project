module mipsCPUData1(clk,reset);  

    input  clk;
    input reset;


////////////// CIRCUIT CONNECTIONS ///////////////

    //MDR
    wire [31:0] mdrData;
    //MAR
    wire [31:0] memAdress;

    //Program Counter And Intructions
    wire [31:0] next;
    wire [31:0] pcOut; 
    wire [31:0] instruction;
    
    //Register
    wire [31:0] marInput;
    wire [31:0] regOutA; 
    wire [31:0] regOutB;
    wire [4:0] regMuxOut; 

    //ALU
    wire [31:0] aluB;
    wire [31:0] aluOut;
    wire zFlag;
    wire [5:0] func;

    //Ram
    wire [31:0] memData; //memData
    wire [31:0] mdrIn; //MDR input

    //Jump
    wire [31:0] pcAdd4; 
    wire [27:0] shftLeft28Out;
    wire [31:0] jumpMuxOut;


    //Branch
    wire [31:0] signExtOut;
    wire [31:0] shftLeftOut;
    wire [31:0] branchAddOut;
    wire [31:0] branchSelect;
    wire andOut;


////////// STATE FLAGS ////////////
    wire MOC;
    wire memEnable;
    wire unSign;

    wire irLoad;
    wire pcLoad;
    wire npcLoad;
    wire rfSource;
    wire regWrite; 
    wire jump; 
    wire branch;
    wire immediate;
    wire rw;
    wire byte;
    wire marLoad;
    wire mdrLoad;
    wire mdrSource;
    wire pcSelect;
    wire [1:0] aluSource;
    wire [5:0] aluCode;


/////////////////////////COMPONENTS////////////////////////////////////

//MAR and MDR
register MAR(memAdress, marInput, marLoad,clk);
register MDR(mdrData, mdrIn, mdrLoad,clk);
register NPC(next, jumpMuxOut,npcLoad,clk);
register IR(instruction, memData, irLoad,clk);

//Program Counter
ProgramCounter Program_Counter(next, pcOut, reset, clk, pcLoad);

//Control Unit
control Control_Unit(clk, reset, MOC, instruction[31:26], unSign, memEnable, irLoad, pcLoad, npcLoad, rfSource, regWrite, jump, branch, immediate, rw, byte, marLoad, mdrLoad, mdrSource, pcSelect, aluSource, aluCode);

//Mux Connections
//muxA BasicMux(muxAout, HILO, instruction[25:21], LO, HI); //not used

mux32 pcMux(marInput, pcSelect, aluOut, pcOut);
mux6 funcMux(func, immediate, instruction[5:0], aluCode);
mux4 Register_Mux(regMuxOut, rfSource, instruction[20:16], instruction[15:11]); //present
//mux32 ALU_Mux(aluB, aluSource, regOutB, signExtOut);
mux4inputs ALU_Mux(aluB, aluSource, regOutB, signExtOut, mdrData, 32'd0);
mux32 mdrMux(mdrIn, mdrSource, memData, aluOut);
mux32 Branch_Mux(branchSelect, andOut, pcAdd4, branchAddOut);
mux32 Jump_Mux(jumpMuxOut, jump, branchSelect, {pcAdd4[31:28], shftLeft28Out});


//Register File
RegisterFile Register_File(instruction[25:21], instruction[20:16], regMuxOut, mdrIn, regWrite, clk, regOutA, regOutB );

//ALU Modules
ALU alu(aluOut, zFlag, func, regOutA, aluB);

//RAM Module
MemoryTest1 Memory(memAdress, memData, mdrData, rw, byte, MOC, memEnable);


//Util Modules
signExtender signExt(signExtOut, instruction[15:0], unSign);
shftLeft28 shftJump(shftLeft28Out, instruction[25:0]);
shftLeft shftLeft(shftLeftOut,signExtOut);
addplus4 addFour(pcAdd4, pcOut);
adder adder(branchAddOut, pcOut, shftLeftOut);
AND simpleAND(andOut, branch, zFlag);


////////// MONITOR ////////////
// initial begin
// $dumpvars(0,instruction);
// $monitor("Intructions [B]", instruction);
// end

endmodule 

module mipsCPUData2(clk,reset);  

    input  clk;
    input reset;


////////////// CIRCUIT CONNECTIONS ///////////////

    //MDR
    wire [31:0] mdrData;
    //MAR
    wire [31:0] memAdress;

    //Program Counter And Intructions
    wire [31:0] next;
    wire [31:0] pcOut; 
    wire [31:0] instruction;
    
    //Register
    wire [31:0] marInput;
    wire [31:0] regOutA; 
    wire [31:0] regOutB;
    wire [4:0] regMuxOut; 

    //ALU
    wire [31:0] aluB;
    wire [31:0] aluOut;
    wire zFlag;
    wire [5:0] func;

    //Ram
    wire [31:0] memData; //memData
    wire [31:0] mdrIn; //MDR input

    //Jump
    wire [31:0] pcAdd4; 
    wire [27:0] shftLeft28Out;
    wire [31:0] jumpMuxOut;
    wire [31:0] jumpRegisterMuxIn;


    //Branch
    wire [31:0] signExtOut;
    wire [31:0] shftLeftOut;
    wire [31:0] branchAddOut;
    wire [31:0] branchSelect;
    wire andOut;


////////// STATE FLAGS ////////////
    wire MOC;
    wire memEnable;
    wire unSign;

    wire irLoad;
    wire pcLoad;
    wire npcLoad;
    wire rfSource;
    wire regWrite; 
    wire jump; 
    wire jumpRFlag;
    wire branch;
    wire immediate;
    wire rw;
    wire byte;
    wire marLoad;
    wire mdrLoad;
    wire mdrSource;
    wire pcSelect;
    wire [1:0] aluSource;
    wire [5:0] aluCode;


/////////////////////////COMPONENTS////////////////////////////////////

//MAR and MDR
register MAR(memAdress, marInput, marLoad,clk);
register MDR(mdrData, mdrIn, mdrLoad,clk);
register NPC(next, jumpMuxOut,npcLoad,clk);
register IR(instruction, memData, irLoad,clk);

//Program Counter
ProgramCounter Program_Counter(next, pcOut, reset, clk, pcLoad);

//Control Unit
control Control_Unit(clk, reset, MOC, instruction[31:26], unSign, memEnable, irLoad, pcLoad, npcLoad, rfSource, regWrite, jump, branch, immediate, rw, byte, marLoad, mdrLoad, mdrSource, pcSelect, aluSource, aluCode);

//Mux Connections
//muxA BasicMux(muxAout, HILO, instruction[25:21], LO, HI); //not used

mux32 pcMux(marInput, pcSelect, aluOut, pcOut);
mux6 funcMux(func, immediate, instruction[5:0], aluCode);
mux4 Register_Mux(regMuxOut, rfSource, instruction[20:16], instruction[15:11]); //present
//mux32 ALU_Mux(aluB, aluSource, regOutB, signExtOut);
mux4inputs ALU_Mux(aluB, aluSource, regOutB, signExtOut, mdrData, 32'd0);
mux32 mdrMux(mdrIn, mdrSource, memData, aluOut);
mux32 Branch_Mux(branchSelect, andOut, pcAdd4, branchAddOut);
//rewired for JR tester 2
mux32 Jump_Mux(jumpRegisterMuxIn, jump, branchSelect, {pcAdd4[31:28], shftLeft28Out});
mux32 JR_Mux(jumpMuxOut, jumpRFlag, jumpRegisterMuxIn, regOutA);


//Register File
RegisterFile Register_File(instruction[25:21], instruction[20:16], regMuxOut, mdrIn, regWrite, clk, regOutA, regOutB );

//ALU Modules
ALU alu(aluOut, zFlag, func, regOutA, aluB);

//RAM Module
MemoryTest1 Memory(memAdress, memData, mdrData, rw, byte, MOC, memEnable);


//Util Modules
signExtender signExt(signExtOut, instruction[15:0], unSign);
shftLeft28 shftJump(shftLeft28Out, instruction[25:0]);
shftLeft shftLeft(shftLeftOut,signExtOut);
addplus4 addFour(pcAdd4, pcOut);
adder adder(branchAddOut, pcOut, shftLeftOut);
AND simpleAND(andOut, branch, zFlag);


////////// MONITOR ////////////
// initial begin
// $dumpvars(0,instruction);
// $monitor("Intructions [B]", instruction);
// end

endmodule 

module mipsCPUData3(clk,reset);  

    input  clk;
    input reset;


////////////// CIRCUIT CONNECTIONS ///////////////

    //MDR
    wire [31:0] mdrData;
    //MAR
    wire [31:0] memAdress;

    //Program Counter And Intructions
    wire [31:0] next;
    wire [31:0] pcOut; 
    wire [31:0] instruction;
    
    //Register
    wire [31:0] marInput;
    wire [31:0] regOutA; 
    wire [31:0] regOutB;
    wire [4:0] regMuxOut; 

    //ALU
    wire [31:0] aluB;
    wire [31:0] aluOut;
    wire zFlag;
    wire [5:0] func;

    //Ram
    wire [31:0] memData; //memData
    wire [31:0] mdrIn; //MDR input

    //Jump
    wire [31:0] pcAdd4; 
    wire [27:0] shftLeft28Out;
    wire [31:0] jumpMuxOut;


    //Branch
    wire [31:0] signExtOut;
    wire [31:0] shftLeftOut;
    wire [31:0] branchAddOut;
    wire [31:0] branchSelect;
    wire andOut;


////////// STATE FLAGS ////////////
    wire MOC;
    wire memEnable;
    wire unSign;

    wire irLoad;
    wire pcLoad;
    wire npcLoad;
    wire rfSource;
    wire regWrite; 
    wire jump; 
    wire branch;
    wire immediate;
    wire rw;
    wire byte;
    wire marLoad;
    wire mdrLoad;
    wire mdrSource;
    wire pcSelect;
    wire [1:0] aluSource;
    wire [5:0] aluCode;


/////////////////////////COMPONENTS////////////////////////////////////

//MAR and MDR
register MAR(memAdress, marInput, marLoad,clk);
register MDR(mdrData, mdrIn, mdrLoad,clk);
register NPC(next, jumpMuxOut,npcLoad,clk);
register IR(instruction, memData, irLoad,clk);

//Program Counter
ProgramCounter Program_Counter(next, pcOut, reset, clk, pcLoad);

//Control Unit
control Control_Unit(clk, reset, MOC, instruction[31:26], unSign, memEnable, irLoad, pcLoad, npcLoad, rfSource, regWrite, jump, branch, immediate, rw, byte, marLoad, mdrLoad, mdrSource, pcSelect, aluSource, aluCode);

//Mux Connections
//muxA BasicMux(muxAout, HILO, instruction[25:21], LO, HI); //not used

mux32 pcMux(marInput, pcSelect, aluOut, pcOut);
mux6 funcMux(func, immediate, instruction[5:0], aluCode);
mux4 Register_Mux(regMuxOut, rfSource, instruction[20:16], instruction[15:11]); //present
//mux32 ALU_Mux(aluB, aluSource, regOutB, signExtOut);
mux4inputs ALU_Mux(aluB, aluSource, regOutB, signExtOut, mdrData, 32'd0);
mux32 mdrMux(mdrIn, mdrSource, memData, aluOut);
mux32 Branch_Mux(branchSelect, andOut, pcAdd4, branchAddOut);
mux32 Jump_Mux(jumpMuxOut, jump, branchSelect, {pcAdd4[31:28], shftLeft28Out});


//Register File
RegisterFile Register_File(instruction[25:21], instruction[20:16], regMuxOut, mdrIn, regWrite, clk, regOutA, regOutB );

//ALU Modules
ALU alu(aluOut, zFlag, func, regOutA, aluB);

//RAM Module
MemoryTest1 Memory(memAdress, memData, mdrData, rw, byte, MOC, memEnable);


//Util Modules
signExtender signExt(signExtOut, instruction[15:0], unSign);
shftLeft28 shftJump(shftLeft28Out, instruction[25:0]);
shftLeft shftLeft(shftLeftOut,signExtOut);
addplus4 addFour(pcAdd4, pcOut);
adder adder(branchAddOut, pcOut, shftLeftOut);
AND simpleAND(andOut, branch, zFlag);


////////// MONITOR ////////////
// initial begin
// $dumpvars(0,instruction);
// $monitor("Intructions [B]", instruction);
// end

endmodule 