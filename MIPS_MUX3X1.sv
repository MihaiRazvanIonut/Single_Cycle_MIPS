module MUX3X1Module #(parameter WIDTH = 8)(

    input [WIDTH-1 : 0] IN_A,
    input [WIDTH-1 : 0] IN_B,
    input [WIDTH-1 : 0] IN_C,
    input [1 : 0]       Sel,
    output reg [WIDTH-1 : 0] Out
);

    always @(*) begin
    case (Sel)

        2'b00: begin

            Out <= IN_A;

        end

        2'b01: begin

            Out <= IN_B;

        end

        2'b10: begin
            Out <= IN_C;
        end
        default: begin

            Out <= {WIDTH{1'bx}};

        end

    endcase
    end

endmodule
