module Instruction_Memory #(parameter width = 32)
(
input  wire [width - 1 : 0] Address,

output wire [width - 1 : 0] Instr
);

reg [width -1:0] ROM [width -1:0] ;

assign  Instr = ROM[Address [31:2]]; 

initial   
 begin
    $readmemh("riscvtest.txt",ROM);
 end


endmodule 

