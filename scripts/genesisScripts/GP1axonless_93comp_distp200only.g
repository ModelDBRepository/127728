// GENESIS SETUP FILE

silent

//initialize parameters
include ../../commonGPRedu/GP1axonless_defaults_full.g
include ../../commonGPRedu/simdefaults.g
include ../../commonGPRedu/actpars.g
include ../../commonFunctions.g

compListFilename = "../../commonGPRedu/gp1allcompnames_93comp.asc"

// Now that all params have been established, create library objects.
//	Intrinsic params should be left alone from this point forward.

str basefilename = "this_run_dist_200_dendNaF40_93comp_"
openfile {compListFilename} r
str injectCompt
int counter = 57
int maxCounter = 57
int i
while (counter <= {maxCounter})
	for (i = 1;i <= {counter};i = i+1)
		injectCompt = {readfile {compListFilename}}
	end
	
	deleteall -force
	include ../../commonGPRedu/make_GP_library.g	
	setupClocks {1e-5} {1e-5} {1}

	//load compartments with ion channels
	readcell ../../commonGPRedu/GP1_93comp.p {cellpath} -hsolve
	setupCurrentInjection_alt {injectCompt}
	setupHinesSolver {cellpath}
	doPreparations {cellpath}
	
	str filename_v = {basefilename} @ {counter} @ ".bin"
	setfield /out_v filename {filename_v}
	reset

	setpulse_sine {0} {0} {0} {"/pulse/soma"}
	str pulseToUse = "/pulse/" @ {injectCompt}
	setpulse_sine {200} {0} {200} {pulseToUse}
	step 0.5 -time


	//mv {filename_v} "./genesisFiles/dendriticCurrentInjectionData/"
	mv {filename_v} "./genesisFiles"
	counter = {counter} + 1
	openfile {compListFilename} r
end


closefile {compListFilename}
quit
