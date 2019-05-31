//FILE IN USE 09/30/2004 -- present.

//genesis - genesis2.2 script, J Hanson 5/02
//axon rebuilt with hillock, initial segment, nodes and internodal
//	segments 06/25/2004 according to Shen et al (1999).
// 06/28/2004: added KCNQ to axon, added G_mult_KCNQ_dend and G_mult_KCNQ_axon
// 09/30/2004: changed dendritic subclassifications to match the data of
//		Hanson & Smith, 2004.
// 03/16/2006: removed all axonal prototypes for the reduced model version of this file
//		changed RA and CM references to RA_sd and CM_sd, of RA_prox and CM_prox as 
//		appropriate.  E. Hendrickson

float PI = 3.14159

function make_GP_comps
	float len, dia, surf, rad, vol, core_vol, shell_vol
	float rad_core, shell_vol
	int i

/* make spherical soma prototype */
	len = 0 
	dia = 1 
	rad = {dia}/2
	rad_core = rad - {shell_thick} 
	surf = 4*{PI}*rad*rad
	vol = 4.0/3.0*{PI}*rad*rad*rad
	core_vol = 4.0/3.0*{PI}*rad_core*rad_core*rad_core
	shell_vol = vol - core_vol
	if (!({exists GP_soma}))
		create compartment GP_soma
	end
	setfield GP_soma Cm {{CM_sd}*surf} Ra {8.0*{RA_sd}/({dia}*{PI})}  \
		Em {ELEAK_sd} initVm {EREST_ACT} Rm {{RM_sd}/surf} inject 0.0  \
		dia {dia} len {len}

/* put channels in soma */
	copy Ca_HVA_GP GP_soma/Ca_HVA_GP
	addmsg GP_soma GP_soma/Ca_HVA_GP VOLTAGE Vm
	addmsg GP_soma/Ca_HVA_GP GP_soma CHANNEL Gk Ek
	setfield GP_soma/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_soma}*surf}

	copy K_ahp_GP GP_soma/K_ahp_GP
	addmsg GP_soma GP_soma/K_ahp_GP VOLTAGE Vm
        addmsg GP_soma/K_ahp_GP GP_soma CHANNEL Gk Ek
        setfield GP_soma/K_ahp_GP Gbar	\
		{{G_SK_soma}*surf}

	copy Ca_GP_nernst GP_soma/Ca_GP_nernst
	copy Ca_GP_conc GP_soma/Ca_GP_conc
	addmsg GP_soma/Ca_HVA_GP GP_soma/Ca_GP_conc I_Ca Ik 
	addmsg GP_soma/Ca_GP_conc GP_soma/Ca_HVA_GP CONCEN Ca
	addmsg GP_soma/Ca_GP_conc GP_soma/K_ahp_GP CONCEN Ca
	addmsg GP_soma/Ca_GP_conc GP_soma/Ca_GP_nernst CIN Ca
	addmsg GP_soma/Ca_GP_nernst GP_soma/Ca_HVA_GP EK E 
	setfield GP_soma/Ca_GP_conc B {{B_Ca_GP_conc}/shell_vol}

   	copy Na_fast_GP GP_soma/Na_fast_GP
        addmsg GP_soma GP_soma/Na_fast_GP VOLTAGE Vm
        addmsg GP_soma/Na_fast_GP GP_soma CHANNEL Gk Ek
        setfield GP_soma/Na_fast_GP Gbar	\
		{{G_NaF_soma}*surf}

	copy Na_slow_GP GP_soma/Na_slow_GP
        addmsg GP_soma GP_soma/Na_slow_GP VOLTAGE Vm
        addmsg GP_soma/Na_slow_GP GP_soma CHANNEL Gk Ek
        setfield GP_soma/Na_slow_GP Gbar	\
		{{G_NaP_soma}*surf}

	copy Kv3_GP GP_soma/Kv3_GP
        addmsg GP_soma GP_soma/Kv3_GP VOLTAGE Vm
        addmsg GP_soma/Kv3_GP GP_soma CHANNEL Gk Ek
        setfield GP_soma/Kv3_GP Gbar	\
		{{G_Kv3_soma}*surf} 

	copy Kv2_GP GP_soma/Kv2_GP
        addmsg GP_soma GP_soma/Kv2_GP VOLTAGE Vm
        addmsg GP_soma/Kv2_GP GP_soma CHANNEL Gk Ek
	setfield GP_soma/Kv2_GP Gbar	\
		{{G_Kv2_soma}*surf}

	copy Kv4_fast_GP GP_soma/Kv4_fast_GP
        addmsg GP_soma GP_soma/Kv4_fast_GP VOLTAGE Vm
        addmsg GP_soma/Kv4_fast_GP GP_soma CHANNEL Gk Ek
        setfield GP_soma/Kv4_fast_GP Gbar	\
		{{G_Kv4f_soma}*surf}

	copy Kv4_slow_GP GP_soma/Kv4_slow_GP
        addmsg GP_soma GP_soma/Kv4_slow_GP VOLTAGE Vm
        addmsg GP_soma/Kv4_slow_GP GP_soma CHANNEL Gk Ek
        setfield GP_soma/Kv4_slow_GP Gbar	\
		{{G_Kv4s_soma}*surf}
	
	copy KCNQ_GP GP_soma/KCNQ_GP
        addmsg GP_soma GP_soma/KCNQ_GP VOLTAGE Vm
        addmsg GP_soma/KCNQ_GP GP_soma CHANNEL Gk Ek
        setfield GP_soma/KCNQ_GP Gbar	\
		{{G_KCNQ_soma}*surf}

	copy h_HCN_GP GP_soma/h_HCN_GP
        addmsg GP_soma GP_soma/h_HCN_GP VOLTAGE Vm
        addmsg GP_soma/h_HCN_GP GP_soma CHANNEL Gk Ek
        setfield GP_soma/h_HCN_GP Gbar	\
		{{G_h_HCN_soma}*surf}
		
	copy h_HCN2_GP GP_soma/h_HCN2_GP
        addmsg GP_soma GP_soma/h_HCN2_GP VOLTAGE Vm
        addmsg GP_soma/h_HCN2_GP GP_soma CHANNEL Gk Ek
        setfield GP_soma/h_HCN2_GP Gbar	\
		{{G_h_HCN2_soma}*surf}

