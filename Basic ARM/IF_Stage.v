module IF_Stage(
  input clk,rst,freeze,Branch_taken,
  input[31:0] BranchAddr,
  output[31:0] PC, Instruction
);

  wire[7:0] InsMem [0:200];
  wire[31:0] nextPC,MUXout;
  reg[31:0]PCreg=0;
  always@(posedge clk, posedge rst)begin
    if(rst)
      PCreg<=0;
    else if(~freeze)
      PCreg<=MUXout;
  end
  assign PC=nextPC;
  assign nextPC=PCreg+4;
  assign MUXout=Branch_taken ? BranchAddr : nextPC;
  assign Instruction={InsMem[PCreg+3],InsMem[PCreg+2],InsMem[PCreg+1],InsMem[PCreg+0]};

            assign {InsMem[3], InsMem[2], InsMem[1], InsMem[0]} = 32'b1110_00_1_1101_0_0000_0000_000000010100;      //  MOV R0 = 20           R0 = 20
            assign {InsMem[7], InsMem[6], InsMem[5], InsMem[4]} = 32'b1110_00_1_1101_0_0000_0001_101000000001;      //  MOV R1 ,#4096         R1 = 4096
            assign {InsMem[11], InsMem[10], InsMem[9], InsMem[8]} = 32'b1110_00_1_1101_0_0000_0010_000100000011;   //   MOV R2 ,#0xC0000000    R2 = -1073741824
            assign {InsMem[15], InsMem[14], InsMem[13], InsMem[12]} = 32'b1110_00_0_0100_1_0010_0011_000000000010; //   ADDS R3 ,R2,R2         R3 = -2147483648
            assign {InsMem[19], InsMem[18], InsMem[17], InsMem[16]} =  32'b1110_00_0_0101_0_0000_0100_000000000000; //ADC R4 ,R0,R0 //R4 = 41
            assign {InsMem[23], InsMem[22], InsMem[21], InsMem[20]} = 32'b1110_00_0_0010_0_0100_0101_000100000100; //SUB R5 ,R4,R4,LSL #2 //R5 = -123
            assign {InsMem[27], InsMem[26], InsMem[25], InsMem[24]} = 32'b1110_00_0_0110_0_0000_0110_000010100000; //SBC R6 ,R0,R0,LSR #1//R6 = 10
            assign {InsMem[31], InsMem[30], InsMem[29], InsMem[28]} = 32'b1110_00_0_1100_0_0101_0111_000101000010; //ORR R7,R5,R2,ASR #2//R7 = -123
            assign {InsMem[35], InsMem[34], InsMem[33], InsMem[32]} = 32'b1110_00_0_0000_0_0111_1000_000000000011; //AND R8,R7,R3   R8 = -2147483648
            assign {InsMem[39], InsMem[38], InsMem[37], InsMem[36]} = 32'b1110_00_0_1111_0_0000_1001_000000000110; //MVN R9,R6//R9 = -11
            assign {InsMem[43], InsMem[42], InsMem[41], InsMem[40]} = 32'b1110_00_0_0001_0_0100_1010_000000000101; //EOR R10,R4,R5//R10 = -84
            assign {InsMem[47], InsMem[46], InsMem[45], InsMem[44]} = 32'b1110_00_0_1010_1_1000_0000_000000000110; //CMP R8,R6
            assign {InsMem[51], InsMem[50], InsMem[49], InsMem[48]} = 32'b0001_00_0_0100_0_0001_0001_000000000001; //ADDNE R1,R1,R1//R1 = 8192
            assign {InsMem[55], InsMem[54], InsMem[53], InsMem[52]} = 32'b1110_00_0_1000_1_1001_0000_000000001000; //TST R9,R8
            assign {InsMem[59], InsMem[58], InsMem[57], InsMem[56]} = 32'b0000_00_0_0100_0_0010_0010_000000000010; //ADDEQ R2 ,R2,R2   //R2 = -1073741824
            assign {InsMem[63], InsMem[62], InsMem[61], InsMem[60]} = 32'b1110_00_1_1101_0_0000_0000_101100000001; //MOV R0,#1024//R0 = 1024
            assign {InsMem[67], InsMem[66], InsMem[65], InsMem[64]} = 32'b1110_01_0_0100_0_0000_0001_000000000000; //STR R1,[R0],#0//MEM[1024] = 8192
            assign {InsMem[71], InsMem[70], InsMem[69], InsMem[68]} = 32'b1110_01_0_0100_1_0000_1011_000000000000; //LDR R11,[R0],#0//R11 = 8192
            assign {InsMem[75], InsMem[74], InsMem[73], InsMem[72]} = 32'b1110_01_0_0100_0_0000_0010_000000000100; //STR R2,[R0],#4//MEM[1028] = -1073741824
            assign {InsMem[79], InsMem[78], InsMem[77], InsMem[76]} = 32'b1110_01_0_0100_0_0000_0011_000000001000; //STR    R3 ,[R0],#8//MEM[1032] = -2147483648
            assign {InsMem[83], InsMem[82], InsMem[81], InsMem[80]} = 32'b1110_01_0_0100_0_0000_0100_000000001101; //STR    R4 ,[R0],#13    //MEM[1036] = 41
            assign {InsMem[87], InsMem[86], InsMem[85], InsMem[84]} = 32'b1110_01_0_0100_0_0000_0101_000000010000; //STR R5,[R0],#16//MEM[1040] = -123
            assign {InsMem[91], InsMem[90], InsMem[89], InsMem[88]} = 32'b1110_01_0_0100_0_0000_0110_000000010100; //STR R6,[R0],#20 //MEM[1044] = 10
            assign {InsMem[95], InsMem[94], InsMem[93], InsMem[92]} = 32'b1110_01_0_0100_1_0000_1010_000000000100; //LDR R10,[R0],#4 //R10 = -1073741824
            assign {InsMem[99], InsMem[98], InsMem[97], InsMem[96]} = 32'b1110_01_0_0100_0_0000_0111_000000011000; //STR R7,[R0],#24    //MEM[1048] = -123
            assign {InsMem[103], InsMem[102], InsMem[101], InsMem[100]} = 32'b1110_00_1_1101_0_0000_0001_000000000100; //MOV R1,#4//R1 = 4
            assign {InsMem[107], InsMem[106], InsMem[105], InsMem[104]} = 32'b1110_00_1_1101_0_0000_0010_000000000000; //MOV R2,#0//R2 = 0
            assign {InsMem[111], InsMem[110], InsMem[109], InsMem[108]} = 32'b1110_00_1_1101_0_0000_0011_000000000000; //MOV R3,#0//R3 = 0
            assign {InsMem[115], InsMem[114], InsMem[113], InsMem[112]} = 32'b1110_00_0_0100_0_0000_0100_000100000011; //ADD R4,R0,R3,LSL #2
            assign {InsMem[119], InsMem[118], InsMem[117], InsMem[116]} = 32'b1110_01_0_0100_1_0100_0101_000000000000; //LDR R5,[R4],#0
            assign {InsMem[123], InsMem[122], InsMem[121], InsMem[120]} = 32'b1110_01_0_0100_1_0100_0110_000000000100; //LDR R6,[R4],#4
            assign {InsMem[127], InsMem[126], InsMem[125], InsMem[124]} = 32'b1110_00_0_1010_1_0101_0000_000000000110; //CMP R5,R6
            assign {InsMem[131], InsMem[130], InsMem[129], InsMem[128]} = 32'b1100_01_0_0100_0_0100_0110_000000000000; //STRGT R6,[R4],#0
            assign {InsMem[135], InsMem[134], InsMem[133], InsMem[132]} = 32'b1100_01_0_0100_0_0100_0101_000000000100; //STRGT R5,[R4],#4
            assign {InsMem[139], InsMem[138], InsMem[137], InsMem[136]} = 32'b1110_00_1_0100_0_0011_0011_000000000001; //ADD R3,R3,#1
            assign {InsMem[143], InsMem[142], InsMem[141], InsMem[140]} = 32'b1110_00_1_1010_1_0011_0000_000000000011; //CMP R3,#3
            assign {InsMem[147], InsMem[146], InsMem[145], InsMem[144]} = 32'b1011_10_1_0_111111111111111111110111  ; //BLT#-9
            assign {InsMem[151], InsMem[150], InsMem[149], InsMem[148]} = 32'b1110_00_1_0100_0_0010_0010_000000000001; //ADD R2,R2,#1
            assign {InsMem[155], InsMem[154], InsMem[153], InsMem[152]} = 32'b1110_00_0_1010_1_0010_0000_000000000001;//CMP R2,R1
            assign {InsMem[159], InsMem[158], InsMem[157], InsMem[156]} = 32'b1011_10_1_0_111111111111111111110011  ;//BLT#-13
            assign {InsMem[163], InsMem[162], InsMem[161], InsMem[160]} = 32'b1110_01_0_0100_1_0000_0001_000000000000;//LDR R1 ,[R0],#0//    R1 = -2147483648
            assign {InsMem[167], InsMem[166], InsMem[165], InsMem[164]} = 32'b1110_01_0_0100_1_0000_0010_000000000100;//LDR R2 ,[R0],#4//    R2 = -1073741824
            assign {InsMem[171], InsMem[170], InsMem[169], InsMem[168]} = 32'b1110_01_0_0100_1_0000_0011_000000001000;//STR R3 ,[R0],#8//    R3 = 41
            assign {InsMem[175], InsMem[174], InsMem[173], InsMem[172]} = 32'b1110_01_0_0100_1_0000_0100_000000001100;//STR R4 ,[R0],#12//   R4 = 8192
            assign {InsMem[179], InsMem[178], InsMem[177], InsMem[176]} = 32'b1110_01_0_0100_1_0000_0101_000000010000;//STR R5 ,[R0],#16//   R5= -123
            assign {InsMem[183], InsMem[182], InsMem[181], InsMem[180]} = 32'b1110_01_0_0100_1_0000_0110_000000010100;//STR R6 ,[R0],#20//   R6 = 10
            assign {InsMem[187], InsMem[186], InsMem[185], InsMem[184]} = 32'b1110_10_1_0_111111111111111111111111;//B#-1

