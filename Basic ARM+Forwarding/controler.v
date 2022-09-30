module controler(input[3:0]op_code,input [1:0]mode,input S,output reg SS,B,MEM_R_EN,MEM_W_EN,WB_EN,
                 output  reg [3:0] EXE_CMD);


    always@(op_code,mode,S)begin
    EXE_CMD = 4'b0; MEM_R_EN = 0; WB_EN = 0; MEM_W_EN = 0; B = 0;  SS = 0;
    case (mode)
      2'b00:
        case (op_code)
          4'b1101: begin EXE_CMD = 4'b0001; MEM_R_EN = 0;  WB_EN = 1; MEM_W_EN = 0;B = 0;  SS = S;end//mov
          4'b1111: begin EXE_CMD = 4'b1001; MEM_R_EN = 0; WB_EN = 1; MEM_W_EN = 0; B = 0;  SS = S;end //MOVN
          4'b0100: begin EXE_CMD = 4'b0010; MEM_R_EN = 0; WB_EN = 1; MEM_W_EN = 0; B = 0; SS = S; end //ADD
          4'b0101: begin EXE_CMD = 4'b0011; MEM_R_EN = 0; WB_EN = 1; MEM_W_EN = 0; B = 0;  SS = S; end//ADC
          4'b0010: begin EXE_CMD = 4'b0100; MEM_R_EN = 0; WB_EN = 1; MEM_W_EN = 0; B = 0;  SS = S;end //SUB
          4'b0110: begin EXE_CMD = 4'b0101; MEM_R_EN = 0; WB_EN = 1; MEM_W_EN = 0; B = 0;  SS = S;end//SBC
          4'b0000: begin EXE_CMD = 4'b0110; MEM_R_EN = 0; WB_EN = 1; MEM_W_EN = 0; B = 0;  SS = S; end//AND
          4'b1100: begin EXE_CMD = 4'b0111; MEM_R_EN = 0; WB_EN = 1; MEM_W_EN = 0; B = 0;  SS = S; end//ORR
          4'b0001: begin EXE_CMD = 4'b1000; MEM_R_EN = 0; WB_EN = 1; MEM_W_EN = 0; B = 0;  SS = S; end//EOR
          4'b1010: begin EXE_CMD = 4'b0100; MEM_R_EN = 0; WB_EN = 0; MEM_W_EN = 0; B = 0;  SS = S; end//CMP
          4'b1000: begin EXE_CMD = 4'b0110; MEM_R_EN = 0; WB_EN = 0; MEM_W_EN = 0; B = 0; SS = S; end//TST
          default: begin EXE_CMD = 4'b0; MEM_R_EN = 0; WB_EN = 0; MEM_W_EN = 0; B = 0;  SS = 0; end//NOP
        endcase
      2'b01:
        if(op_code == 4'b0100)begin
          if(S == 1'b1)begin EXE_CMD = 4'b0010; MEM_R_EN = 1; WB_EN = 1; MEM_W_EN = 0; B = 0;  SS = 1; end //LDR
          else begin EXE_CMD = 4'b0010; MEM_R_EN = 0; WB_EN = 0; MEM_W_EN = 1; B = 0; SS = 0; end//STR
        end
      2'b10: begin EXE_CMD = 4'bx; B = 1; MEM_R_EN = 0; WB_EN = 0; MEM_W_EN = 0;  SS = 0; end//B
      2'b11: begin EXE_CMD = 4'b0; MEM_R_EN = 0; WB_EN = 0; MEM_W_EN = 0; B = 0;  SS = 0; end//NOP
      default: begin EXE_CMD = 4'b0; MEM_R_EN = 0; WB_EN = 0; MEM_W_EN = 0; B = 0;  SS = 0; end//NOP;
    endcase
  end

endmodule
