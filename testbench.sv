module MIPSTestbench;
  
  	reg Clk = 0;
  	reg Reset = 1;
  MIPSModule dut(Clk, Reset);
  
    initial begin
        forever #5 Clk = ~Clk;
    end

    initial begin
      $dumpfile("dump.vcd"); $dumpvars;
        #200 $finish;
    end
  
  	initial begin
      
      #4  Reset = 0;
      
    end
  
endmodule