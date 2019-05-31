// FILE IN USE 05/17/2005 -- present.
// Changes to previous version of 01/05:
//	1. HCN channels rebuilt based on Chan et al (2004), J Neurosci 24: 9921-32.	

//genesis
float  xmin = -0.2
float  xmax = 0.1
int    xdivs = 299 
float  dx = (xmax - xmin)/xdivs

int xdivs_interp = 6000
float  dx_interp = (xmax - xmin)/xdivs_interp

float  x
int i

//==================================================================
// 	Tab channel descriptions for GP neuron modeling
// 	Created by J. Hanson
//	edited 10-02
//	Updated by J. Edgerton, 9/2003 --
//==================================================================



//==================================================================
//                      Fast Na channel
//	Activation and fast inactivation made to replicate resurgent
//		sodium current from Raman & Bean.
//	Slow inactivation gate added by J. Edgerton, 2004.
//	Support for voltage-dependent Z-gate by Cengiz Gunay, 2004
//==================================================================
function make_Na_fast_GP_Zgate
        if ({exists Na_fast_GP})
                return
        end
        create  tabchannel Na_fast_GP
	float mpower = 3
        setfield Na_fast_GP Ek {ENa} Gbar {G_NaF_soma} Ik 0 Gk 0\
                Xpower {mpower} Ypower 1 Zpower 1
		
//	Activation & Deactivation
	float Vhalfm 	= {Vhalfm_NaF}
	float Km 	= {Km_NaF}
	float taummax 	= {taummax_NaF}	// 0.000028	//0.00010   
        float taummin 	= {taummin_NaF}	//  0.00000157	//0.00002
	float Ktau1   =	 0.02
	float Ktau2   =  0.02
	float V0m, minf, taum
	V0m = {Vhalfm} + ({Km} * {log {(1 / {pow 0.5 {1/{mpower}}}) - 1}})
	echo "Na_fast V0m: " {V0m}
        call Na_fast_GP TABCREATE X {xdivs} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs}; i = i + 1)
                minf = 1 / (1 + {exp {({V0m} - x) / {Km} }})
		taum = {taummin} + (({taummax} - {taummin}) / ({exp { (x - {V0m}) / {Ktau1} } } + {exp {({V0m} - x) / {Ktau2} }}))
                setfield Na_fast_GP X_A->table[{i}] {taum}
                setfield Na_fast_GP X_B->table[{i}] {minf}
                x = x + dx
        end
        tweaktau Na_fast_GP X
	call Na_fast_GP TABFILL X {xdivs_interp} 0
	setfield Na_fast_GP X_A->calc_mode {NO_INTERP}
	setfield Na_fast_GP X_B->calc_mode {NO_INTERP}

//	Fast Inactivation
	float V0h	= {V0h_NaF}
	float tauhV0	= {tauhV0_NaF}
	float Kh      =	{Kh_NaF}	// 	-0.003848
	float tauhmax =  {tauhmax_NaF}	//	0.004 
        float tauhmin =  {tauhmin_NaF}	//	0.0002
	float Ktau1h   =  0.005
	float Ktau2h   =  0.01
	float hinf, tauh
        call Na_fast_GP TABCREATE Y {xdivs} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs}; i = i + 1)
                hinf = 1 / (1 + {exp {({V0h} - x) / {Kh} }})
		tauh = {tauhmin} + (({tauhmax} - {tauhmin}) / ({exp { (x - {tauhV0}) / {Ktau1h} } } + {exp {({tauhV0} - x) / {Ktau2h} }}))
                setfield Na_fast_GP Y_A->table[{i}] {tauh}
                setfield Na_fast_GP Y_B->table[{i}] {hinf}
                x = x + dx
        end
        tweaktau Na_fast_GP Y
        call Na_fast_GP TABFILL Y {xdivs_interp} 0
	setfield Na_fast_GP Y_A->calc_mode {NO_INTERP}
	setfield Na_fast_GP Y_B->calc_mode {NO_INTERP}


//	Slow Inactivation
//	Equations & params from Spampanato et al, 2003, except that
//		tausmin added to prevent segmentation faults due to
//		excessively small time constants at voltage extremes.
	float V0s	= {V0s_NaF}
	float tausV0	= {V0s_NaF}
	float Ks      	= {Ks_NaF}
	float mins	= {mins_NaF}
	float Ktaus1   	= {Ktaus1_NaF}
	float Ktaus2	= {Ktaus2_NaF}
	float tausmax	= {tausmax_NaF}
	float tausmin	= {tausmin_NaF}
	float sinf, taus
	
        call Na_fast_GP TABCREATE Z {xdivs} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs}; i = i + 1)
		sinf = {mins} + ((1-{mins}) / (1 + {exp {({V0s} - x) / {Ks} }}))
		taus = tausmin + ({tausmax} - {tausmin}) / ({exp {({tausV0} - x) / {Ktaus1}}} + {exp {(x - {tausV0}) / {Ktaus2}}}) 

		setfield Na_fast_GP Z_A->table[{i}] {taus}
                setfield Na_fast_GP Z_B->table[{i}] {sinf}
                x = x + dx
        end
        tweaktau Na_fast_GP Z
        call Na_fast_GP TABFILL Z {xdivs_interp} 0
	setfield Na_fast_GP Z_A->calc_mode {NO_INTERP}
	setfield Na_fast_GP Z_B->calc_mode {NO_INTERP}
	setfield Na_fast_GP Z_conc 0  // Z-gate voltage-dependent
end

//==================================================================
//                      Fast Na channel
//	Activation and fast inactivation made to replicate resurgent
//		sodium current from Raman & Bean.
//	Slow inactivation gate added by J. Edgerton, 2004.
//	Support for voltage-dependent Z-gate by Cengiz Gunay, 2004
// 	Populates all table entries from the original equation,
//	rather than using TABFILL (for testing purposes).
//==================================================================
function make_Na_fast_GP_Zgate_nofill
        if ({exists Na_fast_GP})
                return
        end
        create  tabchannel Na_fast_GP
	float mpower = 3
        setfield Na_fast_GP Ek {ENa} Gbar {G_NaF_soma} Ik 0 Gk 0\
                Xpower {mpower} Ypower 1 Zpower 1
		
