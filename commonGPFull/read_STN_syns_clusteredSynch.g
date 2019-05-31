str stncompartment
openfile {STNfilename} r
stncompartment = {readfile {STNfilename}}
//cycle through STN input compartments
if ({STN_rate} > 0)
	if ({clusteredSynch} == "true")
		while (! {eof {STNfilename}})
			str timetableName = "timetable" @ {stncompartment}
			call /inputs/STN/{timetableName} RESET
			setfield /inputs/STN/{timetableName} maxtime {rundur} act_val 1.0 method 4 fname {STNtimetablename}
			echo changing {stncompartment} to clustered synch synapse
			call /inputs/STN/{timetableName} TABFILL
			stncompartment = {readfile {STNfilename}}
		end
	else
		echo no compartments synchronized
	end
end
closefile {STNfilename}
