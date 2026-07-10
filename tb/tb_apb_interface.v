module tb_apb_interface;

reg pclk;
reg presetn;

reg psel;
reg penable;
reg pwrite;

reg [7:0] pwdata;

wire [7:0] tx_data;
wire start;

apb_interface DUT(
    .pclk(pclk),
    .presetn(presetn),
    .psel(psel),
    .penable(penable),
    .pwrite(pwrite),
    .pwdata(pwdata),
    .tx_data(tx_data),
    .start(start)
);

initial
begin
    pclk = 0;
    forever #5 pclk = ~pclk;
end

initial
begin
    presetn = 0;

    #20 presetn = 1;

    psel = 1;
    penable = 1;
    pwrite = 1;

    pwdata = 8'hA5;

    #20;

    psel = 0;
    penable = 0;

    #100 $stop;
end

endmodule
