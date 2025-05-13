module Add_PC_Plus4 #(parameter width = 32)
(
input wire [width - 1 : 0] PC,

output wire [width - 1 : 0] PCPlus4

);
assign PCPlus4 = PC + 4;


endmodule