/* make axon comp*/
	len = 1 
	dia = 1 
	rad = {dia} / 2
	surf = 2*{PI}*rad*{len} 
	vol = {PI}*rad*rad*{len} 
        if (!({exists GP_ax}))
            create compartment GP_ax
        end
        setfield GP_ax Cm {{CM_sd}*surf} Ra {4.0*{RA_sd}*{len}/({dia}*{dia}*{PI})}  \
                Em {ELEAK_sd} initVm {EREST_ACT} Rm {{RM_sd}/surf} inject 0.0  \
                dia {dia} len {len}
		
/* put channels in axon comp */
	copy Na_fast_GP GP_ax/Na_fast_GP
	addmsg GP_ax GP_ax/Na_fast_GP VOLTAGE Vm
	addmsg GP_ax/Na_fast_GP GP_ax CHANNEL Gk Ek
	setfield GP_ax/Na_fast_GP Gbar	\
		{{G_NaF_axon}*surf}
	
	copy Na_slow_GP GP_ax/Na_slow_GP
        addmsg GP_ax GP_ax/Na_slow_GP VOLTAGE Vm
        addmsg GP_ax/Na_slow_GP GP_ax CHANNEL Gk Ek
        setfield GP_ax/Na_slow_GP Gbar	\
		{{G_NaP_axon}*surf}
		
	copy Kv4_fast_GP GP_ax/Kv4_fast_GP
        addmsg GP_ax GP_ax/Kv4_fast_GP VOLTAGE Vm
        addmsg GP_ax/Kv4_fast_GP GP_ax CHANNEL Gk Ek
        setfield GP_ax/Kv4_fast_GP Gbar	\
		{{G_Kv4f_axon}*surf}

	copy Kv4_slow_GP GP_ax/Kv4_slow_GP
        addmsg GP_ax GP_ax/Kv4_slow_GP VOLTAGE Vm
        addmsg GP_ax/Kv4_slow_GP GP_ax CHANNEL Gk Ek
        setfield GP_ax/Kv4_slow_GP Gbar	\
		{{G_Kv4s_axon}*surf}
	
	copy Kv3_GP GP_ax/Kv3_GP
        addmsg GP_ax GP_ax/Kv3_GP VOLTAGE Vm
        addmsg GP_ax/Kv3_GP GP_ax CHANNEL Gk Ek
        setfield GP_ax/Kv3_GP Gbar	\
		{{G_Kv3_axon}*surf}
	
	copy Kv2_GP GP_ax/Kv2_GP
        addmsg GP_ax GP_ax/Kv2_GP VOLTAGE Vm
        addmsg GP_ax/Kv2_GP GP_ax CHANNEL Gk Ek
        setfield GP_ax/Kv2_GP Gbar	\
		{{G_Kv2_axon}*surf}

	copy KCNQ_GP GP_ax/KCNQ_GP
        addmsg GP_ax GP_ax/KCNQ_GP VOLTAGE Vm
        addmsg GP_ax/KCNQ_GP GP_ax CHANNEL Gk Ek
        setfield GP_ax/KCNQ_GP Gbar	\
		{{G_KCNQ_axon}*surf}


