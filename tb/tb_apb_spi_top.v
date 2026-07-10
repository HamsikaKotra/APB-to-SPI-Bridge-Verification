module tb_apb_spi_top;

reg pclk;
reg presetn;

reg psel;
reg penable;
reg pwrite;

reg [7:0] pwdata;

wire sclk;
wire ss_n;
wire mosi;

// Instantiate the Design Under Test (DUT)
apb_spi_top DUT(
    .pclk(pclk),
    .presetn(presetn),
    .psel(psel),
    .penable(penable),
    .pwrite(pwrite),
    .pwdata(pwdata),
    .sclk(sclk),
    .ss_n(ss_n),
    .mosi(mosi)
);

// Free-running clock generator (100 ps / 10 ns period)
initial
begin
    pclk = 0;
    forever #5 pclk = ~pclk;
end

// Synchronized Stimulus Block
initial
begin
    // Initialize all input signals to a safe default state
    presetn = 0;
    psel    = 0;
    penable = 0;
    pwrite  = 0;
    pwdata  = 8'h00;

    // Hold reset for a few cycles, then release
    #25; 
    presetn = 1;

    // Wait for the next clean rising clock edge to align our signals
    @(posedge pclk);
    #1;
    // -------------------------------------------------------------
    // PHASE 1: APB SETUP PHASE
    // -------------------------------------------------------------
    // Assert psel and drive data/controls, but leave penable LOW.
    psel    = 1;
    pwrite  = 1;
    pwdata  = 8'hA5; // Your data payload (10100101)
    penable = 0;     

    @(posedge pclk); // Hold for exactly 1 clock cycle
    #1;
    // -------------------------------------------------------------
    // PHASE 2: APB ACCESS PHASE
    // -------------------------------------------------------------
    // Assert penable HIGH. The DUT captures data on the next edge.
    penable = 1;     

    @(posedge pclk); // Hold for exactly 1 clock cycle
    #1;
    // -------------------------------------------------------------
    // PHASE 3: TRANSACTION COMPLETE
    // -------------------------------------------------------------
    // De-assert APB bus controls back to IDLE state
    psel    = 0;
    penable = 0;
    pwrite  = 0;
    pwdata  = 8'h00;

    // Leave ample time for the internal SPI state machine to finish
    // shifting out all 8 bits over the MOSI line.
    #5000; 
    
    $stop;
end

endmodule