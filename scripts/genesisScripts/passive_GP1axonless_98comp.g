// GENESIS SETUP FILE

silent

//initialize parameters
include ../../commonGPRedu/GP1axonless_defaults_full.g
include ../../commonGPRedu/simdefaults.g
include ../../commonGPRedu/actpars.g
include ../../commonFunctions.g

compListFilename = "../../commonGPRedu/gp1allcompnames_98comp.asc"

// Now that all params have been established, create library objects.
//	Intrinsic params should be left alone from this point forward.

str basefilename = "this_run_sine_98comp_"
openfile {compListFilename} r
str injectCompt
int counter = 2
int maxCounter = 97
int i
while (counter <= {maxCounter})
	for (i = 1;i <= {counter};i = i+1)
		injectCompt = {readfile {compListFilename}}
	end
	
	deleteall -force
	include ../../commonGPRedu/make_GP_library_nochans.g	
	setupClocks {1e-5} {1e-5} {1}

	//load compartments with ion channels
	readcell ../../commonGPRedu/GP1_98comp.p {cellpath} -hsolve
	setupCurrentInjection_alt {injectCompt}
	setupHinesSolver {cellpath}
	doPreparations_passive {cellpath} {injectCompt}
	
	str filename_v = {basefilename} @ {counter}
	setfield /out_v filename {filename_v}
	reset

	setpulse_sine {0} {0} {0} {"/pulse/" @ {injectCompt}}
	str pulseToUse = "/pulse/soma"
	setpulse_sine {50} {0} {50} {pulseToUse}	
	step 0.5 -time
	setpulse_sine {0} {0} {0} {pulseToUse}
	step 0.5 -time
	setpulse_sine {50} {1000} {0} {pulseToUse}
	step 0.25 -time
	setpulse_sine {0} {0} {0} {pulseToUse}
	step 0.25 -time

	setpulse_sine {0} {0} {0} {"/pulse/soma"}
	pulseToUse = "/pulse/" @ {injectCompt}
	setpulse_sine {50} {0} {50} {pulseToUse}
	step 0.5 -time
	setpulse_sine {0} {0} {0} {pulseToUse}
	step 0.5 -time
	setpulse_sine {50} {1000} {0} {pulseToUse}
	step 0.25 -time
	setpulse_sine {0} {0} {0} {pulseToUse}
	step 0.25 -time

	mv {filename_v} "./genesisFiles/passiveData"
	counter = {counter} + 1
	openfile {compListFilename} r
end


closefile {compListFilename}
quit