//	Dendritic prototype = dendrite_p
	len = 1 
	dia = 1 
	rad = {dia} / 2
	surf = 2*{PI}*rad*{len} 
	vol = {PI}*rad*rad*{len} 
	if (dia > {{shell_thick}*2})
		rad_core = rad - {shell_thick}
		core_vol = {PI}*rad_core*rad_core*{len} 
		shell_vol = vol - core_vol
	else
		shell_vol = vol
	end
	if (!({exists GP_dendrite_p}))
	    create compartment GP_dendrite_p
	end
	setfield GP_dendrite_p Cm {{CM_prox}*surf} Ra {4.0*{RA_prox}*{len}/({dia}*{dia}*{PI})}  \
        	Em {ELEAK_sd} initVm {EREST_ACT} Rm {{RM_prox}/surf} inject 0.0  \
        	dia {dia} len {len}

// Put shared channels in prototype dendrite
        copy Ca_HVA_GP GP_dendrite_p/Ca_HVA_GP
        addmsg GP_dendrite_p GP_dendrite_p/Ca_HVA_GP VOLTAGE Vm
        addmsg GP_dendrite_p/Ca_HVA_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_dend}*surf}

	copy K_ahp_GP GP_dendrite_p/K_ahp_GP
        addmsg GP_dendrite_p GP_dendrite_p/K_ahp_GP VOLTAGE Vm
        addmsg GP_dendrite_p/K_ahp_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/K_ahp_GP Gbar	\
		{{G_SK_dend}*surf}

	copy Ca_GP_nernst GP_dendrite_p/Ca_GP_nernst 
        copy Ca_GP_conc GP_dendrite_p/Ca_GP_conc
        addmsg GP_dendrite_p/Ca_HVA_GP GP_dendrite_p/Ca_GP_conc I_Ca Ik 
        addmsg GP_dendrite_p/Ca_GP_conc GP_dendrite_p/Ca_HVA_GP CONCEN Ca
	addmsg GP_dendrite_p/Ca_GP_conc GP_dendrite_p/K_ahp_GP CONCEN Ca 
	addmsg GP_dendrite_p/Ca_GP_conc GP_dendrite_p/Ca_GP_nernst CIN Ca
        addmsg GP_dendrite_p/Ca_GP_nernst GP_dendrite_p/Ca_HVA_GP EK E 
        setfield GP_dendrite_p/Ca_GP_conc B {{B_Ca_GP_conc}/shell_vol}

        copy Na_fast_GP GP_dendrite_p/Na_fast_GP
        addmsg GP_dendrite_p GP_dendrite_p/Na_fast_GP VOLTAGE Vm
        addmsg GP_dendrite_p/Na_fast_GP GP_dendrite_p CHANNEL Gk Ek
	setfield GP_dendrite_p/Na_fast_GP Gbar	\
	{{G_NaF_dend}*surf}

	copy Na_slow_GP GP_dendrite_p/Na_slow_GP
        addmsg GP_dendrite_p GP_dendrite_p/Na_slow_GP VOLTAGE Vm
        addmsg GP_dendrite_p/Na_slow_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/Na_slow_GP Gbar	\
	{{G_NaP_dend}*surf}

	copy Kv3_GP GP_dendrite_p/Kv3_GP
        addmsg GP_dendrite_p GP_dendrite_p/Kv3_GP VOLTAGE Vm
        addmsg GP_dendrite_p/Kv3_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/Kv3_GP Gbar	\
		{{G_Kv3_dend}*surf}

	copy Kv2_GP GP_dendrite_p/Kv2_GP
        addmsg GP_dendrite_p GP_dendrite_p/Kv2_GP VOLTAGE Vm
        addmsg GP_dendrite_p/Kv2_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/Kv2_GP Gbar	\
		{{G_Kv2_dend}*surf}

	copy Kv4_fast_GP GP_dendrite_p/Kv4_fast_GP
        addmsg GP_dendrite_p GP_dendrite_p/Kv4_fast_GP VOLTAGE Vm
        addmsg GP_dendrite_p/Kv4_fast_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/Kv4_fast_GP Gbar	\
		{{G_Kv4f_dend}*surf}

	copy Kv4_slow_GP GP_dendrite_p/Kv4_slow_GP
        addmsg GP_dendrite_p GP_dendrite_p/Kv4_slow_GP VOLTAGE Vm
        addmsg GP_dendrite_p/Kv4_slow_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/Kv4_slow_GP Gbar	\
		{{G_Kv4s_dend}*surf}
	
	copy KCNQ_GP GP_dendrite_p/KCNQ_GP
        addmsg GP_dendrite_p GP_dendrite_p/KCNQ_GP VOLTAGE Vm
        addmsg GP_dendrite_p/KCNQ_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/KCNQ_GP Gbar	\
		{{G_KCNQ_dend}*surf}

        copy h_HCN_GP GP_dendrite_p/h_HCN_GP
        addmsg GP_dendrite_p GP_dendrite_p/h_HCN_GP VOLTAGE Vm
        addmsg GP_dendrite_p/h_HCN_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/h_HCN_GP Gbar	\
		{{G_h_HCN_dend}*surf}

        copy h_HCN2_GP GP_dendrite_p/h_HCN2_GP
        addmsg GP_dendrite_p GP_dendrite_p/h_HCN2_GP VOLTAGE Vm
        addmsg GP_dendrite_p/h_HCN2_GP GP_dendrite_p CHANNEL Gk Ek
        setfield GP_dendrite_p/h_HCN2_GP Gbar	\
		{{G_h_HCN2_dend}*surf}

