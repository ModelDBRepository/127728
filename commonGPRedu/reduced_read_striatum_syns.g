int i = 0
str striatumcompartment

//create input element tree outside of the cell path
if (!{exists /inputs})
	create neutral /inputs
end
create neutral /inputs/striatum

//cycle through each selected compartment and add synapses

openfile {striatumfname} r
striatumcompartment = {readfile {striatumfname}}
while (! {eof {striatumfname}})
        i = {i} + 1
	float randSeedValue = 20000000 + 123456	* {i}
	randseed {randSeedValue}
	
	if (!{exists {cellpath}/{striatumcompartment}/GABA})
		//Add GABA synapses
        	copy /library/GABA {cellpath}/{striatumcompartment}/GABA
        	addmsg  {cellpath}/{striatumcompartment}/GABA {cellpath}/{striatumcompartment} CHANNEL Gk Ek
        	addmsg  {cellpath}/{striatumcompartment} {cellpath}/{striatumcompartment}/GABA VOLTAGE Vm
		setfield {cellpath}/{striatumcompartment}/GABA gmax {G_GABA}
	end

	if ({striatum_rate} > 0)
		str temp_name = {strsub {stncompartment} [ _ -all} //to allow for unique identification in genesis
		str tempName = {strsub {temp_name} ] _ -all} //to allow for unique identification in genesis
		int currNum = 1
		str timetableName = "timetable" @ {tempName} @ {currNum}
		while ({exists /inputs/striatum/{timetableName}})
			currNum = {currNum} + 1
			timetableName = "timetable" @ {tempName} @ {currNum}
		end
		str spikegenName = "spikegen" @ {tempName} @ {currNum}
		create timetable /inputs/striatum/{timetableName} 
		setfield /inputs/striatum/{timetableName} maxtime {rundur} act_val 1.0 method 1 meth_desc1 {1/{striatum_rate}} 
        	call /inputs/striatum/{timetableName} TABFILL
		create spikegen /inputs/striatum/{spikegenName}
        	setfield /inputs/striatum/{spikegenName} output_amp 1 thresh 0.5
        	//connect timetables to GABA synapses
	        addmsg /inputs/striatum/{timetableName} /inputs/striatum/{spikegenName} INPUT activation
        	addmsg /inputs/striatum/{spikegenName} {cellpath}/{striatumcompartment}/GABA SPIKE
	end
	striatumcompartment = {readfile {striatumfname}}
end
closefile {striatumfname}
