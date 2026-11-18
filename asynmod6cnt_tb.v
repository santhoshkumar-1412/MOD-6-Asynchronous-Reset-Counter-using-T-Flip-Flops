module mod6_counter_tb;
wire [2:0]q;
reg clk,rst;
mod6_counter dut (.q(q),.clk(clk),.rst(rst));
initial
begin
clk=0;
rst=1;
#10 rst=0;
#160 $finish;
end
always #5 clk = ~clk;
initial
begin
$monitor("Time=%0t Reset=%b Count=%b(%d)",$time,rst,q,q);
end
endmodule
