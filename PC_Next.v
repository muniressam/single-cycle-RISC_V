module PC_Next #(parameter width = 32)
(
input wire [width - 1 : 0] PCTarget,
input wire [width - 1 : 0] PCPlus4,
input wire PCSrc,
output wire [width - 1 : 0] PCNext
);

assign PCNext = (PCSrc == 1) ? PCTarget : PCPlus4 ;
endmodule