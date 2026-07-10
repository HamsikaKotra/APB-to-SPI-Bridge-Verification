module tb_shift_register;

reg sclk;
reg rst;
reg load;

reg [7:0] pdata;

wire mosi;
wire done;

shift_register DUT(
    .sclk(sclk),
    .rst(rst),
    .load(load),
    .pdata(pdata),
    .mosi(mosi),
    .done(done)
);

initial
begin
    sclk = 0;
    forever #10 sclk = ~sclk;
end

initial
begin
    rst = 1;

    #20 rst = 0;

    pdata = 8'b10101010;

    load = 1;
    #20 load = 0;

    #250 $stop;
end

endmodule
