if ({STN_rate} > 0)
	if ({clusteredSynch} == "true")
		for (i = 1 + {synapseStartIndex}; i <= {numSTNsynapses} + {synapseStartIndex}; i = i + 1)
			str temp_name = {strsub {stncompartment} [ _ -all} //to allow for unique identification in genesis
			str tempName = {strsub {temp_name} ] _ -all} //to allow for unique identification in genesis
			str timetableName = "timetable" @ {tempName} @ {i}
			call /inputs/STN/{timetableName} RESET
			setfield /inputs/STN/{timetableName} maxtime {rundur} act_val 1.0 method 4 fname {STNtimetablename}
			echo changing {stncompartment} synapse {i} to clustered synch synapse
			call /inputs/STN/{timetableName} TABFILL
		end
	else
		echo no synchronized synapses
	end
end

