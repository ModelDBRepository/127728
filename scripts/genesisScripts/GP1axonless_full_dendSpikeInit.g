// GENESIS SETUP FILE

silent

//initialize parameters
include ../../commonGPFull/GP1_defaults.g
include ../../commonGPFull/simdefaults.g
include ../../commonGPFull/actpars.g
include ../../commonFunctions.g

compListFilename = "../../commonGPFull/gp1allCompNames_sortedByEdist.asc"

// Now that all params have been established, create library objects.
//	Intrinsic params should be left alone from this point forward.

str basefilename = "this_run_dendSpikeInit_dendNaF800_full_"
openfile {compListFilename} r
str injectCompt
int counter = 2
int maxCounter = 512
int i
while (counter <= {maxCounter})
	for (i = 1;i <= {counter};i = i+1)
		injectCompt = {readfile {compListFilename}}
	end
	
	deleteall -force
	include ../../commonGPFull/make_GP_library.g	
	setupClocks {1e-5} {1e-5} {1}
	echo {injectCompt}
	//load compartments with ion channels
	readcell ../../commonGPFull/GP1_axonless.p {cellpath} -hsolve
	setupCurrentInjection_altDendPulses {injectCompt}
	setupHinesSolver {cellpath}
	doPreparations_passive {cellpath} {injectCompt}
	
	str filename_v = {basefilename} @ {counter} @ ".bin"
	setfield /out_v filename {filename_v}
	reset

	setpulse_sine {-40} {0} {-40} {"/pulse/soma"}
	str pulseToUse = "/pulse/" @ {injectCompt}
	if ({counter} > 76)
		setpulse {400} {1} {0.002} {pulseToUse}
	else
		setpulse {600} {1} {0.002} {pulseToUse}
	end
	step 1.020 -time

	mv {filename_v} "./genesisFiles/dendSpikeInitData"
	counter = {counter} + 1
	openfile {compListFilename} r
end


closefile {compListFilename}
quit
