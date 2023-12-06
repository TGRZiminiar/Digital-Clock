`timescale 1ns / 1ps
module SevenSegDrive (
    input clk,
    input clr,
    input trigger,
    input [3:0] in1,
    input [3:0] in2,
    input [3:0] in3,
    input [3:0] in4,
    output reg [6:0] seg,
    output reg [3:0] an
);


    wire [6:0] seg1, seg2, seg3, seg4;
    // this value is use to make human eye can't catch when changing the number
    reg [12:0] segClk; // for turning segment display one by one on the board, 8192, 0-8191

    // Represent the seven segment display
    localparam LEFT = 2'b00, MIDLEFT = 2'b01, MIDRIGHT = 2'b10, RIGHT = 2'b11;
    reg [1:0] state=LEFT;

    always @(posedge clk) begin
        segClk <= segClk + 1'b1; // Counter up by one
    end

    always @(posedge segClk[12] or posedge clr) begin
        if(clr == 1) begin
            seg <= 7'b0000000;
            an <= 4'b0000;
            state <= LEFT;
        end
        else begin
            case (state)
                LEFT: begin
                    seg <= seg1;
                    an <= 4'b0111;
                    state <= MIDLEFT;
                end

                MIDLEFT: begin
                    seg <= seg2;
                    an <= 4'b1011;
                    state <= MIDRIGHT;
                end
                
                MIDRIGHT: begin
                    seg <= seg3;
                    an <= 4'b1101;
                    state <= RIGHT;
                end

                RIGHT: begin
                    seg <= seg4;
                    an <= 4'b1110;
                    state <= LEFT;
                end

            endcase
        end
    end

    Decoder7Segment disp1(in1, seg1);
    Decoder7Segment disp2(in2, seg2);
    Decoder7Segment disp3(in3, seg3);
    Decoder7Segment disp4(in4, seg4);

endmodule