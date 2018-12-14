 // To Compile: iverilog -o results/CPUTestbench1.vvp testers/CPUTest1.v CPU.v ALUModule.v ControlModules.v MuxModules.v RamModules.v RegisterFile.v UtilModules.v
 // To Build: vvp results/CPUTestbench1.vvp



module CPUTester1();
    
    reg reset = 1'b0, clk;
    integer index;
    integer f;

    mipsCPUData1 CPU_Test1(clk, reset);

    initial begin
        // To record the workbench we create a file to be read by GTKWave demostrating all inputs and outputs at any given time.
        $dumpfile("results/CPUFileTest1.vcd");
        $dumpvars(0,clk, reset,
            //Program Counter Variables 
            CPU_Test1.Program_Counter,

            
            //Instruction Memory Variables
            CPU_Test1.Memory, 

            //Control Unit Variables
            CPU_Test1.Control_Unit, 

            // ALU MOdule Variables
            CPU_Test1.alu,

            //Register File Variables
            CPU_Test1.Register_File,

            //Adder Variables
            CPU_Test1.addFour,
            CPU_Test1.adder,

            //Shift 2 and Sign Sxtend Variables
            CPU_Test1.signExt,
            CPU_Test1.shftJump,
            CPU_Test1.shftLeft,
            CPU_Test1.simpleAND,

            //Registers
            CPU_Test1.MAR,
            CPU_Test1.MDR,
            CPU_Test1.NPC,
            CPU_Test1.IR,


            //Mux Variables
            CPU_Test1.funcMux,
            CPU_Test1.pcMux,
            CPU_Test1.Jump_Mux,
            CPU_Test1.ALU_Mux,
            CPU_Test1.Register_Mux,
            CPU_Test1.mdrMux,
            CPU_Test1.Branch_Mux
            );
            f = $fopen("output/output1.txt","w");
            for(index = 1; index <= 130; index = index+1) begin  
                clk =0; #5 clk = 1; #5;

                // $fwrite(f,"\nProgram Counter: %d", CPU_Test1.Program_Counter.PCResult );
                // $fwrite(f,"\nCurrent Instruction: %b", CPU_Test1.Instruction_Memory.Instruction );
                // $fwrite(f,"\nOperation Code: %b", CPU_Test1.Control_Unit.opcode );
                // $fwrite(f,"\nRegister S Address: %d", CPU_Test1.Register_File.A_Address );
                // $fwrite(f,"\nRegister T Address: %d", CPU_Test1.Register_File.B_Address );
                // $fwrite(f,"\nOffset: %d\n\n", CPU_Test1.signExt.ins );

                // $fwrite(f,"\nMAR: %b", CPU_Test1.MAR.Result );
                // $fwrite(f,"\nMemory Address: %b", CPU_Test1.Instruction_Memory.Mem );
                
               
            end
            $fclose(f);

    end

endmodule