//	Activation & Deactivation
	float Vhalfm 	= {Vhalfm_NaF}
	float Km 	= {Km_NaF}
	float taummax 	= {taummax_NaF}	// 0.000028	//0.00010   
        float taummin 	= {taummin_NaF}	//  0.00000157	//0.00002
	float Ktau1   =	 0.02
	float Ktau2   =  0.02
	float V0m, minf, taum
	V0m = {Vhalfm} + ({Km} * {log {(1 / {pow 0.5 {1/{mpower}}}) - 1}})
	echo "Na_fast V0m: " {V0m}
        call Na_fast_GP TABCREATE X {xdivs_interp} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs_interp}; i = i + 1)
                minf = 1 / (1 + {exp {({V0m} - x) / {Km} }})
		taum = {taummin} + (({taummax} - {taummin}) / ({exp { (x - {V0m}) / {Ktau1} } } + {exp {({V0m} - x) / {Ktau2} }}))
                setfield Na_fast_GP X_A->table[{i}] {taum}
                setfield Na_fast_GP X_B->table[{i}] {minf}
                x = x + dx_interp
        end
        tweaktau Na_fast_GP X
		//call Na_fast_GP TABFILL X {xdivs_interp} 0
	setfield Na_fast_GP X_A->calc_mode {NO_INTERP}
	setfield Na_fast_GP X_B->calc_mode {NO_INTERP}

//	Fast Inactivation
	float V0h	= {V0h_NaF}
	float tauhV0	= {tauhV0_NaF}
	float Kh      =	{Kh_NaF}	// 	-0.003848
	float tauhmax =  {tauhmax_NaF}	//	0.004 
        float tauhmin =  {tauhmin_NaF}	//	0.0002
	float Ktau1h   =  0.005
	float Ktau2h   =  0.01
	float hinf, tauh
        call Na_fast_GP TABCREATE Y {xdivs_interp} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs_interp}; i = i + 1)
                hinf = 1 / (1 + {exp {({V0h} - x) / {Kh} }})
		tauh = {tauhmin} + (({tauhmax} - {tauhmin}) / ({exp { (x - {tauhV0}) / {Ktau1h} } } + {exp {({tauhV0} - x) / {Ktau2h} }}))
                setfield Na_fast_GP Y_A->table[{i}] {tauh}
                setfield Na_fast_GP Y_B->table[{i}] {hinf}
                x = x + dx_interp
        end
        tweaktau Na_fast_GP Y
		//call Na_fast_GP TABFILL Y {xdivs_interp} 0
	setfield Na_fast_GP Y_A->calc_mode {NO_INTERP}
	setfield Na_fast_GP Y_B->calc_mode {NO_INTERP}

//	Slow Inactivation
//	Equations & params from Spampanato et al, 2003, except that
//		tausmin added to prevent segmentation faults due to
//		excessively small time constants at voltage extremes.
	float V0s	= {V0s_NaF}
	float tausV0	= {V0s_NaF}
	float Ks      	= {Ks_NaF}
	float mins	= {mins_NaF}
	float Ktaus1   	= {Ktaus1_NaF}
	float Ktaus2	= {Ktaus2_NaF}
	float tausmax	= {tausmax_NaF}
	float tausmin	= {tausmin_NaF}
	float sinf, taus
	
        call Na_fast_GP TABCREATE Z {xdivs_interp} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs_interp}; i = i + 1)
		sinf = {mins} + ((1-{mins}) / (1 + {exp {({V0s} - x) / {Ks} }}))
		taus = tausmin + ({tausmax} - {tausmin}) / ({exp {({tausV0} - x) / {Ktaus1}}} + {exp {(x - {tausV0}) / {Ktaus2}}}) 

		setfield Na_fast_GP Z_A->table[{i}] {taus}
                setfield Na_fast_GP Z_B->table[{i}] {sinf}
                x = x + dx_interp
        end
        tweaktau Na_fast_GP Z
		//call Na_fast_GP TABFILL Z {xdivs_interp} 0
	setfield Na_fast_GP Z_A->calc_mode {NO_INTERP}
	setfield Na_fast_GP Z_B->calc_mode {NO_INTERP}
	setfield Na_fast_GP Z_conc 0  // Z-gate voltage-dependent
end

//==================================================================
//                      Fast Na channel
//	Activation and fast inactivation made to replicate resurgent
//		sodium current from Raman & Bean.
//	Slow inactivation gate added by J. Edgerton, 2004.
//	Adapted to use the tab2Dchannel instead of Z-gate by C. Gunay, Jan 2006.
//==================================================================
function make_Na_fast_GP_tab2D
        if ({exists Na_fast_GP})
                return
        end
        create  tab2Dchannel Na_fast_GP
	float mpower = 3
        setfield Na_fast_GP Ek {ENa} Gbar {G_NaF_soma} Ik 0 Gk 0\
                Xpower {mpower} Ypower 1 Zpower 1
		
