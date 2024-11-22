// RAM上の8ビットのパターンデータをLEDに出力する。
// 表示パターンは、1秒ごとに切り替わる。
module top(
    input clk, // 25MHz のクロック
    output reg [7:0] led
);
    logic [24:0] cnt = 0;
    logic [2:0] idx = 0;
    logic [7:0] pattern [0:7];

    logic [24:0] cnt_next = (cnt < 25000000)
                              ? cnt + 1
                              : 0;
    logic [2:0] idx_next = (cnt == 0)
                             ? idx + 1
                             : idx;
    logic [7:0] led_next = pattern[idx];

    initial begin
        // HEX ファイル pattern.mem からパターンを読み込む
        $readmemh("pattern.mem", pattern);
    end

    always @(posedge clk) begin
        cnt <= cnt_next;
        idx <= idx_next;
        led <= led_next;
    end
endmodule
