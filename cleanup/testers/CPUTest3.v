 // To Compile: iverilog -o results/CPUTestbench3.vvp testers/CPUTest3 CPU.v ALUModule.v ControlModules.v MuxModules.v RamModules.v RegisterFile.v UtilModules.v
 // To Build: vvp results/CPUTestbench3.vvp

module CPUTester3();
    
        // To Compile: iverilog -o results/CPUTestbench.vvp CPUTest.vl CPU.v ALUModule.v ControlModules.v MuxModules.v RamModules.v RegisterFile.v UtilModules.v
        // To Build: vvp results/CPUTestbench.vvp

    reg reset = 1'b0, clk;
    integer index;

    mipsCPUData3 CPU_Test1(clk, reset);

    initial begin
        // To record the workbench we create a file to be read by GTKWave demostrating all inputs and outputs at any given time.
        $dumpfile("results/CPUFileTest1.vcd");
        $dumpvars(0,clk, reset,
            //Prohram Counter Variables 
            CPU_Test1.Program_Counter,

            
            //Instruction Memory Variables
            CPU_Test1.Instruction_Memory, 

            //Control Unit Variables
            CPU_Test1.Control_Unit, 

            // ALU MOdule Variables
            CPU_Test1.alu,

            //Register File Variables
            CPU_Test1.Register_File,

            //RAM Variables
            CPU_Test1.ram,

            //Adder Variables
            CPU_Test1.addFour,
            CPU_Test1.adder,

            //Shift 2 and Sign Sxtend Variables
            CPU_Test1.signExt,
            CPU_Test1.shftJump,
            CPU_Test1.shftLeft,
            CPU_Test1.simpleAND,

            //Mux Variables
            CPU_Test1.Jump_Mux,
            CPU_Test1.ALU_Mux,
            CPU_Test1.Register_Mux,
            CPU_Test1.RAM_Mux,
            CPU_Test1.Branch_Mux
            );

            for(index = 1; index <= 130; index = index+1) begin  
                clk =0; #5 clk = 1;
                if(index <= 20) begin
                $display("\n---------TEST BENCH 1-----------\n");
                $display("\nProgram Counter: %d", CPU_Test1.Program_Counter.PCResult );
                $display("\nCurrent Instruction: %b", CPU_Test1.Instruction_Memory.Instruction );
                $display("\nOperation Code: %b", CPU_Test1.Control_Unit.opcode );
                $display("\nRegister S Address: %d", CPU_Test1.Register_File.A_Address );
                $display("\nRegister T Adresss: %d", CPU_Test1.Register_File.B_Address );
                $display("\nOffset: %d", CPU_Test1.signExt.ins );
                $display("\n---------END OF TEST BENCH 1-----------\n");
                end
               
            end

    end

endmodule