//	Activation & Deactivation
	float Vhalfm 	= {Vhalfm_NaF}
	float Km 	= {Km_NaF}
	float taummax 	= {taummax_NaF}	// 0.000028	//0.00010   
        float taummin 	= {taummin_NaF}	//  0.00000157	//0.00002
	float Ktau1   =	 0.02
	float Ktau2   =  0.02
	float V0m, minf, taum
	V0m = {Vhalfm} + ({Km} * {log {(1 / {pow 0.5 {1/{mpower}}}) - 1}})
	echo "Na_fast V0m: " {V0m}
	// Special use of 2D table as a 1D table
        call Na_fast_GP TABCREATE X 0 0 0 {xdivs_interp} {xmin} {xmax} 
        x = xmin
        for (i = 0; i <= {xdivs_interp}; i = i + 1)
                minf = 1 / (1 + {exp {({V0m} - x) / {Km} }})
		taum = {taummin} + (({taummax} - {taummin}) / ({exp { (x - {V0m}) / {Ktau1} } } + {exp {({V0m} - x) / {Ktau2} }}))
	        // tweaktau doesn't apply to tab2D, we fill tables directly with A & B
     		setfield Na_fast_GP X_A->table[0][{i}] {({minf} / {taum})}
 		setfield Na_fast_GP X_B->table[0][{i}] {(1 / {taum})}
                x = x + dx_interp
        end
		/*setfield Na_fast_GP X_A->calc_mode {NO_INTERP}
		  setfield Na_fast_GP X_B->calc_mode {NO_INTERP}*/
	// Voltage dependent gate
	setfield Na_fast_GP Xindex VOLT_INDEX

//	Fast Inactivation
	float V0h	= {V0h_NaF}
	float tauhV0	= {tauhV0_NaF}
	float Kh      =	{Kh_NaF}	// 	-0.003848
	float tauhmax =  {tauhmax_NaF}	//	0.004 
        float tauhmin =  {tauhmin_NaF}	//	0.0002
	float Ktau1h   =  0.005
	float Ktau2h   =  0.01
	float hinf, tauh
        call Na_fast_GP TABCREATE Y  0 0 0 {xdivs_interp} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs_interp}; i = i + 1)
                hinf = 1 / (1 + {exp {({V0h} - x) / {Kh} }})
		tauh = {tauhmin} + (({tauhmax} - {tauhmin}) / ({exp { (x - {tauhV0}) / {Ktau1h} } } + {exp {({tauhV0} - x) / {Ktau2h} }}))
     		setfield Na_fast_GP Y_A->table[0][{i}] {({hinf} / {tauh})}
		setfield Na_fast_GP Y_B->table[0][{i}] {(1 / {tauh})}
                x = x + dx_interp
        end
		/*setfield Na_fast_GP Y_A->calc_mode {NO_INTERP}
		  setfield Na_fast_GP Y_B->calc_mode {NO_INTERP}*/
	setfield Na_fast_GP Yindex VOLT_INDEX

//	Slow Inactivation
//	Equations & params from Spampanato et al, 2003, except that
//		tausmin added to prevent segmentation faults due to
//		excessively small time constants at voltage extremes.
	float V0s	= {V0s_NaF}
	float tausV0	= {V0s_NaF}
	float Ks      	= {Ks_NaF}
	float mins	= {mins_NaF}
	float Ktaus1   	= {Ktaus1_NaF}
	float Ktaus2	= {Ktaus2_NaF}
	float tausmax	= {tausmax_NaF}
	float tausmin	= {tausmin_NaF}
	float sinf, taus
	
        call Na_fast_GP TABCREATE Z  0 0 0  {xdivs_interp} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs_interp}; i = i + 1)
		sinf = {mins} + ((1-{mins}) / (1 + {exp {({V0s} - x) / {Ks} }}))
		taus = tausmin + ({tausmax} - {tausmin}) / ({exp {({tausV0} - x) / {Ktaus1}}} + {exp {(x - {tausV0}) / {Ktaus2}}}) 

     		setfield Na_fast_GP Z_A->table[0][{i}] {({sinf} / {taus})}
		setfield Na_fast_GP Z_B->table[0][{i}] {(1 / {taus})}
                x = x + dx_interp
        end
		/*setfield Na_fast_GP Z_A->calc_mode {NO_INTERP}
		  setfield Na_fast_GP Z_B->calc_mode {NO_INTERP}*/
	// Z-gate voltage-dependent
	setfield Na_fast_GP Zindex VOLT_INDEX
end

//==================================================================
//                      persistent Na channel
//	Based on Magistretti & Alonso (1999), JGP 114:491-509
//		and Magistretti & Alonso (2002), JGP 120: 855-873.
//	Created by J.R. Edgerton, 03/2004
//	Modified 10/2004 by JRE: add z-gate slow inactivation, improve 
//		model's y-gate intermediate inactivation.
//==================================================================
function make_Na_slow_GP
    if ({exists Na_slow_GP})
                return
    end
	create  tabchannel Na_slow_GP
	float mpower = 3
    setfield Na_slow_GP Ek {ENa} Gbar {G_NaP_soma} Ik 0 Gk 0 \
	Xpower {mpower} Ypower 1 Zpower 1
	
	float q10 = 3	// = Q10^((32-22)/10) with Q10 = 3.
	
//	***	Activation & Deactivation (m-gate)
    float Km    = 0.0057	// with mpower = 3, this makes actual K = 0.0045.
    float Vhalfm   = {Vhalfm_NaP}	// -0.053 according to Magistretti & Alonso
	float Ktaum =	0.0144	
	float V0taum =	-0.0416
	float alp0	=	2130	// 0.00213
	float bet0 = 	2460

	float V0m = {Vhalfm} + ({Km} * {log {(1 / {pow 0.5 {1/{mpower}}}) - 1}})
	echo "Na_slow V0m: " {V0m}

	float alpham, betam, taum, minf
        call Na_slow_GP TABCREATE X {xdivs} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs}; i = i + 1)
		
			alpham = alp0 * {exp {(x - {V0taum}) / {Ktaum}}} * {q10}
			betam = bet0 * {exp {({V0taum} - x) / {Ktaum}}} * {q10}
			
            minf = 1 / (1 + {exp {({V0m} - x) / {Km} }})
			taum = 1 / ({alpham} + {betam})
			
            setfield Na_slow_GP X_A->table[{i}] {taum}
            setfield Na_slow_GP X_B->table[{i}] {minf}
            x = x + dx
        end
	
        tweaktau Na_slow_GP X
	call Na_slow_GP TABFILL X {xdivs_interp} 0
	setfield Na_slow_GP X_A->calc_mode {NO_INTERP}
	setfield Na_slow_GP X_B->calc_mode {NO_INTERP}

