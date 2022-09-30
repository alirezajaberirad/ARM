module cache(
  clk,
  rst,
  address,
  wdata,
  cache_w_en,
  invalidate,
  change_LRU,
  //SRAM_w_en,

  hit_or_miss,
  rdata
  );

  input clk,rst;
  input[18:0] address;
  input[31:0] wdata;
  input cache_w_en;
  input invalidate;
  input change_LRU;

  output hit_or_miss;
  output[31:0] rdata;

  reg[31:0] datablk[0:63][0:3];

  // reg[31:0] datablk00 [0:63];//block 0 from way 0
  // reg[31:0] datablk10 [0:63];//block 1 from way 0
  // reg[31:0] datablk01 [0:63];//block 0 from way 1
  // reg[31:0] datablk11 [0:63];//block 1 from way 1

  reg[9:0] tag [0:63][0:1];

  reg valid [0:63][0:1];

  reg LRU [0:63];

  wire hit_or_miss0, hit_or_miss1;
  wire[9:0] tag_in;
  wire[5:0] index;
  wire LSB_or_MSB;

  assign tag_in=address[18:9];
  assign index=address[8:3];
  assign LSB_or_MSB=address[2];

  assign hit_or_miss0=((tag[index][0] == tag_in) && valid[index][0]);
  assign hit_or_miss1=((tag[index][1] == tag_in) && valid[index][1]);
  assign hit_or_miss=(hit_or_miss0 | hit_or_miss1);

  assign rdata=datablk[index][{hit_or_miss1,LSB_or_MSB}];

  // always@(*)begin
  //   case({hit_or_miss0,hit_or_miss1,LSB_or_MSB})
  //     3'b100:begin rdata=datablk00[index]; LRU[index]=1'b1; end
  //     3'b101:begin rdata=datablk01[index]; LRU[index]=1'b0; end
  //     3'b010:begin rdata=datablk10[index]; LRU[index]=1'b1; end
  //     3'b011:begin rdata=datablk11[index]; LRU[index]=1'b0; end
  //     default: rdata=32'b0;
  //   endcase
  // end

  always@(posedge clk)begin
    if(invalidate)
      valid[index][hit_or_miss1]<=1'b0;
    else if(cache_w_en)begin
      valid[index][LRU[index]]<=1'b1;
      datablk[index][{LRU[index],LSB_or_MSB}]<=wdata;
      if(change_LRU)
        LRU[index]<=~LRU[index];
      // if(LRU[index])begin//write in way 1
      //   if(LSB_or_MSB)
      //     datablk11[index]<=wdata;
      //   else
      //     datablk01[index]<=wdata;
      // end
      // else begin//write in way 0
      //   if(LSB_or_MSB)
      //     datablk10[index]<=wdata;
      //   else
      //     datablk00[index]<=wdata;
      // end
    end
  end

  integer i;
  initial begin
    for(i=0;i<64;i=i+1)begin
      valid[i][0]=1'b0;
      valid[i][1]=1'b0;
      tag[i][0]=10'b0;
      tag[i][1]=10'b0;
      LRU[i]=1'b0;
    end
  end

endmodule
