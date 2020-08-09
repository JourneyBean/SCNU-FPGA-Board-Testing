module test_clkdiv;

reg     clk_50mhz, rst_;
wire    clk_1khz;

defparam div.in_freq = 50;
defparam div.out_freq = 10;

clkdiv div(clk_50mhz, clk_1khz, rst_);

initial begin
    clk_50mhz <= 1'b0;
    rst_      <= 1'b1;
    #100
    rst_ <= 1'b0;
end

always begin
    #1 clk_50mhz <= ~clk_50mhz;
end

endmodule