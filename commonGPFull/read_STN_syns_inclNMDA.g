int i = 0
str stncompartment

//create input element tree outside of the cell path
if (!{exists /inputs})
	create neutral /inputs
end
create neutral /inputs/STN

//clear and open file to list compartment names of all excitatory synapses
//	File MUST NOT have any blank lines at the end, or function will fail.
openfile {STNfilename} r
stncompartment = {readfile {STNfilename}}
while (! {eof {STNfilename}})
	i = {i} + 1
	float randSeedValue = 10000000 + 123456	* {i}
	randseed {randSeedValue}

	//Add AMPA synapses
	copy /library/AMPA {cellpath}/{stncompartment}/AMPA
	setfield {cellpath}/{stncompartment}/AMPA gmax {G_AMPA}
	addmsg  {cellpath}/{stncompartment}/AMPA {cellpath}/{stncompartment} CHANNEL Gk Ek
	addmsg  {cellpath}/{stncompartment} {cellpath}/{stncompartment}/AMPA VOLTAGE Vm

	//Add NMDA synapses
	copy /library/NMDA {cellpath}/{stncompartment}/NMDA
	setfield {cellpath}/{stncompartment}/NMDA gmax {G_NMDA}
	copy /library/Mg_block {cellpath}/{stncompartment}/Mg_block
  	addmsg {cellpath}/{stncompartment}/NMDA {cellpath}/{stncompartment}/Mg_block CHANNEL Gk Ek
	addmsg {cellpath}/{stncompartment}/Mg_block {cellpath}/{stncompartment} CHANNEL Gk Ek
  	addmsg {cellpath}/{stncompartment} {cellpath}/{stncompartment}/Mg_block VOLTAGE Vm	
  	addmsg {cellpath}/{stncompartment} {cellpath}/{stncompartment}/NMDA VOLTAGE Vm	
        
	if ({STN_rate} > 0)
		str timetableName = "timetable" @ {stncompartment}
		str spikegenName = "spikegen" @ {stncompartment}
		create timetable /inputs/STN/{timetableName}
		setfield /inputs/STN/{timetableName} maxtime {rundur} act_val 1.0 method 1 meth_desc1 {1/{STN_rate}} 	
		call /inputs/STN/{timetableName} TABFILL
		//set up spikegen
		create spikegen /inputs/STN/{spikegenName}
		setfield /inputs/STN/{spikegenName} output_amp 1 thresh 0.5
        	//connect timetables to synapses
		addmsg /inputs/STN/{timetableName} /inputs/STN/{spikegenName} INPUT activation
        	addmsg /inputs/STN/{spikegenName} {cellpath}/{stncompartment}/AMPA SPIKE
		addmsg /inputs/STN/{spikegenName} {cellpath}/{stncompartment}/NMDA SPIKE
	end
	
	// get next compartment name
	stncompartment = {readfile {STNfilename}}
end
closefile {STNfilename}
