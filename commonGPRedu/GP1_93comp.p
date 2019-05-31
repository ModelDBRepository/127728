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
p0b1  			soma      	16.1  0  0  1.429
p0b1b1			p0b1		59.95  0  0  1.25
p0b1b1[1]		p0b1b1		103.8  0  0  1.25
p0b1b1b1		p0b1b1[1]	125.8  0  0  1.364
p0b1b1b2		p0b1b1[1]	138.58  0  0  0.991
p0b1b1b2[1]		p0b1b1b2	173.35  0  0  0.991
p0b1b1b2[2]		p0b1b1b2[1]	208.13  0  0  0.991
p0b1b1b2[3]		p0b1b1b2[2]	242.9  0  0  0.991
p0b1b1b2b1		p0b1b1b2[3]	272.5  0  0  0.966
p0b1b1b2b1[1]		p0b1b1b2b1	302.1  0  0  0.966
p0b1b1b2b1b1		p0b1b1b2b1[1]	316  0  0  1.256
p0b1b1b2b1b1b1		p0b1b1b2b1b1	322  0  0  1.172
p0b1b1b2b1b1b2		p0b1b1b2b1b1	325.7  0  0  0.913
p0b1b1b2b1b2		p0b1b1b2b1[1]	329.8  0  0  0.859
p0b1b1b2b2		p0b1b1b2[3]	267.85  0  0  0.753
p0b1b1b2b2[1]		p0b1b1b2b2	292.8  0  0  0.753
p0b1b2			p0b1		48.5  0  0  0.700
p0b1b2[1]		p0b1b2		80.9 0 0 0.700
p0b1b2[2]		p0b1b2[1]	113.3 0 0 0.700
p0b1b2[3]		p0b1b2[2]	145.7 0 0 0.700
p0b1b2[4]		p0b1b2[3]	178.1 0 0 0.700
p0b1b2[5]		p0b1b2[4]	210.5 0 0 0.700

p1			soma		41.5  0  0  1.430
p1[1]			p1		83 0  0  1.430
p1[2]			p1[1]		124.5 0  0  1.430
p1[3]			p1[2]		166 0  0  1.430
p1b1			p1[3]		191.4  0  0  1.268
p1b1b1			p1b1		195.2  0  0  1.048
p1b1b2			p1b1		234.2  0  0  1.228
p1b1b2[1]		p1b1b2		277  0  0  1.228
p1b1b2b1		p1b1b2[1]	290.8  0  0  0.697
p1b1b2b2		p1b1b2[1]	293.8  0  0  0.660
p1b2			p1[3]		198.95  0  0  0.622
p1b2[1]			p1b2		231.9  0  0  0.622
p1b2b1			p1b2[1]		262.7  0  0  0.498
p1b2b1b1		p1b2b1		271.5  0  0  0.465
p1b2b1b2		p1b2b1		277.5  0  0  0.472
p1b2b2			p1b2[1]		243.98  0  0  0.428
p1b2b2[1]		p1b2b2		289  0  0  0.428

