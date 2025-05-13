module Register_File #(parameter width = 32)
(
input wire [width - 1 : 0] Instr,
input wire [width - 1 : 0] WD,
input wire RegWrite,
input wire CLK,

output reg [width - 1 : 0] RD1, 
output reg [width - 1 : 0] RD2

);
// internal wires 
 wire [4:0] rs1; // A1
 wire [4:0] rs2; // A2
 wire [4:0] rd;  // A3

 assign rs1 = Instr[19:15];
 assign rs2 = Instr[24:20];
 assign rd  = Instr[11:7 ];

reg [width-1 :0] MEM [width-1 :0];

// write 
always @(posedge CLK)
 begin
     if(RegWrite) begin
	     MEM[rd] <= WD;
	 end 
 end 
// read
always @(*) 
 begin
	 MEM[0] = 32'b0;
	 RD1  = MEM[rs1];
	 RD2  = MEM[rs2];
 end

endmodule