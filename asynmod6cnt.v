module tff (output reg q,input t,clk,rst);
always @ (posedge clk or posedge rst)
begin
  if(rst)
	q<=1'b0;
  else if(t)
	 q<=~q;
end 
endmodule
module mod6_counter(output [2:0]q,input clk,rst);
wire rst_cnt;
assign rst_cnt = rst | (q[2] & q[1]);
tff tff0 (q[0],1'b1,clk,rst_cnt);
tff tff1 (q[1],q[0],clk,rst_cnt);
tff tff2 (q[2],q[1]&q[0],clk,rst_cnt);
endmodule