p2b2			soma		61.1  0  0  2.078
p2b2b1			p2b2		84.2  0  0  1.519
p2b2b1b1		p2b2b1		113.3  0  0  0.481
p2b2b1b1[1]		p2b2b1b1	142.3 0 0  0.481
p2b2b1b1[2]		p2b2b1b1[1]	171.4 0 0  0.481
p2b2b1b1[3]		p2b2b1b1[2]	200.4 0 0  0.481
p2b2b1b1[4]		p2b2b1b1[3]	229.5 0 0  0.481
p2b2b1b1[5]		p2b2b1b1[4]	258.5 0 0  0.481
p2b2b1b1[6]		p2b2b1b1[5]	287.6 0 0  0.481
p2b2b1b2		p2b2b1		119  0  0  1.490
p2b2b1b2[1]		p2b2b1b2	153.8  0  0  1.490
p2b2b1b2b1		p2b2b1b2[1]	187.15  0  0  0.533
p2b2b1b2b1[1]		p2b2b1b2b1	220.5  0  0  0.533
p2b2b1b2b1[2]		p2b2b1b2b1[1]	253.85  0  0  0.533
p2b2b1b2b1[3]		p2b2b1b2b1[2]	287.2  0  0  0.533
p2b2b1b2b1[4]		p2b2b1b2b1[3]	320.55  0  0  0.533
p2b2b1b2b1[5]		p2b2b1b2b1[4]   353.9  0  0  0.533
p2b2b1b2b1[6]		p2b2b1b2b1[5]	387.25  0  0  0.533
p2b2b1b2b1[7]		p2b2b1b2b1[6]	420.6  0  0  0.533
p2b2b1b2b1[8]		p2b2b1b2b1[7]	453.95  0  0  0.533
p2b2b1b2b1[9]		p2b2b1b2b1[8]	487.3  0  0  0.533
p2b2b1b2b1[10]		p2b2b1b2b1[9]	520.65  0  0  0.533
p2b2b1b2b1[11]		p2b2b1b2b1[10]	554  0  0  0.533
p2b2b1b2b2		p2b2b1b2[1]	161.5  0  0  1.651
p2b2b1b2b2b1		p2b2b1b2b2	190.8  0  0  0.443
p2b2b1b2b2b1[1]		p2b2b1b2b2b1	220.1  0  0  0.443
p2b2b1b2b2b1[2]		p2b2b1b2b2b1[1]	249.4  0  0  0.443
p2b2b1b2b2b1[3]		p2b2b1b2b2b1[2]	278.7  0  0  0.443
p2b2b1b2b2b1[4]		p2b2b1b2b2b1[3]	308  0  0  0.443
p2b2b1b2b2b2		p2b2b1b2b2	201.95  0  0  1.036
p2b2b1b2b2b2[1]		p2b2b1b2b2b2	242.4  0  0  1.036
p2b2b1b2b2b2b1		p2b2b1b2b2b2[1]	261.9  0  0  0.572
p2b2b1b2b2b2b1[1]	p2b2b1b2b2b2b1	281.3  0  0  0.572
p2b2b1b2b2b2b2		p2b2b1b2b2b2[1]	266.1  0  0  0.790
p2b2b1b2b2b2b2[1]	p2b2b1b2b2b2b2	289.8  0  0  0.790
p2b2b1b2b2b2b2b1	p2b2b1b2b2b2b2[1]	316.5  0  0  0.730
p2b2b1b2b2b2b2b2	p2b2b1b2b2b2b2[1]	307  0  0  0.795
p2b2b2			p2b2		102.5  0  0  1.070
p2b2b2[1]		p2b2b2		143.9  0  0  1.070
p2b2b2[2]		p2b2b2[1]	185.3  0  0  1.070
p2b2b2[3]		p2b2b2[2]	226.7  0  0  1.070
p2b2b2[4]		p2b2b2[3]	268.1  0  0  1.070
p2b2b2[5]		p2b2b2[4]	309.5  0  0  1.070
p2b2b2[6]		p2b2b2[5]	350.9  0  0  1.070
p2b2b2b1		p2b2b2[6]	376.9  0  0  0.765
p2b2b2b1[1]		p2b2b2b1	402.8  0  0  0.765
p2b2b2b1b1		p2b2b2b1[1]	412.8  0  0  0.436
p2b2b2b1b2		p2b2b2b1[1]	434.8  0  0  0.776
p2b2b2b2		p2b2b2[6]	379.1  0  0  0.596
p2b2b2b2[1]		p2b2b2b2	407.3  0  0  0.596
p2b2b2b2[2]		p2b2b2b2[1]	435.5  0  0  0.596
p2b2b2b2[3]		p2b2b2b2[2]	463.7  0  0  0.596
