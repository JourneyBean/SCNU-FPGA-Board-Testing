module test_board_test;

reg     clk;
wire    [7:0]   seg_data;
wire    [5:0]   seg_cs;

board_test tst(clk, seg_data, seg_cs);

initial begin
    clk <= 0;
end

always begin
    #1 clk <= ~clk;
end

endmodule