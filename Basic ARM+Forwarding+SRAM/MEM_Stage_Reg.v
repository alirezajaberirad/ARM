module MEM_Stage_Reg(
  input clk,rst,
  input WB_EN_in, MEM_R_EN_in,
  input[31:0] ALU_result_in, MEM_result_in,
  input[3:0] Dest_in,

  input freeze,

  output reg WB_EN, MEM_R_EN,
  output reg[31:0] ALU_result, MEM_result,
  output reg[3:0] Dest
);
  always@(posedge clk, posedge rst)
    if(rst)begin
      WB_EN=1'b0;
      MEM_R_EN=1'b0;
      ALU_result=0;
      MEM_result=0;
      Dest=4'b0;
    end
    else if(~freeze)begin
      WB_EN=WB_EN_in;
      MEM_R_EN=MEM_R_EN_in;
      ALU_result=ALU_result_in;
      MEM_result=MEM_result_in;
      Dest=Dest_in;
    end
endmodule
