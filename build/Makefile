project:
	vivado \
		-mode batch \
		-source scripts/build_project.tcl \
		-log reports/build_project.log 

gen_hw:
	@if [ ! -d "TRIDENT_zybo" ]; then \
		echo "You have not created the project yet, creating it now"; \
		make project; \
	fi

	vivado \
		-mode batch \
		-source scripts/gen_hw.tcl \
		-log reports/gen_hw.log
