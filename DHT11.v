module DHT11(clk,button,LED,digits,tempture);
parameter bounce = 20; // 防彈跳係數
input clk;
input button;
reg [bounce-1:0] cnt; // 計時器-彈跳

// 四位七段顯示器
output reg[7:0] LED; 
output reg[3:0] digits;
// 
input tempture; //DHT11 目前沒用到

reg turn; // 目前的狀態


reg button_syn0,button_syn1,button_Init; //防止亞穩態

always@(posedge clk)
begin
//防止亞穩態
button_syn0<=button;
button_syn1<=button_syn0;
button_Init<=button_syn1;
end

always @(posedge clk) begin
if(!button_Init)begin //按下按鈕，輸入信號為1歸0
    cnt <= 0;
    end
    // cnt <= {bounce{1'b0}};
else if(!cnt[bounce-1])begin
    cnt<=cnt+1'b1;
    end

end


always @(posedge cnt[bounce-1])begin
    turn <= ~turn;
end









reg[11:0] freq;
always@(posedge clk)freq=freq+1;
always @(posedge freq[11])
begin

end


always@(posedge freq[11]) 
begin
if(turn==1)
begin
 LED<=8'b11111111;
 digits<=4'b0000;
end
else
begin
 LED<=8'b10101011;
 digits<=4'b0000;
end

end



endmodule