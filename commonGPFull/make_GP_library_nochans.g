//make_GP_library: create the library of components for GP simulation
//	IN USE SINCE 06/25/2004
//	Edited 05/31/2004: Na_fast channel with slow inactivation replaces
//		previous version of Na_fast_GP.
//	New changes since last version:
//		Axon hillock, initial segment, internodal segments & nodes.

/* Note that include statements are called from the directory in which the
main genesis file (the run file, e.g.) is located. So path must be either
fully explicit (/home/jedgerton/...) or else relative to the run directories.
*/
//include ../../commonGPFull/GPchans
include ../../commonGPFull/GPsyns
include ../../commonGPFull/GPcomps_nochans

if (!{exists /library})
        create neutral /library
        disable /library
end

pushe /library
/*	
	make_Na_fast_GP_w_slowinac
        make_Na_slow_GP
	make_Kv3_GP
	make_Kv2_GP
        make_Kv4_fast_GP
	make_Kv4_slow_GP
	make_KCNQ_GP
        make_Ca_GP_conc
	make_Ca_GP_nernst
        make_Ca_HVA_GP
        make_K_ahp_GP
        make_h_HCN_GP
	make_h_HCN2_GP
*/
	make_GP_comps
	make_GP_syns
pope