// Make the actual dendritic components based on the prototype.
	if (!({exists GP_dendrite_d0_dia2}))
             copy GP_dendrite_p GP_dendrite_d0_dia2
    end
	
	if (!({exists GP_dendrite_d0_dia1}))
             copy GP_dendrite_p GP_dendrite_d0_dia1
    end
	
	if (!({exists GP_dendrite_d0_dia0}))
             copy GP_dendrite_p GP_dendrite_d0_dia0
    end
	
	if (!({exists GP_dendrite_d25_dia2}))
             copy GP_dendrite_p GP_dendrite_d25_dia2
    end
	
	if (!({exists GP_dendrite_d25_dia1}))
             copy GP_dendrite_p GP_dendrite_d25_dia1
    end
	
	if (!({exists GP_dendrite_d25_dia0}))
             copy GP_dendrite_p GP_dendrite_d25_dia0
    end
	
	if (!({exists GP_dendrite_d50_dia2}))
             copy GP_dendrite_p GP_dendrite_d50_dia2
    end
	
	if (!({exists GP_dendrite_d50_dia1}))
             copy GP_dendrite_p GP_dendrite_d50_dia1
    end
	
	if (!({exists GP_dendrite_d50_dia0}))
             copy GP_dendrite_p GP_dendrite_d50_dia0
    end
	
	if (!({exists GP_dendrite_d100_dia2}))
             copy GP_dendrite_p GP_dendrite_d100_dia2
    end
	
	if (!({exists GP_dendrite_d100_dia1}))
             copy GP_dendrite_p GP_dendrite_d100_dia1
    end
	
	if (!({exists GP_dendrite_d100_dia0}))
             copy GP_dendrite_p GP_dendrite_d100_dia0
    end
	
	if (!({exists GP_dendrite_d200_dia2}))
             copy GP_dendrite_p GP_dendrite_d200_dia2
    end
	
	if (!({exists GP_dendrite_d200_dia1}))
             copy GP_dendrite_p GP_dendrite_d200_dia1
    end
	
	if (!({exists GP_dendrite_d200_dia0}))
             copy GP_dendrite_p GP_dendrite_d200_dia0
    end
	
	if (!({exists GP_dendrite_d300_dia2}))
             copy GP_dendrite_p GP_dendrite_d300_dia2
    end
	
	if (!({exists GP_dendrite_d300_dia1}))
             copy GP_dendrite_p GP_dendrite_d300_dia1
    end
	
	if (!({exists GP_dendrite_d300_dia0}))
             copy GP_dendrite_p GP_dendrite_d300_dia0
    end
	
	if (!({exists GP_dendrite_d400_dia2}))
             copy GP_dendrite_p GP_dendrite_d400_dia2
    end
	
	if (!({exists GP_dendrite_d400_dia1}))
             copy GP_dendrite_p GP_dendrite_d400_dia1
    end
	
	if (!({exists GP_dendrite_d400_dia0}))
             copy GP_dendrite_p GP_dendrite_d400_dia0
    end
	
	if (!({exists GP_dendrite_d500_dia2}))
             copy GP_dendrite_p GP_dendrite_d500_dia2
    end
	
	if (!({exists GP_dendrite_d500_dia1}))
             copy GP_dendrite_p GP_dendrite_d500_dia1
    end
	
	if (!({exists GP_dendrite_d500_dia0}))
             copy GP_dendrite_p GP_dendrite_d500_dia0
    end
	
	if (!({exists GP_dendrite_d600_dia2}))
             copy GP_dendrite_p GP_dendrite_d600_dia2
    end
	
	if (!({exists GP_dendrite_d600_dia1}))
             copy GP_dendrite_p GP_dendrite_d600_dia1
    end
	
	if (!({exists GP_dendrite_d600_dia0}))
             copy GP_dendrite_p GP_dendrite_d600_dia0
    end
	
	if (!({exists GP_dendrite_d700_dia2}))
             copy GP_dendrite_p GP_dendrite_d700_dia2
    end
	
	if (!({exists GP_dendrite_d700_dia1}))
             copy GP_dendrite_p GP_dendrite_d700_dia1
    end
	
	if (!({exists GP_dendrite_d700_dia0}))
             copy GP_dendrite_p GP_dendrite_d700_dia0
    end
	
	if (!({exists GP_dendrite_d800_dia2}))
             copy GP_dendrite_p GP_dendrite_d800_dia2
    end
	
	if (!({exists GP_dendrite_d800_dia1}))
             copy GP_dendrite_p GP_dendrite_d800_dia1
    end
	
	if (!({exists GP_dendrite_d800_dia0}))
             copy GP_dendrite_p GP_dendrite_d800_dia0
    end
	
	if (!({exists GP_dendrite_d900_dia2}))
             copy GP_dendrite_p GP_dendrite_d900_dia2
    end
	
	if (!({exists GP_dendrite_d900_dia1}))
             copy GP_dendrite_p GP_dendrite_d900_dia1
    end
	
	if (!({exists GP_dendrite_d900_dia0}))
             copy GP_dendrite_p GP_dendrite_d900_dia0
    end

