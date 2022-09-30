`timescale 1ns/1ns
module Lab1_TB;

  reg clk,rst,SRAM_clk;
  Top_Module CUT(
    .SRAM_clk(SRAM_clk),
    .clk(clk),
    .rst(rst)
  );

  always#20 SRAM_clk=~SRAM_clk;
  always#10 clk=~clk;

  initial begin
    SRAM_clk=0;
    clk=0;
    rst=1;
    #20
    rst=0;
    #200
//    rst=1;
//    #10
//    rst=0;
    #12000
    $stop;
  end
endmodule
