module baud_gen(
    input clk,
    input rst,
    input enable,

    output reg sclk
);

reg [2:0] count;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        count <= 0;
        sclk <= 0;
    end
    else if(enable)
    begin
        if(count == 3)
        begin
            sclk <= ~sclk;
            count <= 0;
        end
        else
            count <= count + 1;
    end
    else
    begin
        count <= 0;
        sclk <= 0;
    end
end

endmodule