//	***	Fast / Intermediate Inactivation (h-gate)
	float hmin	= {hmin_NaP}	// 0.154
	float V0h   	= {V0h_NaP}	// -0.057	
    	float Kh   	= {Kh_NaP}	// -0.004
	float V0tauh = -0.034		
	float Ktauh1 = -0.026
	float Ktauh2 = -0.0319
	float tauhmin = 0.030
	float tauhmax = 0.051

	float tauh, hinf
        call Na_slow_GP TABCREATE Y {xdivs} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs}; i = i + 1)
		
            hinf = {hmin} + ((1 - {hmin}) / (1 + {exp {({V0h} - x) / {Kh} }}))
			tauh = ({tauhmin} + (({tauhmax} - {tauhmin}) / ({exp {(x - {V0tauh}) / {Ktauh1}}} + {exp {({V0tauh} - x) / {Ktauh2}}}))) / {q10}
			
            setfield Na_slow_GP Y_A->table[{i}] {tauh}
            setfield Na_slow_GP Y_B->table[{i}] {hinf}
            x = x + dx
        end
	
        tweaktau Na_slow_GP Y
	call Na_slow_GP TABFILL Y {xdivs_interp} 0
	setfield Na_slow_GP Y_A->calc_mode {NO_INTERP}
	setfield Na_slow_GP Y_B->calc_mode {NO_INTERP}

//	*** Slow Inactivation (s-gate)	
    float Ks      =	-0.0049
    float V0s     =	{V0s_NaP}
	float Aalpha =	-2.88	//units of /volt/sec
	float Balpha =	-0.049	//units of /sec
	float Kalpha =	0.00463	//units of volt
	float Abeta =	{Abeta_NaP}	//6.94	//units of /volt/sec
	float Bbeta =	{Bbeta_NaP}	// 0.447	//units of /sec
	float Kbeta =	-0.00263	//units of volt

	float alphas, betas, taus, sinf
        call Na_slow_GP TABCREATE Z {xdivs} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs}; i = i + 1)
			alphas = {q10} * (({Aalpha} * x) + {Balpha}) / (1 - {exp {((x + ({Balpha} / {Aalpha})) / {Kalpha})}})
			betas = {q10} * (({Abeta} * x) + {Bbeta}) / (1 - {exp {((x + ({Bbeta} / {Abeta})) / {Kbeta})}})
		
			taus = 1 / ({alphas} + {betas})
        	sinf = 1 / (1 + {exp {({V0s} - x) / {Ks} }})
        	setfield Na_slow_GP Z_A->table[{i}] {taus}
            setfield Na_slow_GP Z_B->table[{i}] {sinf}
            x = x + dx
        end
        tweaktau Na_slow_GP Z
        call Na_slow_GP TABFILL Z {xdivs_interp} 0
	setfield Na_slow_GP Z_A->calc_mode {NO_INTERP}
	setfield Na_slow_GP Z_B->calc_mode {NO_INTERP}
	setfield Na_slow_GP Z_conc 0  // Z-gate voltage-dependent
end


//==================================================================
//         		Kdr Kv2 
//		(Kv2.1) slow activating
//              Created based on GP data:
//              Baranuskas, Tkatch and Surmeier
//              1999, J Neurosci 19(15):6394-6404
//==================================================================
function make_Kv2_GP
        if (({exists Kv2_GP}))
                return
        end
        create tabchannel Kv2_GP
	float npower = {npower_Kv2}	//4
        setfield Kv2_GP Ek {EK} Gbar {G_Kv2_soma} Ik 0 Gk 0\
                Xpower {npower} Ypower 1 Zpower 0
	float taunmax = {taunmax_Kv2}	// 0.03 
	float taunmin = {taunmin_Kv2}	// 0.0001	
    float Kn = {Kn_Kv2}
    float Vhalfn = {Vhalfn_Kv2}	// True Vhalf for channel activation
	float K1tau = -0.01391
	float K2tau = -0.02174
	float V0n, ninf, taun, alpha, beta
	V0n = {Vhalfn} + ({Kn} * {log {(1 / {pow 0.5 {1/{npower}}}) - 1}})
	echo "Kv2 V0n: " {V0n}
	//V0n is Vhalf for each individual n gate.
	call Kv2_GP TABCREATE X {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		ninf = 1 / (1 + {exp { ({V0n} - x) / {Kn} } } )
		taun = {taunmin} + (({taunmax} - {taunmin}) / ({exp { ({V0n} - x) / {K1tau} } } + {exp {-({V0n} - x) / {K2tau} }}))
		setfield Kv2_GP X_A->table[{i}] {taun}
		setfield Kv2_GP X_B->table[{i}] {ninf}
/* Manual table contruction bypassing tweaktau:
		alpha = {ninf} / {taun}
		beta = {(1 / {taun}) - {alpha}}
		setfield Kv2_GP X_A->table[{i}] {alpha}
		setfield Kv2_GP X_B->table[{i}] {1 / {taun}}
*/
		x = x + dx
	end
	tweaktau Kv2_GP X
	call Kv2_GP TABFILL X {xdivs_interp} 0
	setfield Kv2_GP X_A->calc_mode {NO_INTERP}
	setfield Kv2_GP X_B->calc_mode {NO_INTERP}
        
	float Kh    =  	0.010
        float V0h   = 	-0.02
	float hmin  =	{hmin_Kv2}	// 0.2	
	float tauhmax = 3.4   
        float tauhmin =	3.4
	float tauhK   =	0.010
	float tauhV0  =	0 //-0.070 
	float hinf, tauh
        call Kv2_GP TABCREATE Y {xdivs} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs}; i = i + 1)
                hinf = {hmin} + ((1 - {hmin}) / (1 + {exp {(x - {V0h}) / {Kh} }}))
		tauh = {{tauhmax}-{tauhmin}} / (1 + {exp {(x - {tauhV0}) / {tauhK} }})  + {tauhmin} 
                setfield Kv2_GP Y_A->table[{i}] {tauh}
                setfield Kv2_GP Y_B->table[{i}] {hinf}
                x = x + dx
        end
        tweaktau Kv2_GP Y
	call Kv2_GP TABFILL Y {xdivs_interp} 0
	setfield Kv2_GP Y_A->calc_mode {NO_INTERP}
	setfield Kv2_GP Y_B->calc_mode {NO_INTERP}
