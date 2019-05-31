// In use 10/10/2004 -- present
// Add striatal synapses, but normalize rate by compartment surface area.
/* The following params must be set prior to calling this file:
	str striatumfname: file name of compartments to get striatal inputs
	int num_striatum_compts: number of compartments to get striatal inputs
	int num_striatum_per_comp: # striatal syns per selected compartment.

   All are currently initialized and set in GP$1_defaults.g, but can be
   overwritten as needed.

   Modified 10/10/2004: made the rate of each compartment's striatal inputs
   normalized by that compartment's surface area relative to the mean surface
   area for all compartments receiving striatal input. So the total number of
   events arriving at the "average" compartment = 
   {striatum_rate} * {num_striatum_per_comp}
   
   This input rate can be translated to a constant, uniform input in units of
   events / sec / micron2 by dividing {striatum_rate} * {num_striatum_per_comp}
   by the total surface area of the dendritic compartments receiving input. 
*/

randseed 78123456 
int i
str striatumcompartment

//create input element tree outside of the cell path
if (!{exists /inputs})
	create neutral /inputs
end
create neutral /inputs/striatum

//cycle through each selected compartment and add synapses
for (i = 1; i <= {num_striatum_compts}; i = i + 1)
        striatumcompartment = "soma"
	str GABAname = "GABA" @ {i}	

        copy /library/GABA {cellpath}/{striatumcompartment}/{GABAname}
        addmsg  {cellpath}/{striatumcompartment}/{GABAname} {cellpath}/{striatumcompartment} CHANNEL Gk Ek
        addmsg  {cellpath}/{striatumcompartment} {cellpath}/{striatumcompartment}/{GABAname} VOLTAGE Vm
	setfield {cellpath}/{striatumcompartment}/{GABAname} gmax {G_GABA}
	
	str timetableName = "timetable" @ {i}
	str spikegenName = "spikegen" @ {i}

	//set up timetables  
	create timetable /inputs/striatum/{timetableName}
	if ({striatum_rate} > 0)
		setfield /inputs/striatum/{timetableName} maxtime {rundur} act_val 1.0 method 1 meth_desc1 {1/{striatum_rate}} 
        	call /inputs/striatum/{timetableName} TABFILL
	end
	
	//set up spikegen
        create spikegen /inputs/striatum/{spikegenName}
        setfield /inputs/striatum/{spikegenName} output_amp 1 thresh 0.5
        //connect timetables to GABA synapses
	if ({striatum_rate} > 0)
           addmsg /inputs/striatum/{timetableName} /inputs/striatum/{spikegenName} INPUT activation
           addmsg /inputs/striatum/{spikegenName} {cellpath}/{striatumcompartment}/{GABAname} SPIKE
	end
end
