module ALUControlModule (

    input      [1 : 0] ALUOp,
    input      [5 : 0] Funct,
  output reg [3 : 0] OutALUOp 
);

    always @(*) begin
        case (ALUOp)

            2'b00: OutALUOp <= 4'b0100; // add
            2'b01: OutALUOp <= 4'b1100; // sub
            2'b10: case(Funct)  //look at funct

      	        6'b100000: OutALUOp <= 4'b0100; //add
                6'b100010: OutALUOp <= 4'b1100; //sub
                6'b100100: OutALUOp <= 4'b0000; //and
                6'b100101: OutALUOp <= 4'b0010; //or
                6'b101010: OutALUOp <= 4'b1110; //slt
                6'b100110: OutALUOp <= 4'b0110; //xor 
                6'b001000: OutALUOp <= 4'b0001; //jr
                default :  OutALUOp <= 4'bxxxx; // Funct not defined   
            endcase
            default: OutALUOp <= 3'bxxx; // not defined
        endcase
    end
endmodule
