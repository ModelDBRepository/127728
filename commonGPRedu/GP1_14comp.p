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
p0b1	soma	86.5	0	0	1.701
p0b1[1]	p0b1	173	0	0	1.701
p0b1[2]	p0b1[1]	259.5	0	0	1.701
p0b1[3]	p0b1[2]	346	0	0	1.701
					
p1	soma	80.2	0	0	1.531
p1[1]	p1	160.4	0	0	1.531
p1[2]	p1[1]	240.6	0	0	1.531
p1[3]	p1[2]	320.8	0	0	1.531
					
p2b2	soma	143.65	0	0	2.223
p2b2[1]	p2b2	287.3	0	0	2.223
p2b2[2]	p2b2[1]	430.95	0	0	2.223
p2b2[3]	p2b2[2]	574.6	0	0	2.223
