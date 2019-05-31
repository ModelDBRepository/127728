*absolute
*asymmetric
*cartesian

*origin 0       0       0

*set_global EREST_ACT   {EREST_ACT}

*set_compt_param RM	{RM_sd}
*set_compt_param RA	{RA_sd}
*set_compt_param CM	{CM_sd}
*set_compt_param ELEAK	{ELEAK_sd}

*compt /library/GP_soma
soma            none            0       0       0      13.4

*compt /library/GP_ax
axon 	soma 	-40 0 0 2.25

*set_compt_param RM       	{RM_prox}
*set_compt_param RA		{RA_prox}
*set_compt_param CM       	{CM_prox}
*set_compt_param ELEAK		{ELEAK_sd}

*compt /library/GP_dendrite_d0_dia2
p0b1	 	soma  345.9  0  0  1.701
p1  		soma  320.8  0  0  1.531
p2b2  		soma  574.6  0  0  2.223
