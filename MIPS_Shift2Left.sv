module Shift2LeftModule (

    input  [31 : 0] In,
    output [31 : 0] Out
);

    assign Out = {In[29 : 0], 2'b00};

endmodule
