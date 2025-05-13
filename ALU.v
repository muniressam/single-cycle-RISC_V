module ALU #(parameter width = 32)
(
input wire [width - 1 : 0] A,
input wire [width - 1 : 0] B,
input wire [1:0]  ALUControl,

output reg [width - 1 :0] ALUResult,
output reg Zero

);
 
always @(*)
 begin
  case (ALUControl)
    2'b00 : ALUResult = A+B ;
    2'b01 : ALUResult = A-B ;
    2'b10 : ALUResult = A&B ;
    2'b11 : ALUResult = A|B ;    
   default : ALUResult = 32'h00;
  endcase
//Zero = (ALUResult == 'h0) ?  1'b1  : 1'b0 ; 
Zero = ~(|ALUResult);
end
   
endmodule