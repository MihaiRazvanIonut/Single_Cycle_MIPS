module RegistersModule (

    input               Clk,
  	input               Reset,
	input               RegWrite,
    input      [4 : 0]  ReadReg1,
    input      [4 : 0]  ReadReg2,
    input      [4 : 0]  WriteReg,
    input      [31 : 0] WriteData,
    output [31 : 0] RegValue1,
    output [31 : 0] RegValue2,
  output [31 : 0] reg7
);

    reg [31 : 0] RegFile [31 : 0];
    reg [31:0] i;
  assign reg7 = RegFile[7];
    initial
        for (i = 0; i < 32; i = i + 1)
          RegFile[i] = 0;
    always @(*) begin
        RegFile[0] <= 0;
        RegFile[28] <= 256;
    end
  always @(posedge Clk, posedge Reset) begin
    if (Reset) begin
    	for (i = 0; i < 32; i = i + 1)
    		RegFile[i] = 0;
    end
    else 
      	begin
        	if (RegWrite) 
            	RegFile[WriteReg] <= WriteData;
    	end
    end
    assign RegValue1 = (ReadReg1 != 0) ? RegFile[ReadReg1] : 0;
    assign RegValue2 = (ReadReg2 != 0) ? RegFile[ReadReg2] : 0;

endmodule
