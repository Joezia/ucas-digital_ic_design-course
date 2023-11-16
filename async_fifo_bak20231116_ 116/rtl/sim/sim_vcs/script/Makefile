### ================== Design
FSDB_FILE = top.fsdb
DESIGN_TOP = tb_async_fifo


### ================== Simulation setup
NOVAS_HOME = $(VERDI_HOME)
SIM_PATH = ./sim
SCR_DIR = script
VCS_ELAB_OPTS = -full64 -t ps -licqueue -l $(SIM_PATH)/elab.log -debug_access+all
VLOGAN_OPTS = -full64 +v2k -l $(SIM_PATH)/com_vlg.log +define+SIMULATION_EN -sverilog -f $(SCR_DIR)/filelist.f -kdb
VHDLAN_OPTS = -full64 -l $(SIM_PATH)/com_vhd.log -nc -f $(SCR_DIR)/filelist_vhd.f
SIM_OPTS = $(SIM_PATH)/simv -l $(SIM_PATH)/sim.log +notimingcheck +nospecify

### ================== Targets
.PHONY:comp comp_fsdb elab
.PHONY:sim sim_verdi
.PHONY:verdi
.PHONY:clean

dbg:comp_fsdb elab sim verdi
dbg_verdi:comp elab sim_verdi

comp:init_dir
	vlogan $(VLOGAN_OPTS)
# 	vhdlan $(VHDLAN_OPTS)

comp_fsdb:init_dir
	vlogan $(VLOGAN_OPTS) +define+DUMP_FSDB
# 	vhdlan $(VHDLAN_OPTS)

elab:
	vcs ${VCS_ELAB_OPTS} \
	work.$(DESIGN_TOP) \
	-o $(SIM_PATH)/simv \
	-cm line+cond+fsm+branch+tgl \
	-cm_name $(DESIGN_TOP) \
	-cm_dir ./$(DESIGN_TOP).vdb

sim:
	$(SIM_OPTS)

sim_verdi:
	$(SIM_OPTS) -verdi

verdi:
	verdi \
	-ssf $(FSDB_FILE)

init_dir:clean
	@mkdir -p sim

clean:
	rm -rf ./sim ./64 ./vcs_lib ./csrc ./verdiLog ./*.log ./*.fsdb ./ucli.key ./inter.vpd ./novas* ./DVEfiles ./simv ./simv.daidir ./*.vdb
