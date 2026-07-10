module apb_spi_top(
    input pclk,
    input presetn,

    input psel,
    input penable,
    input pwrite,

    input [7:0] pwdata,

    output sclk,
    output ss_n,
    output mosi
);

wire start;
wire done;
wire [7:0] tx_data;

// New register to track if an SPI transmission is actively running
reg spi_active;

always @(posedge pclk or negedge presetn) begin
    if (!presetn) begin
        spi_active <= 1'b0;
    end else begin
        if (start) begin
            spi_active <= 1'b1;  // Turn on clock generation when APB triggers it
        end else if (done) begin
            spi_active <= 1'b0;  // Turn off clock generation when 8 bits are done shifting
        end
    end
end

// 1. APB Bus Interface Instance
apb_interface U1(
    .pclk(pclk),
    .presetn(presetn),
    .psel(psel),
    .penable(penable),
    .pwrite(pwrite),
    .pwdata(pwdata),
    .tx_data(tx_data),
    .start(start)
);

// 2. Baud Rate Generator Instance
baud_gen U2(
    .clk(pclk),
    .rst(~presetn),
    .enable(spi_active), // Fixed: Stays enabled until 'done' asserts
    .sclk(sclk)
);

// 3. Shift Register Instance
shift_register U3(
    .sclk(sclk),
    .rst(~presetn),
    .load(start),        // Load the parallel data on the initial APB write strobe
    .pdata(tx_data),
    .mosi(mosi),
    .done(done)
);

// 4. Slave Select Logic Instance
slave_select U4(
    .start(start),
    .done(done),
    .ss_n(ss_n)
);

endmodule