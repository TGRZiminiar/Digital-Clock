module Debounce (
    input pb, clk_in,
    // pb = push button
    output led
);

    wire clk_out;
    wire Q1, Q2, Q2_bar;

    Show_Clock_100Hz u1(clk_in, clk_out);
    D_FF d1(clk_out, pb, Q1);
    D_FF d2(clk_out, Q1, Q2);

    assign Q2_bar = ~Q2;
    assign led = Q1 & Q2_bar;
endmodule