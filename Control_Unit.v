module Control_Unit #(parameter width = 32)
(
input  wire [width - 1 : 0] Instr,
input  wire                 Zero ,
 
output wire      PCSrc     ,
output reg [1:0] ResultSrc ,
output reg       MemWrite  ,
output reg [1:0] ALUControl,
output reg       ALUSrc    ,
output reg [1:0] ImmSrc    ,
output reg       RegWrite  
     
);

// internal wires
 reg [1:0] ALUOP;
 reg Branch;  
 reg Jump  ;
 
 wire [6:0] OP     ; // bits [6:0]
 wire [2:0] funct3 ; // bits [14:12]
 wire [6:0] funct7 ; // bits [30]

 assign OP     = Instr[6:0]  ;
 assign funct3 = Instr[14:12];
 assign funct7 = Instr[31:25];
 
/////////Main Decoder ///////
always @(*)
 begin
    case (OP)
	     7'b0000011 : begin // lw
		     ResultSrc = 2'b01;
             MemWrite  = 1'b0 ;
             ALUSrc    = 1'b1 ;
             ImmSrc    = 2'b00;
             RegWrite  = 1'b1 ;
			 Branch    = 1'b0 ;
			 ALUOP     = 2'b00;
			 Jump      = 1'b0 ; 
		 end
		 7'b0100011 : begin // sw
		     ResultSrc = 2'bxx;
             MemWrite  = 1'b1 ;
             ALUSrc    = 1'b1 ;
             ImmSrc    = 2'b01;
             RegWrite  = 1'b0 ;
			 Branch    = 1'b0 ;
			 ALUOP     = 2'b00;
			 Jump      = 1'b0 ; 
		 end
		 7'b0110011 : begin // R type
		     ResultSrc = 2'b00;
             MemWrite  = 1'b0 ;
             ALUSrc    = 1'b0  ;
             ImmSrc    = 2'bxx;
             RegWrite  = 1'b1 ;
			 Branch    = 1'b0 ;
			 ALUOP     = 2'b10;
			 Jump      = 1'b0 ; 
		 end
		 7'b1100011 : begin // beq
		     ResultSrc = 2'bxx;
             MemWrite  = 1'b0 ;
             ALUSrc    = 1'b0 ;
             ImmSrc    = 2'b10;
             RegWrite  = 1'b0 ;
			 Branch    = 1'b1 ;
			 ALUOP     = 2'b01;
			 Jump      = 1'b0 ; 
		 end
		 7'b0010011 : begin // I_type ALU
		     ResultSrc = 2'b00;
             MemWrite  = 1'b0 ;
             ALUSrc    = 1'b1 ;
             ImmSrc    = 2'b00;
             RegWrite  = 1'b1 ;
			 Branch    = 1'b0 ;
			 ALUOP     = 2'b10;
			 Jump      = 1'b0 ; 
		 end
		 7'b1101111 : begin // jal
		     ResultSrc = 2'b10;
             MemWrite  = 1'b0 ;
             ALUSrc    = 1'bx ;
             ImmSrc    = 2'b11;
             RegWrite  = 1'b1 ;
			 Branch    = 1'b0 ;
			 ALUOP     = 2'bxx;
			 Jump      = 1'b1 ; 
		 end
		 default    : begin
		     ResultSrc = 2'bxx;
             MemWrite  = 1'bx ;
             ALUSrc    = 1'bx ;
             ImmSrc    = 2'bxx;
             RegWrite  = 1'bx ;
			 Branch    = 1'bx ;
			 ALUOP     = 2'bxx;
			 Jump      = 1'bx ; 
		 end
	endcase
 end 

///////// ALU Decoder ///////////////

always @ (*)
 begin
     case (ALUOP)
	    2'b00 : begin
                 ALUControl = 2'b00; // add lw,sw
 		end
		2'b01 : begin
		         ALUControl = 2'b00; // sub beq
		end
		// R type operation check on funct3 and funct7
		2'b10 : begin
		         if (funct3 == 3'b000) begin
                     ALUControl = ({OP[5],funct7[5]} == 11) ? 2'b01 : 2'b00 ; // sub : add 
                 end else if (funct3 == 3'b110) begin
				     ALUControl = 2'b11; // or
				 end else if (funct3 == 3'b111) begin
				     ALUControl = 2'b10; // and
				 end else begin
				     ALUControl = 2'bxx; 
				 end
		end
	  default : begin
	             ALUControl = 2'bxx;
	    end
	 endcase
 end
 
 assign PCSrc =(Zero&Branch) | Jump ;
endmodule 