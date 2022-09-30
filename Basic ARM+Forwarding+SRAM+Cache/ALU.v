module ALU(
  input[3:0] EXE_CMD,
  input[31:0] Val1, Val2,
  input[3:0] SR,

  output[3:0] status,
  output reg[31:0] ALU_result
);
  wire Cin;
  wire N,Z;
  reg C,V;

  assign Cin=SR[1];
  assign status={N,Z,C,V};
  assign N=ALU_result[31];
  assign Z=(ALU_result==0) ? 1'b1 : 1'b0;

  always@(*)
  begin
    case(EXE_CMD)
      4'b0001: begin ALU_result=Val2; C=0; V=0; end
      4'b1001: begin ALU_result=~Val2; C=0; V=0; end
      4'b0010: begin
        {C,ALU_result}=Val1+Val2;
        V=((Val1[31] == Val2[31]) & (ALU_result[31] != Val1[31]));
      end
      4'b0011: begin
        {C,ALU_result}=Val1+Val2+{31'b0,Cin};
        V=((Val1[31] == Val2[31]) & (ALU_result[31] != Val1[31]));
      end
      4'b0100: begin
        {C,ALU_result}=Val1-Val2;
        V=((Val1[31] == ~Val2[31]) & (ALU_result[31] != Val1[31]));
      end
      4'b0101: begin
        {C,ALU_result}=Val1-Val2-{31'b0,~Cin};
        V=((Val1[31] == ~Val2[31]) & (ALU_result[31] != Val1[31]));
      end
      4'b0110: begin ALU_result=Val1 & Val2; C=0; V=0; end
      4'b0111: begin ALU_result=Val1 | Val2; C=0; V=0; end
      4'b1000: begin ALU_result=Val1 ^ Val2; C=0; V=0; end
      default: begin ALU_result=0; C=0; V=0; end
    endcase
  end

endmodule
