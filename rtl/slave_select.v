module slave_select(
    input start,
    input done,

    output reg ss_n
);

always @(*)
begin
    if(start && !done)
        ss_n = 0;
    else
        ss_n = 1;
end

endmodule
