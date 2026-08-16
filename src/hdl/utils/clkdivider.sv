module clkdivider #(
    parameter int DIVIDEBY = 2
)(
    input clk,
    input rst_n,
    output pulseout
);

    int count;

    assign pulseout = (count == DIVIDEBY-1) ? 1'b1 : 1'b0;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            count <= '0;
        else begin
            if(count == DIVIDEBY-1)
                count <= '0;
            else
                count <= count + 1;
        end 
    end

endmodule