end



//==================================================================
//         		Kdr Kv3
//		(Kv3.1/3.4 heteromultimers) fast activating,
//			incompletely inactivating.
//		From Surmeier's kv3sur.mod NEURON mechanism
//			written by Josh Held
//		Adapted to genesis by J.R. Edgerton, 2003
//		Modified to reflect new data in
//		Baranauskas et al (2003) by J.R. Edgerton, 2004.
//              Baranauskas, Tkatch and Surmeier
//              	1999, J Neurosci 19(15):6394-6404
//		Baranauskas, Tkatch, Nagata, Yeh & Surmeier 2003.
//			Nat Neurosci 6: 258-66.
//==================================================================
function make_Kv3_GP
        if (({exists Kv3_GP}))
                return
        end
        create tabchannel Kv3_GP
	float npower = {npower_Kv3}	// 4
        setfield Kv3_GP Ek {EK} Gbar {G_Kv3_soma} Ik 0 Gk 0\
                Xpower {npower} Ypower 1 Zpower 0
        float Kn = {Kn_Kv3}	// individual n-gate K	
        float Vhalfn = {Vhalfn_Kv3}	// True Vhalf for channel activation.
	float taunmax = 0.014	// actual peak of tauV curve is about 7 ms.
	float taunmin = 0.0001	// = true min tau
	float K1tau = -0.012
	float K2tau = -0.013	// changed from -0.021 02/16/2005
	float V0n, ninf, taun, alpha, beta
	V0n = {Vhalfn} + ({Kn} * {log {(1 / {pow 0.5 {1/{npower}}}) - 1}})
	echo "Kv3 V0n: " {V0n}
	//V0n is Vhalf for each individual n gate.
	
	call Kv3_GP TABCREATE X {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		ninf = 1 / (1 + {exp { ({V0n} - x) / {Kn} } } )
		taun = {taunmin} + (({taunmax} - {taunmin}) / ({exp { ({V0n} - x) / {K1tau} } } + {exp {-({V0n} - x) / {K2tau} }}))
		setfield Kv3_GP X_A->table[{i}] {taun}
		setfield Kv3_GP X_B->table[{i}] {ninf}
/* Manual table contruction bypassing tweaktau:
		alpha = {ninf} / {taun}
		beta = {(1 / {taun}) - {alpha}}
		setfield Kv3_GP X_A->table[{i}] {alpha}
		setfield Kv3_GP X_B->table[{i}] {1 / {taun}}
*/
		x = x + dx
	end
	tweaktau Kv3_GP X
	call Kv3_GP TABFILL X {xdivs_interp} 0
	setfield Kv3_GP X_A->calc_mode {NO_INTERP}
	setfield Kv3_GP X_B->calc_mode {NO_INTERP}
		
        float Kh    =  	0.010
        float V0h   = 	-0.02
	float hmin  =	{hmin_Kv3}	//	0.6	
	float tauhmax = 0.033   
        float tauhmin =	0.007
	float tauhK   =	0.010
	float tauhV0  =	0 //-0.070 
	float hinf, tauh
        call Kv3_GP TABCREATE Y {xdivs} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs}; i = i + 1)
                hinf = {hmin} + ((1 - {hmin}) / (1 + {exp {(x - {V0h}) / {Kh} }}))
		tauh = {{tauhmax}-{tauhmin}} / (1 + {exp {(x - {tauhV0}) / {tauhK} }})  + {tauhmin} 
                setfield Kv3_GP Y_A->table[{i}] {tauh}
                setfield Kv3_GP Y_B->table[{i}] {hinf}
                x = x + dx
        end
        tweaktau Kv3_GP Y
	call Kv3_GP TABFILL Y {xdivs_interp} 0
	setfield Kv3_GP Y_A->calc_mode {NO_INTERP}
	setfield Kv3_GP Y_B->calc_mode {NO_INTERP}

end


//==================================================================
//                      KA Kv4 fast
//               Low voltage-activated
//              Created based on GP data:
//              Tkatch, Baranauskas and Surmeier
//              2000, J Neurosci 20(2):579-588
//		Modified by J. R. Edgerton 02/2004
//==================================================================
function make_Kv4_fast_GP
        if (({exists Kv4_fast_GP}))
                return
        end
        create tabchannel Kv4_fast_GP
	float npower = 4
        setfield Kv4_fast_GP Ek {EK} Gbar {G_Kv4f_soma} Ik 0 Gk 0\
                Xpower {npower} Ypower 1 Zpower 0
        float Kn    	= {Kn_Kv4}	//	0.029
        float V0n   	= {V0n_Kv4}	//	-0.053	
	float taunmax 	=  0.007   
        float taunmin 	=  0.00025
	float Ktaun1 	= {Ktaun1_Kv4}	//	0.029
	float Ktaun2 	= {Ktaun2_Kv4}	//	0.029
	float ninf, taun
