module lowlevel_dac_intfc (
    input clk,
    input rst_n,
    input [31:0] data_word,
    output sdata,
    output lrck,
    output bclk,
    output mclk,
    output latched_data
);

    logic [4:0] bit_counter;
    logic mclk_reg;
    logic bclk_reg;
    logic mclk_pulse;
    logic bclk_pulse;
    logic [31:0] data_reg;

    assign sdata = data_reg[bit_counter];
    assign lrck = (bit_counter > 0 && bit_counter < 5'b10001) ? 1'b1 : 1'b0;
    assign bclk = bclk_reg;
    assign mclk = mclk_reg;
    assign latched_data = (bit_counter == 0 && bclk_pulse && bclk_reg) ? 1'b1 : 1'b0;

    always_ff @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            bit_counter <= '0;
            mclk_reg <= 1'b0;
            bclk_reg <= 1'b0;
            data_reg <= data_word;
        end else begin
            if(latched_data)
                data_reg <= data_word;

            if(mclk_pulse)
                mclk_reg <= ~mclk_reg;
            
            if(bclk_pulse)
                bclk_reg <= ~bclk_reg;

            if(bclk_pulse && bclk_reg)
                bit_counter <= bit_counter - 1;
        end
    end

    clkdivider #(
        .DIVIDEBY(5)
    ) mclk_gen(
        .clk(clk),
        .rst_n(rst_n),
        .pulseout(mclk_pulse)
    );

    clkdivider #(
        .DIVIDEBY(5)
    ) bclk_gen(
        .clk(clk),
        .rst_n(rst_n),
        .pulseout(bclk_pulse)
    );

endmodule
