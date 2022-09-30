module Lab1_TB;

  reg clk,rst;
  Top_Module CUT(
    .clk(clk),
    .rst(rst)
  );

  always#5 clk=~clk;

  initial begin
    clk=0;
    rst=1;
    #10
    rst=0;
    #100
//    rst=1;
//    #10
//    rst=0;
    #4000
    $stop;
  end
endmodule
