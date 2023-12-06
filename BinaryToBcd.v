`timescale 1ns / 1ps
// module BinaryToBcd (
//     input [11:0] binary,
//     output reg [3:0] thos,
//     output reg [3:0] hund,
//     output reg [3:0] tens,
//     output reg [3:0] ones
// );

//     reg [11:0] bcd_data = 0;

//     always @(binary) begin // 1250

//         bcd_data = binary; // bcd_data = 1250
//         thos = bcd_data / 1000; // 1250 / 1000 = 1, thos = 1
//         bcd_data = bcd_data % 1000; // 1250 % 1000 = 250

//         hund = bcd_data / 100; // 250 / 100 = 2
//         bcd_data = bcd_data % 100; // 250 % 100 = 50

//         tens = bcd_data / 10; // 50 / 10 = 5

//         ones = bcd_data % 10; // 5 % 10 = 0

//     end

// endmodule
module BinaryToBcd (
    input [5:0] binary, // Changed the input width to 10 bits since you don't need thousands or hundreds place
    output reg [3:0] tens,
    output reg [3:0] ones
);

    always @(binary) begin
        tens = binary / 10;
        ones = binary % 10;
    end

endmodule