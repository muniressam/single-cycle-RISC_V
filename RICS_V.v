module RISC_V #(parameter width = 32)
(
input wire CLK ,
input wire RST ,

output wire                 MemWrite ,
output wire [width - 1 :0 ] DataAdr,
output wire [width - 1 : 0] WriteData

);

// internal wires

wire [width - 1 : 0] Result   ;
wire [width - 1 : 0] PCNext   ;
wire [width - 1 : 0] PC       ; 
wire [width - 1 : 0] Instr    ;
wire [width - 1 : 0] PCPlus4  ;
wire [width - 1 : 0] PCTarget ;

wire                 PCSrc    ;
wire [1:0]           ResultSrc;
wire [1:0]           ALUControl;
wire                 ALUSrc   ;
wire [1:0]           ImmSrc   ;
wire                 RegWrite ;


wire [width - 1 : 0] SrcA     ;
wire [width - 1 : 0] SrcB	  ;
wire [width - 1 : 0] ImmExt   ;
wire                 Zero     ;

//wire [width - 1 :0 ] ALUResult; 
wire [width - 1 : 0] ReadData ;


  
  
Control_Unit #(.width(width)) u_CU 
(
.Instr(Instr),
.Zero(Zero) ,
.PCSrc(PCSrc),
.ResultSrc(ResultSrc),
.MemWrite(MemWrite),
.ALUControl(ALUControl),
.ALUSrc(ALUSrc),
.ImmSrc(ImmSrc),
.RegWrite(RegWrite)
);

PC_Next #(.width(width)) u_PC_Next
(
.PCTarget(PCTarget),
.PCPlus4(PCPlus4),
.PCSrc(PCSrc),
.PCNext(PCNext)
);

Add_PC_Target #(.width(width)) u_PC_Target
(
.PC(PC),
.ImmExt(ImmExt),
.PCTarget(PCTarget)

);

Add_PC_Plus4  #(.width(width)) u_PC_Plus4
(
.PC(PC),
.PCPlus4(PCPlus4)
);

PC  #(.width(width)) u_PC
(
.CLK(CLK),
.RST(RST),
.PCNext(PCNext),
.PC(PC) 
 );
 
Instruction_Memory  #(.width(width)) u_Ins_M
(
.Address(PC),
.Instr(Instr)
);

Register_File #(.width(width)) u_Reg
(
.Instr(Instr),
.WD(Result),
.RegWrite(RegWrite),
.CLK(CLK),
.RD1(SrcA), 
.RD2(WriteData)

);

Extend_imm #(.width(width)) u_imm
(
.Instr(Instr), 
.ImmSrc(ImmSrc),
.ImmExt(ImmExt)
);
Imm_MUX #(.width(width)) u_immMUX
(
.RD2(WriteData),
.ImmExt(ImmExt),
.ALUSrc(ALUSrc),
.RD2_SrcB(SrcB)
);

ALU #(.width(width)) u_ALU
(
.A(SrcA),
.B(SrcB),
.ALUControl(ALUControl),
.ALUResult(DataAdr),
.Zero(Zero)
);

Data_Memory #(.width(width)) u_DM 
(
.DataAdr(DataAdr),
.WriteData(WriteData),
.MemWrite(MemWrite),
.CLK(CLK),
.ReadData(ReadData)
);

MUX_3x1 #(.width(width)) u_MUX3 
(
.ResultSrc(ResultSrc),
.ALUResult(DataAdr),
.ReadData(ReadData),
.PCPlus4(PCPlus4),
.Result(Result)
);


endmodule