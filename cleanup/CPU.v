module mipsCPU(clk,reset);  

    input  clk;
    input reset;
  

////////////// CIRCUIT CONNECTIONS ///////////////

    //Program Counter And Intructions
    reg[31:0] next;
    wire [31:0] pcOut; 
    wire [31:0] instruction;
    
    //Register
    wire [31:0] regOutA; 
    wire [31:0] regOutB;
    wire [4:0] regMuxOut; 

    //ALU
    wire [31:0] aluMuxOut; 
    wire [31:0] aluOut;
    wire zFlag;

    //Ram
    wire [31:0] ramOut;
    wire [31:0] ramMuxOut;

    //Jump
    wire [31:0] pcAdd4; 
    wire [27:0] shftLeft28Out;
    wire [31:0] jumpMuxOut;


    //Branch
    wire [31:0] signExtOut;
    wire [31:0] shftLeftOut;
    wire [31:0] branchAddOut;
    wire [31:0] branchMuxOut; 
    wire andOut; 
  


////////// STATE FLAGS ////////////
    wire reg_dst;
    wire reg_write;
    wire aluSource;
    wire memRead;
    wire memWrite; //RW
    wire mem_to_reg;
    wire jump;  
    wire branch;  
    wire [2:0] aluCode ;



/////////////////////////COMPONENTS////////////////////////////////////

//Program Counter
ProgramCounter programCounter(next, pcOut, Reset, Clk, 1'b1);

//reg [511:0] PC = 512'd0;
//Intruction Memory
instructMemTest1 instructionMem(instruction, clk, pcOut);

//Control Unit
control controlUnit(instruction[31:26], reset, reg_dst, reg_write, aluSource, memRead, memWrite, mem_to_reg,jump, branch, aluCode);

//Mux Connections
//muxA BasicMux(muxAout, HILO, instruction[25:21], LO, HI); //not used
mux4 RegisterMux(regMuxOut, reg_dst, instruction[20:16], instruction[15:11]); //present
mux32 aluMux(aluMuxOut, aluSource, regOutB, signExtOut);
mux32 muxRAM(ramMuxOut, mem_to_reg, aluOut, ramOut);
mux32 branchMux(branchMuxOut, andOut, pcAdd4, branchAddOut);
//change muxFout name to next, muxEout to branchMuxOut, addAout to PCAdd4
mux32 jumpMux(jumpMuxOut, jump, branchMuxOut, {pcAdd4[31:28], shftLeft28Out}); 

//Register File
RegisterFile RegisterFile(instruction[25:21], instruction[20:16], regMuxOut, ramMuxOut, mem_to_reg, clk, regOutA, regOutB );

//ALU Modules
ALU alu(aluOut, zFlag, instruction[5:0], regOutA, signExtOut, aluCode);

//RAM Module
RAM ram(clk, memRead, memWrite, aluOut, ramOut, regOutB);


//Util Modules
signExtender signExt(signExtOut, instruction[15:0]);
shftLeft28 shftJump(shftLeft28Out, instruction[25:0]);
shftLeft shftLeft(shftLeftOut,signExtOut);
addplus4 addFour(pcAdd4, pcOut);
adder adder(branchAddOut, pcAdd4, shftLeftOut);
AND simpleAND(andOut, zFlag, branch);


////////// MONITOR ////////////
// initial begin
// $dumpvars(0,instruction);
// $monitor("Intructions [B]", instruction);
// end

endmodule  