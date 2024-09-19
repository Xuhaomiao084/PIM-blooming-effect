NOVAS_PATH = /ux/cad/synopsys/verdi/S-2021.09-SP2/
NOVAS_INC =  -P $(NOVAS_PATH)/share/PLI/VCS/LINUX64/novas.tab $(NOVAS_PATH)/share/PLI/VCS/LINUX64/pli.a
CORE_VERSION = 1

clean:
	\rm -rf *.fsdb
	\rm -rf simv*
	\rm -rf csrc
	\rm -rf novas*
	\rm -rf verdi*
	\rm -rf vfastLog
	\rm -rf ./mem_files/*.txt
	\rm ucli.key

data:
	python3 ./mem_files/generate.py $(CORE_VERSION)

comp: 
	vcs $(NOVAS_INC) -sverilog -debug_access+all -v2k_generate -full64 -lca -kdb -f flist.f +incdir+. -timescale=1ps/1ps -top tb_my_core
 
run: data comp
	./simv

wave: data run 
	verdi -ssf device.fsdb &

check: 
	./check.csh