//	V0n = {Vhalfn} + ({Kn} * {log {(1 / {pow 0.5 {1/{npower}}}) - 1}})
	echo "Kv4f V0n: " {V0n}
 //	V0n = -0.043	//corrected for mpower = 4.
 	call Kv4_fast_GP TABCREATE X {xdivs} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs}; i = i + 1)
                ninf = 1 / (1 + {exp {({V0n} - x) / {Kn} }})
		taun = taunmin + ({taunmax} - {taunmin}) / ({exp {({V0n} - x) / {Ktaun1}}} + {exp {(x - {V0n}) / {Ktaun2}}}) 
                setfield Kv4_fast_GP X_A->table[{i}] {taun}
                setfield Kv4_fast_GP X_B->table[{i}] {ninf}
                x = x + dx
        end
        tweaktau Kv4_fast_GP X
	call Kv4_fast_GP TABFILL X {xdivs_interp} 0
	setfield Kv4_fast_GP X_A->calc_mode {NO_INTERP}
	setfield Kv4_fast_GP X_B->calc_mode {NO_INTERP}

	
	float tauhmax 	= 0.021   
        float tauhmin 	= 0.007
        float Kh    	= {Kh_Kv4}	//-0.0047
        float V0h   	= {V0h_Kv4}	//-0.072
	float Ktauh1 	= {Ktauh1_Kv4}	//0.010
	float Ktauh2 	= {Ktauh2_Kv4}	//0.010
	float hinf, tauh
        call Kv4_fast_GP TABCREATE Y {xdivs} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs}; i = i + 1)
                hinf = 1 / (1 + {exp {({V0h} - x) / {Kh} }})
		tauh = tauhmin + ({tauhmax} - {tauhmin}) / ({exp {({V0h} - x) / {Ktauh1}}} + {exp {(x - {V0h}) / {Ktauh2}}}) 
                setfield Kv4_fast_GP Y_A->table[{i}] {tauh}
                setfield Kv4_fast_GP Y_B->table[{i}] {hinf}
                x = x + dx
        end
        tweaktau Kv4_fast_GP Y
	call Kv4_fast_GP TABFILL Y {xdivs_interp} 0
	setfield Kv4_fast_GP Y_A->calc_mode {NO_INTERP}
	setfield Kv4_fast_GP Y_B->calc_mode {NO_INTERP}

end


//==================================================================
//                      KA Kv4 slow
//               Low voltage-activated
//              Created based on GP data:
//              Tkatch, Baranauskas and Surmeier
//              2000, J Neurosci 20(2):579-588
//		Modified by J. R. Edgerton 02/2004
//==================================================================
function make_Kv4_slow_GP
        if (({exists Kv4_slow_GP}))
                return
        end
        create tabchannel Kv4_slow_GP
	float npower = 4
        setfield Kv4_slow_GP Ek {EK} Gbar {G_Kv4s_soma} Ik 0 Gk 0\
                Xpower {npower} Ypower 1 Zpower 0
        float Kn    	= {Kn_Kv4}	//	0.029
        float V0n   	= {V0n_Kv4}	//	-0.053	
	float taunmax 	=  0.007   
        float taunmin 	=  0.00025
	float Ktaun1 	= {Ktaun1_Kv4}	//	0.029
	float Ktaun2 	= {Ktaun2_Kv4}	//	0.029
	float ninf, taun
//	V0n = {Vhalfn} + ({Kn} * {log {(1 / {pow 0.5 {1/{npower}}}) - 1}})
	echo "Kv4s V0n: " {V0n}
 //	V0n = -0.043	//corrected for mpower = 4.
 	call Kv4_slow_GP TABCREATE X {xdivs} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs}; i = i + 1)
                ninf = 1 / (1 + {exp {({V0n} - x) / {Kn} }})
		taun = taunmin + ({taunmax} - {taunmin}) / ({exp {({V0n} - x) / {Ktaun1}}} + {exp {(x - {V0n}) / {Ktaun2}}}) 
                setfield Kv4_slow_GP X_A->table[{i}] {taun}
                setfield Kv4_slow_GP X_B->table[{i}] {ninf}
                x = x + dx
        end
        tweaktau Kv4_slow_GP X
	call Kv4_slow_GP TABFILL X {xdivs_interp} 0
	setfield Kv4_slow_GP X_A->calc_mode {NO_INTERP}
	setfield Kv4_slow_GP X_B->calc_mode {NO_INTERP}

	
	float tauhmax =  0.121   
        float tauhmin =  0.05
        float Kh    	= {Kh_Kv4}	//-0.0047
        float V0h   	= {V0h_Kv4}	//-0.072
	float Ktauh1 	= {Ktauh1_Kv4}	//0.010
	float Ktauh2 	= {Ktauh2_Kv4}	//0.010
	float hinf, tauh
        call Kv4_slow_GP TABCREATE Y {xdivs} {xmin} {xmax}
        x = xmin
        for (i = 0; i <= {xdivs}; i = i + 1)
                hinf = 1 / (1 + {exp {({V0h} - x) / {Kh} }})
		tauh = tauhmin + ({tauhmax} - {tauhmin}) / ({exp {({V0h} - x) / {Ktauh1}}} + {exp {(x - {V0h}) / {Ktauh2}}}) 
                setfield Kv4_slow_GP Y_A->table[{i}] {tauh}
                setfield Kv4_slow_GP Y_B->table[{i}] {hinf}
                x = x + dx
        end
        tweaktau Kv4_slow_GP Y
	call Kv4_slow_GP TABFILL Y {xdivs_interp} 0
	setfield Kv4_slow_GP Y_A->calc_mode {NO_INTERP}
	setfield Kv4_slow_GP Y_B->calc_mode {NO_INTERP}

end


