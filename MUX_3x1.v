module MUX_3x1 #(parameter width = 32)
(
input wire [1:0]           ResultSrc,
input wire [width - 1 : 0] ALUResult,
input wire [width - 1 : 0] ReadData ,
input wire [width - 1 : 0] PCPlus4  ,

output reg [width - 1 : 0] Result
);

always @(*)
 begin
     case (ResultSrc)
	     2'b00 : Result = ALUResult;
		 2'b01 : Result = ReadData ;
		 2'b10 : Result = PCPlus4  ;
	   default : Result = 32'hx    ;
	 endcase
 
 end 

endmodule 