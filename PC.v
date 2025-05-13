module PC #(parameter width = 32)
(
input wire CLK,
input wire RST,
input wire [width -1 : 0] PCNext ,

output reg [width -1 : 0] PC 
 );
 
always@(posedge CLK or negedge RST)
begin
	if(!RST)
		 begin
		  PC <= 32'h0 ; 
		 end
	else
		 begin
		  PC <= PCNext;
		 end
end
endmodule