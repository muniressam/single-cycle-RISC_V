module Extend_imm #(parameter width = 32)
(
input wire [width - 1 : 0] Instr , // [31 : 0]
input wire [1:0] ImmSrc,

output reg [width - 1 : 0] ImmExt 
);

always @(*) 
 begin
     case(ImmSrc) 
	     2'b00 : ImmExt = {{20{Instr[31]}}, Instr[31:20]}; // I-Type: addi, andi, ori, lw, jalr
		 2'b01 : ImmExt = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]}; // S-Type: sw  
		 2'b10 : ImmExt = {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0}; // B-Type: beq, bne
		 2'b11 : ImmExt = {{12{Instr[31]}}, Instr[19:12], Instr[20], Instr[30:21], 1'b0}; // J-Type: jal
		default: ImmExt = 'hx;
	 endcase
 
 end 


endmodule