/*	
    setfield GP_dendrite_d0_dia1/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*1.5}
  
	setfield GP_dendrite_d0_dia0/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*3}

    setfield GP_dendrite_d25_dia1/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*1.5}
    
	setfield GP_dendrite_d25_dia0/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*3}

    setfield GP_dendrite_d50_dia1/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*1.5}
    
	setfield GP_dendrite_d50_dia0/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*3}

    setfield GP_dendrite_d100_dia1/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*1.5}
    
	setfield GP_dendrite_d100_dia0/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*3}

    setfield GP_dendrite_d200_dia1/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*1.5}
    
	setfield GP_dendrite_d200_dia0/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*3}

    setfield GP_dendrite_d300_dia1/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*1.5}
    
	setfield GP_dendrite_d300_dia0/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*3}

    setfield GP_dendrite_d400_dia1/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*1.5}
    
	setfield GP_dendrite_d400_dia0/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*3}

    setfield GP_dendrite_d500_dia1/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*1.5}
    
	setfield GP_dendrite_d500_dia0/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*3}
    
	setfield GP_dendrite_d600_dia1/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*1.5}
    
	setfield GP_dendrite_d600_dia0/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*3}

	setfield GP_dendrite_d700_dia1/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*1.5}
    
	setfield GP_dendrite_d700_dia0/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*3}

	setfield GP_dendrite_d800_dia1/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*1.5}
    
	setfield GP_dendrite_d800_dia0/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*3}

	setfield GP_dendrite_d900_dia1/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*1.5}
    
	setfield GP_dendrite_d900_dia0/Ca_HVA_GP Gbar	\
		{{G_Ca_HVA_GP}*surf*{G_mult_Ca_dend}*{G_mult}*3}
*/

end

