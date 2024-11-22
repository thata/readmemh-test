all: ulx3s.bit

clean:
	rm -rf readmemh-test.json ulx3s_out.config ulx3s.bit

ulx3s.bit: ulx3s_out.config
	ecppack ulx3s_out.config ulx3s.bit

ulx3s_out.config: readmemh-test.json
	nextpnr-ecp5 --85k --json readmemh-test.json --lpf ulx3s_v20.lpf --textcfg ulx3s_out.config

readmemh-test.json: top.sv
	yosys -p "hierarchy -top top" -p "proc; opt" -p "synth_ecp5 -noccu2 -nomux -nodram -json readmemh-test.json" top.sv

prog: ulx3s.bit
	fujprog ulx3s.bit
