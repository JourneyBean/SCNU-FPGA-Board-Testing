/**
    实验板硬件：
        输入：8按键
        输出：8LED，6片数码管，33个IO
    实现功能：
*/

module board_test
(
    input   wire    clk_50mhz ,
    output  wire    [7:0]   seg_data ,
    output  wire    [5:0]   seg_cs ,
    input   wire    [7:0]   key ,
    output  reg     [7:0]   led
);

wire    clk_1hz, clk_100hz, clk_300hz ;
wire    key_rst, key_led, key_pause;
reg     key_pause_last, key_led_last;
wire    rst_;
reg     ctl_counton;
reg     [23:0]  seg_bcd_data ;

/* -------- 分频模块 -------- */
defparam div_50m_300.in_freq = 50000000;
defparam div_50m_300.out_freq = 517;
clkdiv div_50m_300(clk_50mhz, clk_300hz, rst_);

defparam div_50m_100.in_freq = 50000000;
defparam div_50m_100.out_freq = 142;
clkdiv div_50m_100(clk_50mhz, clk_100hz, rst_);

defparam div_50m_1.in_freq = 50000000;
defparam div_50m_1.out_freq = 1;
clkdiv div_50m_1(clk_50mhz, clk_1hz, rst_);

/* -------- 数码管模块 -------- */
seg_display segdpy(seg_bcd_data, seg_data, seg_cs, clk_300hz, rst_);

/* -------- 按键消抖模块 -------- */
key_handler k_rst(key[7], key_rst, clk_100hz, rst_);
key_handler k_led(key[0], key_led, clk_100hz, rst_);
key_handler k_pause(key[1], key_pause, clk_100hz, rst_);

/* -------- 重置模块 -------- */
assign rst_ = ~key_rst;


/* -------- 初始化 --------  */
initial begin
    seg_bcd_data <= 24'b0;
    ctl_counton <= 1'b0;
    led[7:0] <= 8'b0000_0000;
    key_led_last <= 1'b0;
    key_pause_last <= 1'b0;
end

/* -------- BCD计数 -------- */
always @ (posedge clk_1hz or negedge rst_) begin
    if (~rst_) begin
        seg_bcd_data <= 0;
    end
    else begin
        if (ctl_counton) seg_bcd_data <= seg_bcd_data+1;
        else seg_bcd_data <= seg_bcd_data;
    end
end

/* -------- 按键事件 -------- */
always @ (posedge clk_300hz or negedge rst_) begin
    // 重置信号
    if (~rst_) begin
        led[7:0] <= 8'b0000_0000;
        ctl_counton <= 1'b0;
        key_led_last <= 1'b0;
        key_pause_last <= 1'b0;
    end
    // 其他按键
    else begin
        // led按键
        if (key_led) begin
            key_led_last <= key_led;        // 记录按下状态
            // 取上升沿
            if (~key_led_last) begin
                led[7:0] <= ~led[7:0];      // 按键处理
            end
        end
        else begin
            key_led_last <= 1'b0;           // 记录弹起状态
        end
        // 暂停按键
        if (key_pause) begin
            key_pause_last <= key_pause;
            // 取上升沿
            if (~key_pause_last) begin
                ctl_counton <= ~ctl_counton;
            end
        end
        else begin
            key_pause_last <= 1'b0;
        end
    end
    
end

endmodule