//==================================================================
//         			KCNQ 
// Activation kinetics: Gamper, Stockand, Shapiro (2003). J Neurosci 23: 84-95.
// GV curve, deact kinetics: Prole & Marrion (2004). Biophys J. 86: 1454-69.
//==================================================================
function make_KCNQ_GP
        if (({exists KCNQ_GP}))
                return
        end
        create tabchannel KCNQ_GP
	float npower = 4
        setfield KCNQ_GP Ek {EK} Gbar {G_KCNQ_soma} Ik 0 Gk 0\
                Xpower {npower} Ypower 0 Zpower 0
	float taunmax = 0.1	//Q10 = 3 adjusted	
	float taunmin = 0.0067	//Q10 = 3 adjusted
    float Kn = {Kn_KCNQ}
    float Vhalfn = {Vhalfn_KCNQ}	// True Vhalf for channel activation
	float K1tau = -0.025
	float K2tau = -0.035
	float V0n, ninf, taun, alpha, beta
	V0n = {Vhalfn} + ({Kn} * {log {(1 / {pow 0.5 {1/{npower}}}) - 1}})
	echo "KCNQ V0n: " {V0n}
	//V0n is Vhalf for each individual n gate.
	call KCNQ_GP TABCREATE X {xdivs} {xmin} {xmax}
	x = xmin
	for (i = 0; i <= {xdivs}; i = i + 1)
		ninf = 1 / (1 + {exp { ({V0n} - x) / {Kn} } } )
		taun = {taunmin} + (({taunmax} - {taunmin}) / ({exp { ({V0n} - x) / {K1tau} } } + {exp {-({V0n} - x) / {K2tau} }}))
		setfield KCNQ_GP X_A->table[{i}] {taun}
		setfield KCNQ_GP X_B->table[{i}] {ninf}
/* Manual table contruction bypassing tweaktau:
		alpha = {ninf} / {taun}
		beta = {(1 / {taun}) - {alpha}}
		setfield KCNQ_GP X_A->table[{i}] {alpha}
		setfield KCNQ_GP X_B->table[{i}] {1 / {taun}}
*/
		x = x + dx
	end
	tweaktau KCNQ_GP X
	call KCNQ_GP TABFILL X {xdivs_interp} 0
	setfield KCNQ_GP X_A->calc_mode {NO_INTERP}
	setfield KCNQ_GP X_B->calc_mode {NO_INTERP}
end


//==================================================================
//                       HVA Ca2+ Channels 
//	Voltage-dependent activation from GP data:  
//		Surmeier Seno and Kitai 1994
//             	J Neurophysio. 71(3):1272-1280
//==================================================================
//First make a calcium concentration object that will keep track of the
//Ca2+ coming in from the calcium channels and apply buffering. 
function make_Ca_GP_conc
        if (({exists Ca_GP_conc}))
                return
        end
        create Ca_concen Ca_GP_conc
        setfield Ca_GP_conc    \
                tau     {tau_CaClearance}   \   // sec
                B       5.2e-6 \   // Moles per coulomb, later scaled to conc
                Ca_base 5e-05    //Units in mM, so = 50 nM.
end

//Next make nernst object to keep track of Calcium reversal potential
//during changes in intracellular calcium concentration.
function make_Ca_GP_nernst
        if (({exists Ca_GP_nernst}))
                return
        end
	create nernst Ca_GP_nernst
	setfield Ca_GP_nernst	\
		Cout	2	\	//external Ca2+ conc
		Cin	5e-5	\	//baseline internal Ca2+ conc 50 nM
		T	32	\	//temp in Celsius
		valency	2	\	//divalent
		scale 	1		//E in volts
end

//Finally make actual calcium channels.
function make_Ca_HVA_GP
        if (({exists Ca_HVA_GP}))
                return
        end
	int ndivs, i
        float x, y
        create tabchannel Ca_HVA_GP
	setfield Ca_HVA_GP Ek {ECa} Gbar {G_Ca_HVA_soma} Ik 0 Gk 0 \
		Xpower {npower_CaHVA} Ypower 0 Zpower 0

	//first setup voltage-dependent activation
	float tau =  0.0002    //estimated from traces Q10=2.5 adjusted
        float K = -1*{Kn_CaHVA}		// -0.007
        float V0 = {Vhalfn_CaHVA}	// -0.002
        setuptau Ca_HVA_GP X \
                {tau} {tau*1e-6} 0 0 1e6 \
                1 0 1 {-1.0*V0} {K} -range {xmin} {xmax} 
	call Ca_HVA_GP TABFILL X {xdivs_interp} 0
	setfield Ca_HVA_GP X_A->calc_mode {NO_INTERP}
	setfield Ca_HVA_GP X_B->calc_mode {NO_INTERP}

end

function make_Ca_HVA_GP2
        if (({exists Ca_HVA_GP}))
                return
        end
	int ndivs, i
        float x, y
        create tabchannel Ca_HVA_GP
	setfield Ca_HVA_GP Ek {ECa} Gbar {G_Ca_HVA_soma} Ik 0 Gk 0 \
		Xpower {npower_CaHVA} Ypower 0 Zpower 0

	//first setup voltage-dependent activation
        float Kn = {Kn_CaHVA}
	float V0n = {Vhalfn_CaHVA} + ({Kn} * {log {(1 / {pow 0.5 {1/{npower_CaHVA}}}) - 1}})
	float taunmin = 0.0002    //estimated from traces Q10=2.5 adjusted
	float taunmax = 0.0002

	for (i = 0; i <= {xdivs}; i = i + 1)
		ninf = 1 / (1 + {exp { ({V0n} - x) / {Kn} } } )
		taun = {taunmin} + (({taunmax} - {taunmin}) / ({exp { ({V0n} - x) / {Kn} } } + {exp {-({V0n} - x) / {Kn} }}))
		setfield Ca_HVA_GP X_A->table[{i}] {taun}
		setfield Ca_HVA_GP X_B->table[{i}] {ninf}

		x = x + dx
	end

	tweaktau Ca_HVA_GP X
	call Ca_HVA_GP TABFILL X {xdivs_interp} 0
	setfield Ca_HVA_GP X_A->calc_mode {NO_INTERP}
	setfield Ca_HVA_GP X_B->calc_mode {NO_INTERP}

end


