module tb_slave_select;

reg start;
reg done;

wire ss_n;

slave_select DUT(
    .start(start),
    .done(done),
    .ss_n(ss_n)
);

initial
begin
    start = 0;
    done = 0;

    #20 start = 1;

    #100 done = 1;

    #50 $stop;
end

endmodule
