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
soma            none            0       0       0      30