//==================================================================
//	SK channel from Volker Steuber's DCN neuron model, modified to
//		reflect Hill fits in the following:
//		Hirschberg et al, 1999: Biophys J. 77: 1905-13. 
//		Keen et al, 1999: J. Neurosci 19: 8830-38.
//		Tau-Ca equation made by Volker based on Hirschberg et al, 1998:
//			JGP 111: 565-581.
//==================================================================	
function make_SK_GP
	if ({exists K_ahp_GP})
		return
	end
 
	float cxmin, cxmax, cxdivs, cdx
	float taum, minf
	float hillslope = 4.6	// Hirschberg et al, 1999
	float taumax = 0.076	// deactivation tau in 0 Ca2+
	float taumin = 0.004	// max activation rate
	float caSat = 0.005	// calcium conc at which tauact hits max
	float tauK = ({taumax} - {taumin}) / {caSat}
	// NOTE: genesis SI concentration units = mols / m^3 = millimolar!
	create tabchannel K_ahp_GP
	setfield K_ahp_GP Ek {EK} Gbar {G_SK_soma}  \
		Xpower 0 Ypower 0 Zpower 1 
	cxmin = 0.00001	// 10 nM
	cxmax = 0.06 		// 60 microM
				// Conc-dependence grid will have xdivs_interp points spanning 
				//	1 nM to 6 microM with resolution of 1 nM.
	cxdivs = 5999	// Have to use high-resolution for channel setup because
			// most of G-Ca curve falls within the first 1 microM.
	cdx = (cxmax - cxmin)/cxdivs
	call K_ahp_GP TABCREATE Z {cxdivs} {cxmin} {cxmax}
	x = cxmin

	for (i = 0; i <= {cxdivs}; i = i + 1)
    
    	if (x < {caSat})
      		taum = ({taumax} - x*{tauK})/{dQ10_SK}
    	else
      		taum = {taumin}/{dQ10_SK}
    	end
    	minf = {pow {x} {hillslope}} / ({pow {x} {hillslope}} + {pow {EC50_SK} {hillslope}})

    	setfield K_ahp_GP Z_A->table[{i}] {taum}
    	setfield K_ahp_GP Z_B->table[{i}] {minf}

		x = x + cdx
  	end
	
	tweaktau K_ahp_GP Z
	call K_ahp_GP TABFILL Z {xdivs_interp} 0
	setfield K_ahp_GP Z_A->calc_mode {NO_INTERP}
	setfield K_ahp_GP Z_B->calc_mode {NO_INTERP}
end
	

//==================================================================
//      H current  (Anomalous rectifier--mixed Na and K current)
//		HCN1/HCN2 heteromeric channel, GP-specific
//		Channel model from Chan et al (2004), J Neurosci 24: 9921-32.
//		Original model from Siegelbaum lab. Wang et al (2002), Neuron 36:
//			451-62. Chen et al (2001), JGP 117: 491-504.
//==================================================================
function make_h_HCN_GP
	if ({exists h_HCN_GP})
       		return
	end
	create tabchannel h_HCN_GP
	setfield h_HCN_GP Ek {Eh} Gbar {{G_h_HCN_soma}}  \
	Xpower 1 Ypower 0 Zpower 0
	float Km      	= -0.0033
    float V0m     	= -0.0764
	float taumin	= 0
	float tau0		= 14.5
	float Ktau1		= 0.00748
	float Ktau2		= 0.00656
	float dq10 = 4
    float minf, taum
    call h_HCN_GP TABCREATE X {xdivs} {xmin} {xmax}
    x = xmin
    for (i = 0; i <= {xdivs}; i = i + 1)
		minf = 1 / (1 + {exp {({V0m} - x) / {Km} }})
    		taum = ({taumin} + {tau0} / ({exp {(x-{V0m})/{Ktau1}}} + {exp {({V0m}-x)/{Ktau2}}})) / dq10
		setfield h_HCN_GP X_A->table[{i}] {taum}
		setfield h_HCN_GP X_B->table[{i}] {minf}
		x = x + dx
    end
    tweaktau h_HCN_GP X
    call h_HCN_GP TABFILL X {xdivs_interp} 0
	setfield h_HCN_GP X_A->calc_mode {NO_INTERP}
	setfield h_HCN_GP X_B->calc_mode {NO_INTERP}
end

//==================================================================
//      H current  (Anomalous rectifier--mixed Na and K current)
//		HCN2 homomeric channel, GP-specific
//		Channel model from Chan et al (2004), J Neurosci 24: 9921-32.
//		Original model from Siegelbaum lab. Wang et al (2002), Neuron 36:
//			451-62. Chen et al (2001), JGP 117: 491-504.
//==================================================================
function make_h_HCN2_GP
	if ({exists h_HCN2_GP})
       		return
	end
	create tabchannel h_HCN2_GP
	setfield h_HCN2_GP Ek {Eh} Gbar {{G_h_HCN2_soma}}  \
	Xpower 1 Ypower 0 Zpower 0
	float Km      	= -0.004
    float V0m     	= -0.0875
	float taumin	= 0
	float tau0		= 25.2
	float Ktau1		= 0.0082
	float Ktau2		= 0.0089
	float dq10 = 4
    float minf, taum
    call h_HCN2_GP TABCREATE X {xdivs} {xmin} {xmax}
    x = xmin
    for (i = 0; i <= {xdivs}; i = i + 1)
		minf = 1 / (1 + {exp {({V0m} - x) / {Km} }})
    		taum = ({taumin} + {tau0} / ({exp {(x-{V0m})/{Ktau1}}} + {exp {({V0m}-x)/{Ktau2}}})) / dq10
		setfield h_HCN2_GP X_A->table[{i}] {taum}
		setfield h_HCN2_GP X_B->table[{i}] {minf}
		x = x + dx
    end
    tweaktau h_HCN2_GP X
    call h_HCN2_GP TABFILL X {xdivs_interp} 0
	setfield h_HCN2_GP X_A->calc_mode {NO_INTERP}
	setfield h_HCN2_GP X_B->calc_mode {NO_INTERP}
end
