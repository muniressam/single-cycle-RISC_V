module Add_PC_Target #(parameter width = 32)
(
input wire [width - 1 : 0] PC,
input wire [width - 1 : 0] ImmExt,

output wire [width - 1 : 0] PCTarget

);

assign PCTarget = PC + ImmExt;

endmodule