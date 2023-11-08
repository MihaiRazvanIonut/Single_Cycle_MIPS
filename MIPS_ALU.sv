module ALUModule (

    input      [31 : 0] SourceA,
    input      [31 : 0] SourceB,
    input      [ 3 : 0] ALUOp,
    output reg [31 : 0] ALUResult,
    output reg          Zero
);

    always @(*) begin

        case (ALUOp)

                  4'b0000:  ALUResult <= SourceA & SourceB;  
                  4'b0010:  ALUResult <= SourceA | SourceB;
                  4'b0100:  ALUResult <= SourceA + SourceB;   
                  4'b0110:  ALUResult <= SourceA ^ SourceB;
                  4'b1000:  ALUResult <= SourceA & ~SourceB;   
                  4'b1010:  ALUResult <= SourceA | ~SourceB;
                  4'b1100:  ALUResult <= SourceA - SourceB;
                  4'b1110:  ALUResult <= SourceA < SourceB;
        endcase

        if (SourceA == SourceB) Zero <= 1;
        else
            Zero <= 0;
    end
endmodule
