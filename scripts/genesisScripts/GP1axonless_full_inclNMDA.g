// GENESIS SETUP FILE

silent


//initialize parameters
include ../../commonGPFull/GP1_defaults.g
include ../../commonGPFull/simdefaults.g
include ../../commonGPFull/actpars.g
include ../../commonFunctions.g

/* COMMENT
ALL intrinsic model params have now been initialized and set. 
They can be safely overwritten any time between now and the calling of
the make_GP_library file. Once the library has been created, parameter values
are set and cannot be changed except with explicit calls to setfield.
*/

rundur = 2

int i
str tstr, hstr, readcompartment

include ../../commonGPFull/make_GP_library.g
setupClocks {1e-5} {5e-5} {rundur}


//load compartments with ion channels
readcell ../../commonGPFull/GP1_axonless.p {cellpath} -hsolve
setupCurrentInjection_GP_full
setupHinesSolver {cellpath}

doPreparations {cellpath}

//do synaptic simulations
G_AMPA  =  0.25e-9
G_NMDA = {G_AMPA}
float excit_counter, inhib_counter
for (inhib_counter = 0; inhib_counter <= 20; inhib_counter = inhib_counter + 10) //inhibition
        striatum_rate = {inhib_counter}
        for (excit_counter = 0; excit_counter <= 10 + {inhib_counter}; excit_counter = excit_counter + 2.5) //excitation
            deleteall -force
	    STN_rate = {excit_counter}
	    include ../../commonGPFull/simulateSynaptic_inclNMDA.g
        end
end
quit
