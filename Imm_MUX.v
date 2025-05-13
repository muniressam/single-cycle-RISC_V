module Imm_MUX #(parameter width = 32)
(
input wire [width - 1 : 0] RD2,
input wire [width - 1 : 0] ImmExt,
input wire                 ALUSrc,

output wire [width - 1 : 0] RD2_SrcB
);

assign RD2_SrcB = (ALUSrc == 1) ? ImmExt : RD2;

endmodule