module TRIDENT_zybo_top (
    input sysclk,
    input reset_pb,
    // DDR I/O
    inout [14:0]    DDR_addr,
    inout [2:0]     DDR_ba,
    inout           DDR_cas_n,
    inout           DDR_ck_n,
    inout           DDR_ck_p,
    inout           DDR_cke,
    inout           DDR_cs_n,
    inout [3:0]     DDR_dm,
    inout [31:0]    DDR_dq,
    inout [3:0]     DDR_dqs_n,
    inout [3:0]     DDR_dqs_p,
    inout           DDR_odt,
    inout           DDR_ras_n,
    inout           DDR_reset_n,
    inout           DDR_we_n,
    // FIXED I/O
    inout           FIXED_IO_ddr_vrn,
    inout           FIXED_IO_ddr_vrp,
    inout [53:0]    FIXED_IO_mio,
    inout           FIXED_IO_ps_clk,
    inout           FIXED_IO_ps_porb,
    inout           FIXED_IO_ps_srstb,
    // I2S I/O
    output ac_bclk,
    output ac_mclk,
    output ac_muten,
    output ac_pbdat,
    output ac_pblrc,
    // Audio I2C I/O
    inout ac_scl,
    inout ac_sda
);

    logic rst_n;
    logic data_word;
    logic latched_data;

    assign rst_n = ~reset_pb;
    
    assign ac_muten = 1'b1;
    assign data_word = '0; // Hardcoding for now
    lowlevel_dac_intfc u_lowlevel_dac_intfc (
        .clk(sysclk),
        .rst_n(rst_n),
        .data_word(data_word),
        .sdata(ac_pbdat),
        .lrck(ac_pblrc),
        .bclk(ac_bclk),
        .mclk(ac_mclk),
        .latched_data(latched_data)
    );

    proc_sys_wrapper u_proc_sys_wrapper(
        .DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .audio_i2c_scl_io(ac_scl),
        .audio_i2c_sda_io(ac_sda)
    );

endmodule
