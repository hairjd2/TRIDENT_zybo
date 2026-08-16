# TRIDENT_zybo
FPGA design for the TRIDENT project using the ZYBO Z7 evaluation board. This will act as the prototyping board until we have design the real one for the device. This will include all of our internal designs and will only slightly vary from the real design
## How to get started
### What you need
- This repository will be on Vivado 2025.2. 
- Also make sure that you have the digilent board files in your boardstore, I have had troubles with that and just cloned the git repo myself and copied the files manually into their respective folder (`/path/to/Vivado/data/xhub/boards/XilinxBoardStore/boards/Digilent`).
### How to run
1. Enter the `build/` directory
2. Run the build scripts
    1. If you want the bitstream, you can just run `make all` or just `make. **NOTE**: You must have a locally built project before you can generate the bit file.
    2. If you want to just create the project, run `make project`
    3. If you've already created the project and don't want to press pesky buttons, run `make gen_hw`.
3. After running any of the scripts, you can find the logs in the `build/reports` directory. This is useful if you run into any errors. This also includes a timing report to make sure you've met timing.
4. If you ran the `make gen_hw` or `make all` command, you can also find the bitstream files in the bitstream directory. This include a binary file for the PL, the bit file, and an XSA file for when we start creating the device tree.

## Design Details
