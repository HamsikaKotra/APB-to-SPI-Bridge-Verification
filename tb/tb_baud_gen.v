`timescale 1ns/1ps

module tb_baud_gen;

reg clk;
reg rst;
reg enable;

wire sclk;

baud_gen DUT(
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .sclk(sclk)
);

initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial
begin
    rst = 1;
    enable = 0;

    #20 rst = 0;
    #20 enable = 1;

    #300 $stop;
end

endmodule
