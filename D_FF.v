module D_FF (
    input clk,
    input D, // push btn
    output reg Q, 
    output reg Qbar
);
    
    always @(posedge clk) begin
        Q <= D;
        Qbar <= !Q; 
    end

endmodule   