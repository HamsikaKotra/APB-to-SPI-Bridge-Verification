module apb_interface(
    input pclk,
    input presetn,

    input psel,
    input penable,
    input pwrite,

    input [7:0] pwdata,

    output reg [7:0] tx_data,
    output reg start
);

always @(posedge pclk or negedge presetn)
begin
    if(!presetn)
    begin
        tx_data <= 8'h00;
        start <= 1'b0;
    end
    else
    begin
        start <= 1'b0;

        if(psel && penable && pwrite)
        begin
            tx_data <= pwdata;
            start <= 1'b1;
        end
    end
end

endmodule
