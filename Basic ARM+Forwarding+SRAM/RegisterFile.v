module RegisterFile(
  input clk,rst,
  input [3:0] src1,src2,Dest_wb,
  input [31:0] Result_WB,
  input WriteBackEn,
  output [31:0] reg1,reg2
  );
  reg [31:0] register [0:14];

  assign reg1=register[src1];
  assign reg2=register[src2];

  always @(negedge clk)
  begin
    if (WriteBackEn==1)
      register[Dest_wb] <=Result_WB;
  end

  initial begin
    register[0]   = 32'b 00000000_00000000_00000000_00000000;
    register[1]   = 32'b 00000000_00000000_00000000_00000001;
    register[2]   = 32'b 00000000_00000000_00000000_00000010;
    register[3]   = 32'b 00000000_00000000_00000000_00000011;
    register[4]   = 32'b 00000000_00000000_00000000_00000100;
    register[5]   = 32'b 00000000_00000000_00000000_00000101;
    register[6]   = 32'b 00000000_00000000_00000000_00000110;
    register[7]   = 32'b 00000000_00000000_00000000_00000111;
    register[8]   = 32'b 00000000_00000000_00000000_00001000;
    register[9]   = 32'b 00000000_00000000_00000000_00001001;
    register[10]  = 32'b 00000000_00000000_00000000_00001010;
    register[11]  = 32'b 00000000_00000000_00000000_00001011;
    register[12]  = 32'b 00000000_00000000_00000000_00001100;
    register[13]  = 32'b 00000000_00000000_00000000_00001101;
    register[14]  = 32'b 00000000_00000000_00000000_00001110;
  end
endmodule
