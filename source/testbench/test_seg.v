`timescale 1ns/1ns

module test_seg;

reg     [23:0]  seg_bcd_data;
wire    [7:0]   seg_data;
wire    [5:0]   seg_cs;
reg     clk, rst_;

seg_display segdpy(seg_bcd_data, seg_data, seg_cs, clk, rst_);

initial begin
    clk  <= 1'b0;
    rst_ <= 1'b1;
    seg_bcd_data = 24'h1234;
    #100 
    rst_ <= 1'b0;
end

always begin
    #1 clk <= ~clk;
end

endmodule