open_project TRIDENT_zybo/TRIDENT_zybo.xpr

reset_run synth_1
reset_run impl_1

launch_runs synth_1
wait_on_run synth_1

launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1

open_run impl_1
report_timing_summary -delay_type min_max -report_unconstrained \
-check_timing_verbose -max_paths 10 -input_pins -file reports/timing.rpt
write_hw_platform -fixed -include_bit -force -file bitstreams/TRIDENT_zybo.xsa
write_bitstream -bin_file -force bitstreams/TRIDENT_zybo.bit
