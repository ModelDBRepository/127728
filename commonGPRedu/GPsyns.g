// GENESIS script: GP model synaptic properties
// Created by Jesse Hanson
// Modified:
//	08/2004: channel time constants made variables.

float IncF = 1.4
float IncD = .9
float tauF = .241
float tauD = .491
function make_GP_syns
	if (!({exists AMPA}))
		create synchan AMPA
	end
	setfield AMPA Ek {E_AMPA} tau1 {tauRise_AMPA} tau2 {tauFall_AMPA} \
		gmax {G_AMPA} frequency 0 

/*	if (!({exists stpAMPA}))
                create stpsynchan stpAMPA
        end
        setfield stpAMPA Ek {E_AMPA} tau1 1e-3 tau2 3e-3 gmax {G_AMPA} \
		fac_per_spike {IncF} depr_per_spike {IncD}   \
                fac_tau {tauF}  depr_tau {tauD}              \
                max_fac 5
*/	
	if (!({exists NMDA}))
                create synchan NMDA
        end
	setfield NMDA Ek {E_NMDA} tau1 {tauRise_NMDA} tau2 {tauFall_NMDA} \
		gmax {G_NMDA} frequency 0
	
	if (!({exists Mg_block}))
                create Mg_block Mg_block 
        end
	setfield Mg_block		\
		CMg    0.25		\
		KMg_A  1		\
		KMg_B  {1/{0.057*1000}}

	if (!({exists GABA}))
	       	create synchan GABA
	end
	setfield GABA Ek {E_GABA} tau1 {tauRise_GABA} tau2 {tauFall_GABA}  \
		gmax {G_GABA} frequency 0

	if (!({exists GABA_GP}))
	       	create synchan GABA_GP
	end
	setfield GABA_GP Ek {E_GABA} tau1 {tauRise_GABA_GP} \
		tau2 {tauFall_GABA_GP} gmax {G_GABA_GP} frequency 0
end


function make_GP_AMPA
	if (!({exists AMPA}))
		create synchan AMPA
	end
	setfield AMPA Ek {E_AMPA} tau1 {tauRise_AMPA} tau2 {tauFall_AMPA} \
		gmax {G_AMPA} frequency 0 
end

function make_GP_GABA_striatum
	if (!({exists GABA}))
	       	create synchan GABA
	end
	setfield GABA Ek {E_GABA} tau1 {tauRise_GABA} tau2 {tauFall_GABA}  \
		gmax {G_GABA} frequency 0
end

function make_GP_GABA_pallidum
	if (!({exists GABA_GP}))
	       	create synchan GABA_GP
	end
	setfield GABA_GP Ek {E_GABA} tau1 {tauRise_GABA_GP} \
		tau2 {tauFall_GABA_GP} gmax {G_GABA_GP} frequency 0
end


