// Define simulation defaults that may need to be changed for optimization but
//	that will be the same for all morphologies and for both spiking and
//	non-spiking models.

//Sodium channel kinetics & voltage dependence
float Vhalfm_NaF	= -0.0324
float Km_NaF 		= 0.005
float taummax_NaF	= 0.000028
float taummin_NaF	= 0.000028

float V0h_NaF		= -0.048
float Kh_NaF		= -0.0028
float tauhV0_NaF	= -0.043
float tauhmax_NaF	= 0.004
float tauhmin_NaF	= 0.00025	// 0.0002

float V0s_NaF		= -0.040
float Ks_NaF		= -0.0054
float mins_NaF		= 0.15
float Ktaus1_NaF	= 0.0183
float Ktaus2_NaF	= 0.010
float tausmax_NaF	= 1
float tausmin_NaF	= 0.01

float Vhalfm_NaP	= -0.050
float V0h_NaP 		= -0.057
float Kh_NaP		= -0.004
float hmin_NaP		= 0.154
float V0s_NaP		= -0.01
float Abeta_NaP		= 6.94
float Bbeta_NaP		= 0.447

//Kv2 properties
float npower_Kv2	= 4
float Vhalfn_Kv2	= -0.018
float Kn_Kv2		= 0.0091
float taunmax_Kv2	= 0.03
float taunmin_Kv2	= 0.0001
float hmin_Kv2		= 0.2

//Kv3 properties
float npower_Kv3	= 4
float Vhalfn_Kv3	= -0.013	// Actual Vhalf
float Kn_Kv3		= 0.0078	// Yields K = 6 mV with Xpower = 4
float hmin_Kv3		= 0.6

//Kv4 properties
float V0n_Kv4		= -0.049	// Yields Vhalf = -27 mV when Xpower = 4
float Kn_Kv4		= 0.0125	// Yields K = 9.6 mV when Xpower = 4
float Ktaun1_Kv4	= 0.029
float Ktaun2_Kv4	= 0.029

float V0h_Kv4		= -0.083	// changed from -0.072 02/17/2005 to match 
									// Tkatch et al
float Kh_Kv4		= -0.01	// changed from -0.0047 02/17/2005 to match 
									// Tkatch et al
float Ktauh1_Kv4	= 0.010
float Ktauh2_Kv4	= 0.010

//KCNQ properties
float Vhalfn_KCNQ 	= -0.0285
float Kn_KCNQ		= 0.0195	// Yields K = 15 mV for 1st order Boltzmann
								//	when Xpower = 4.

//SK channel properties
float EC50_SK = 0.00035	// SI unit = mM; default = 350 nM.
float dQ10_SK = 2

//CaHVA properties
float npower_CaHVA 	= 1
float Vhalfn_CaHVA 	= -0.02
float Kn_CaHVA 		= 0.007 

//Voltage-gated ion channel reversal potentials
float ENa = 0.050
float ECa = 0.130
float EK = -0.090
float Eh = -0.03

//Calcium concentration parameters
float B_Ca_GP_conc = 4.0/3.0*5.2e-12//3.6e-7 //changed on 10/15/2009 to be consistent with GPcomps.g
float shell_thick  = 20e-9 	//	meters 
float tau_CaClearance = 0.001	// 	time constant for Ca2+ clearance (sec)

//Synaptic conductances
// STN excitatory inputs
float G_AMPA    	= 0.25e-9
float tauRise_AMPA 	= 0.001
float tauFall_AMPA	= 0.003

float G_NMDA    	= {G_AMPA} //not used yet!
float tauRise_NMDA	= 0.01
float tauFall_NMDA	= 0.03

// Striatal inhibitory inputs
float G_GABA    	= 0.25e-9
float tauRise_GABA	= 0.001
float tauFall_GABA	= 0.012

// Pallidal inhibitory collaterals
float G_GABA_GP 	= 1.50e-9 	//pallidal inputs
float tauRise_GABA_GP	= 0.001
float tauFall_GABA_GP	= 0.012

// Default input rates = 0
float STN_rate      	= 0
float striatum_rate 	= 0
float pallidum_rate 	= 0

// Reversal potentials
float E_AMPA 		= 0
float E_NMDA 		= 0
float E_GABA 		= -0.080

//simulation defaults 
str cellpath = "/GP"
float dt = 1e-5
float rundur = 3	// duration of each run (seconds)

 
