`timescale 1ns / 1ps
module TopModule (
    input clk,
    input sw, swClearAlarm, swPostPoneAlarm, swStopAlarm,
    input btnC, btnU, btnL, btnR, btnD,
    output [6:0] seg, 
    output [3:0] an,
    output ledD1, ledD2, ledD3, ledTimeAlarm, ledAlarmMode, ledClockMode,
    output [5:0] led // display seconds

);
    // wire btnCclr, btnUclr, btnRclr, btnLclr, btnDclr;
    // reg btnCclr_prev, btnUclr_prev, btnRclr_prev, btnLclr_prev, btnDclr_prev;
    wire [3:0] s1, s2, m1, m2, h1, h2;
    
    wire trigger;
    // pos can be only 1 and 2, 1 is for hour, 2 is for minute
    wire pos;
    wire currentMode;
    oneSecond asd(
        .clk(clk),
        .clk_out(trigger)
    );


    SevenSegDrive manage4digit(
        .clk(clk),
        .clr(sw),
        .trigger(trigger),
        .in1(h2),
        .in2(h1),
        .in3(m2),
        .in4(m1),
        .seg(seg),
        .an(an)
    );
    
    DigitalClock makeTime(
        .clk(clk),
        .sw(sw),
        .swClearAlarm(swClearAlarm),
        .swPostPoneAlarm(swPostPoneAlarm),
        .swStopAlarm(swStopAlarm),
        .trigger(trigger),
        .s1(s1),
        .s2(s2),
        .m1(m1),
        .m2(m2),
        .h1(h1),
        .h2(h2),
        .pos(pos),
        .currentMode(currentMode),
        .btnC(btnC), 
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        .ledAlarmMode(ledAlarmMode),
        .ledTimeAlarm(ledTimeAlarm)
    );

    assign ledD1 = (pos == 1'b0) ? 1'b1 : 1'b0;
    //assign ledD2 = 
    assign ledD3 = (pos == 1'b1) ? 1'b1 : 1'b0;
    assign ledAlarmMode = (currentMode == 1'b1) ? 1'b1 : 1'b0;
    assign ledClockMode = (currentMode == 1'b0) ? 1'b1 : 1'b0;
    //  if (ledAlarmMode == ALARM) ledAlarmMode <= 1'b1;
    //     else ledAlarmMode <= 1'b0;

    assign led[0] = (s2 == 1) ? 1'b1 : 1'b0;
    assign led[1] = (s2 == 2) ? 1'b1 : 1'b0;
    assign led[2] = (s2 == 3) ? 1'b1 : 1'b0;
    assign led[3] = (s2 == 4) ? 1'b1 : 1'b0;
    assign led[4] = (s2 == 5 && s1 != 9) ? 1'b1 : 1'b0;
    assign led[5] = (s2 == 5 && s1 == 9) ? 1'b1 : 1'b0;
    
endmodule