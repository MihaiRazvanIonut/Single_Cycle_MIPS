
module ProgramCounterModule(

    input           Clk,
    input           Reset,

    input      [31 : 0] PCnext,
    output reg [31 : 0] PC
);

    always @(posedge Clk, posedge Reset) begin
        
        if (Reset)
            PC <=  0;
        else
            PC <= PCnext;
    end

endmodule
