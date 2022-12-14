module EXE_Stage_Reg(
  input clk,rst, WB_en_in, MEM_R_EN_in, MEM_W_EN_in,
  input[31:0] ALU_result_in, Val_Rm_in,
  input[3:0] Dest_in,

  output reg WB_en, MEM_R_EN, MEM_W_EN,
  output reg[31:0] ALU_result, Val_Rm,
  output reg[3:0] Dest
);
  always@(posedge clk, posedge rst)
  begin
    if(rst)begin
      WB_en=0; MEM_R_EN=0; MEM_W_EN=0;
      ALU_result=0; Val_Rm=0;
      Dest=0;
    end
    else begin
      WB_en = WB_en_in;
      MEM_R_EN = MEM_R_EN_in;
      MEM_W_EN = MEM_W_EN_in;
      ALU_result = ALU_result_in;
      Val_Rm =  Val_Rm_in;
      Dest = Dest_in;
    end
  end
endmodule
