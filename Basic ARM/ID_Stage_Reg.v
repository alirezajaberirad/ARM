module ID_Stage_Reg(input clk , rst,flush,
                    input WB_EN_IN,MEM_R_EN_IN,MEM_W_EN_IN,B_IN,S_IN,
                    input [3:0] EXE_CMD_IN,
                    input [31:0] PC_IN,
                    input [31:0] Val_Rn_IN,Val_Rm_IN,
                    input imm_IN,
                    input [11:0] Shift_operand_IN,
                    input [23:0] Signed_imm_24_IN,
                    input [3:0] Dest_IN,
                    input [3:0] Status_in,

                    output reg WB_EN,MEM_R_EN,MEM_W_EN,B,S,
                    output reg [3:0] EXE_CMD,
                    output reg [31:0] PC,
                    output reg [31:0] Val_Rn,Val_Rm,
                    output reg imm,
                    output reg [11:0] Shift_operand,
                    output reg [23:0] Signed_imm_24,
                    output reg [3:0] Dest,
                    output reg [3:0] Status
                  );
  always @(posedge rst,posedge clk)
  begin
    if (rst) begin
      WB_EN<=0;MEM_R_EN<=0;MEM_W_EN<=0;B<=0;S <= 0;
      EXE_CMD <= 4'b0;
      PC      <= 32'b0;
		Val_Rn<=32'b0;
		Val_Rm <= 32'b0;
      imm <= 0 ;
      Shift_operand <= 12'b0;
      Signed_imm_24 <= 24'b0;
      Dest    <=  4'b0;
      Status <= 4'b0;
	 end
	 else if(flush)begin
		WB_EN<=0;MEM_R_EN<=0;MEM_W_EN<=0;B<=0;S <= 0;
      EXE_CMD <= 4'b0;
      PC      <= 32'b0;
		Val_Rn<=32'b0;
		Val_Rm <= 32'b0;
      imm <= 0 ;
      Shift_operand <= 12'b0;
      Signed_imm_24 <= 24'b0;
      Dest    <=  4'b0;
      Status <= 4'b0;
	 end
    else begin
                    WB_EN    <=  WB_EN_IN ;
                    MEM_R_EN <=  MEM_R_EN_IN;
                    MEM_W_EN <=  MEM_W_EN_IN;
                    B <= B_IN ;
                    S <= S_IN;
                    EXE_CMD <= EXE_CMD_IN;
                    PC      <= PC_IN;
                    Val_Rn <=Val_Rn_IN;
                    Val_Rm <=Val_Rm_IN;
                    imm <= imm_IN ;
                    Shift_operand <= Shift_operand_IN;
                    Signed_imm_24 <= Signed_imm_24_IN;
                    Dest    <=  Dest_IN;
                    Status <= Status_in;
    end
  end
endmodule
