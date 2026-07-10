module shift_register(
    input sclk,
    input rst,

    input load,
    input [7:0] pdata,

    output mosi,
    output reg done
);

reg [7:0] shift_reg;
reg [3:0] bit_count;

assign mosi = shift_reg[7];

always @(posedge sclk or posedge rst)
begin
    if(rst)
    begin
        shift_reg <= 0;
        bit_count <= 0;
        done <= 0;
    end

    else if(load)
    begin
        shift_reg <= pdata;
        bit_count <= 0;
        done <= 0;
    end

    else
    begin
        shift_reg <= {shift_reg[6:0],1'b0};

        if(bit_count == 7)
            done <= 1;
        else
            bit_count <= bit_count + 1;
    end
end

endmodule
