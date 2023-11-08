module AdderModule (

    input      [31 : 0] IN_A,
    input      [31 : 0] IN_B,
    output     [31 : 0] Out
);

    assign Out = IN_A + IN_B;

endmodule