endmodule

/*wire[31:0] InsMem [0:24];
wire[31:0] nextPC,MUXout;
reg[31:0]PCreg=0;
always@(posedge clk, posedge rst)begin
  if(rst)
    PCreg=0;
  else if(!freeze)
    PCreg=MUXout;
end
assign PC=nextPC;
assign nextPC=PCreg+4;
assign MUXout=Branch_taken ? BranchAddr : nextPC;
assign Instruction=InsMem[PCreg];

assign InsMem[0]=32'b00000000001000100000000000000000;
assign InsMem[4]=32'b00000000011001000000000000000000;
assign InsMem[8]=32'b00000000101001100000000000000000;
assign InsMem[12]=32'b00000000111010000001000000000000;
assign InsMem[16]=32'b00000001001010100001100000000000;
assign InsMem[20]=32'b00000001011011000000000000000000;
assign InsMem[24]=32'b00000001101011100000000000000000;*/
//dar code ii ke comment shode farz shode ke width e har address tooye instruction memory 8 bit e.


/*assign {InsMem[3],InsMem[2],InsMem[1],InsMem[0]}=32'b00000000001000100000000000000000;
assign {InsMem[7],InsMem[6],InsMem[5],InsMem[4]}=32'b00000000011001000000000000000000;
assign {InsMem[11],InsMem[10],InsMem[9],InsMem[8]}=32'b00000000101001100000000000000000;
assign {InsMem[15],InsMem[14],InsMem[13],InsMem[12]}=32'b00000000111010000001000000000000;
assign {InsMem[19],InsMem[18],InsMem[17],InsMem[16]}=32'b00000001001010100001100000000000;
assign {InsMem[23],InsMem[22],InsMem[21],InsMem[20]}=32'b00000001011011000000000000000000;
assign {InsMem[27],InsMem[26],InsMem[25],InsMem[24]}=32'b00000001101011100000000000000000;*/
