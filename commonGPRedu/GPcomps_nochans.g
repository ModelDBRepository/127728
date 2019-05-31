//FILE IN USE 09/30/2004 -- present.

//genesis - genesis2.2 script, J Hanson 5/02
//axon rebuilt with hillock, initial segment, nodes and internodal
//	segments 06/25/2004 according to Shen et al (1999).
// 06/28/2004: added KCNQ to axon, added G_mult_KCNQ_dend and G_mult_KCNQ_axon
// 09/30/2004: changed dendritic subclassifications to match the data of
//		Hanson & Smith, 2004.

float PI = 3.14159

function make_GP_comps
	float len, dia, surf, rad, vol, core_vol, shell_vol
	float rad_core, shell_vol
	int i

// make spherical soma prototype
	len = 0 
	dia = 1 
	rad = {dia}/2
	rad_core = rad - {shell_thick} 
	surf = 4*{PI}*rad*rad
	vol = 4/3*{PI}*rad*rad*rad
	core_vol = 4/3*{PI}*rad_core*rad_core*rad_core
	shell_vol = vol - core_vol
	if (!({exists GP_soma}))
		create compartment GP_soma
	end
	setfield GP_soma Cm {{CM_sd}*surf} Ra {8.0*{RA_sd}/({dia}*{PI})}  \
		Em {ELEAK_sd} initVm {EREST_ACT} Rm {{RM_sd}/surf} inject 0.0  \
		dia {dia} len {len}

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

// dendritic prototype = GP_dendrite_d0_dia2
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
	if (!({exists GP_dendrite_d0_dia2}))
	    create compartment GP_dendrite_d0_dia2
	end
	setfield GP_dendrite_d0_dia2 Cm {{CM_prox}*surf} Ra {4.0*{RA_prox}*{len}/({dia}*{dia}*{PI})}  \
        	Em {ELEAK_sd} initVm {EREST_ACT} Rm {{RM_prox}/surf} inject 0.0  \
        	dia {dia} len {len}

// Distal dendritic prototype = dendrite_p
/*	len = 1 
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
	if (!({exists GP_dendrite_dist}))
	    create compartment GP_dendrite_dist
	end
	setfield GP_dendrite_dist Cm {{CM_dist}*surf} Ra {4.0*{RA_dist}*{len}/({dia}*{dia}*{PI})}  \
        	Em {ELEAK_sd} initVm {EREST_ACT} Rm {{RM_dist}/surf} inject 0.0  \
        	dia {dia} len {len}
*/
end

