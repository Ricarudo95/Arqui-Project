module RAM( clk, read, write, address, output_destination, dataIn);
 
//parameters
 
parameter words_no= 32; //arbitrary, we need 5 bits to address them
parameter bus_width=32;
parameter address_width=5;
 
//ports
 
input  clk;
input  read;
input   write;
input[31:0]   dataIn;
input[31:0]   address;
output reg [31:0]  output_destination;
  
//memory declaration
 
reg [bus_width-1:0] mem [0:words_no-1];//memory of 32 words,each is 32bit
 
// behavior
 
 always@(posedge clk)
      begin
 
		 if (read==1'b1) 
		   begin
 
			 // to read a specific word, you need to address its number. 
             output_destination<=mem [address];
		   end
 
			 if (write==1'b1)
			 mem[address]<=dataIn;
  end
 
endmodule