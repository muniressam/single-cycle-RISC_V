module Data_Memory #(parameter width = 32)
(
input wire [width - 1 : 0] DataAdr,
input wire [width - 1 : 0] WriteData,
input wire MemWrite ,
input wire CLK,

output wire [width - 1 : 0] ReadData

);
reg [width - 1 : 0] MEM [width - 1 : 0] ;
always @(posedge CLK ) 
 begin
     if (MemWrite) begin
         MEM[DataAdr[width - 1 : 2]] <= WriteData ;
	 end 
 end 
 
assign ReadData = MEM [DataAdr[width - 1 : 2]];	

endmodule