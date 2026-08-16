# Force the project creation, and set the board part to be the ZYBO Z7-10
create_project -force TRIDENT_zybo ./TRIDENT_zybo -part xc7z010clg400-1
set_property board_part digilentinc.com:zybo-z7-10:part0:1.2 [current_project]

# Add source files, add more here when we need to or have it read from a list
add_files { \
    ../src/hdl/utils/clkdivider.sv \
    ../src/hdl/audio_if/lowlevel_dac_intfc.sv \
    ../src/bd/proc_sys/proc_sys.bd \
    ../src/hdl/top_level/TRIDENT_zybo_top.sv \
}

# Add the master constraint file
add_files -fileset constrs_1 ../src/constraints/Zybo-Z7-Master.xdc

# Have it update the compile order of the sources
update_compile_order -fileset sources_1

# Create the wrapper of the PS block design
generate_target all [get_files ../src/bd/proc_sys/proc_sys.bd]
make_wrapper -files [get_files ../src/bd/proc_sys/proc_sys.bd] -top
add_files ../src/bd/proc_sys/hdl/proc_sys_wrapper.v
