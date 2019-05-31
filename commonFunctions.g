function setpulse (cip_pA, delay, width, pulseToUse)
  setfield {pulseToUse}		     	\
	level1          {{cip_pA}*1e-12}\
	width1 		{width}	       	\
	delay1          {delay}		\
	delay2          50      	\
	baselevel       0 		\
	trig_mode       0
end

function setpulse_sine (cip_pA, freq, offset, pulseToUse)
  setfield {pulseToUse}		     	\
	mode 		0		\
	amplitude       {{cip_pA}*1e-12}\
	frequency       {freq}		\
	dc_offset	{{offset}*1e-12}		
end

function injectCurrent (cip_pA, pulseToUse, cellpath)
	if ({pulseToUse} == "/pulseSoma")
 		str filename_v = {basefilename} @ "_soma_" @ cip_pA @ "_pAcip_v.bin"
	elif ({pulseToUse} == "/pulseProx")
		str filename_v = {basefilename} @ "_prox_" @ cip_pA @ "_pAcip_v.bin"
	else
		str filename_v = {basefilename} @ "_dist_" @ cip_pA @ "_pAcip_v.bin"
	end
	
	setfield /out_v filename {filename_v}
	setpulse_sine {cip_pA} {0} {cip_pA} {pulseToUse}
	reset
	step {rundur} -time
	mv {filename_v} {mvDir}
end

function injectMockAP_forCurrentsAnalysis_saveLocally (cellpath, readName)
 	str filename_v = "inject_mockAP_" @ {modelName} @ ".bin"
	setfield /out_v filename {filename_v}

	reset
	step 0.1 -time
	setpulse_sine {5000} {0} {5000} {"/pulseSoma"}
	step 0.0005 -time
	setpulse_sine {0} {0} {0} {"/pulseSoma"}
	step 0.3995 -time
	mv {filename_v} "./genesisFiles"
end


function runSynaptic_GP_saveLocally
	//str filename_v = "this_run_1_STNrate_" @ {STN_rate} @ "_striatumrate_" @ {striatum_rate} @ "_0_pAcip_v.bin"
	str filename_v = "this_run_1_STNrate_" @ {STN_rate} @ "_striatumrate_" @ {striatum_rate} @ "_dendNaF" @ {G_NaF_dend} @ "_" @ {modelName} @ ".bin"
	setfield /out_v filename {filename_v}
	reset
	step {rundur} -time
	mv {filename_v} "./genesisFiles"
end

function runSynaptic_GP_clusteredSynch_saveLocally
	str filename_v = "this_run_1_STNrate_" @ {STN_rate} @ "_striatumrate_" @ {striatum_rate} @ "_clusteredSynch_" @ {clusteredSynch} @ "_dendNaF_" @ {G_NaF_dend} @ "_" @ {modelName} @ ".bin"
	setfield /out_v filename {filename_v}
	setpulse_sine {somaticInjection} {0} {somaticInjection} {"/pulseSoma"}
	reset
	step {rundur} -time
	mv {filename_v} "./genesisFiles"
end

function saveSomaVm (cellpath)
	str hstr = {findsolvefield {cellpath} {cellpath}/soma Vm} 
	addmsg {cellpath} /out_v SAVE {hstr}
end

function saveComptsVm (cellpath, complistfile)
	openfile {complistfile} r
	str readcompartment = {readfile {complistfile}}
	while(!{eof {complistfile}})
		str hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment} Vm} 
		addmsg {cellpath} /out_v SAVE {hstr}
		readcompartment = {readfile {complistfile}}
	end
end

function saveComptsVmAndCurrents (cellpath, complistfile)
	openfile {complistfile} r
	str readcompartment = {readfile {complistfile}}
	while(!{eof {complistfile}})
		str hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment} Vm} 
		addmsg {cellpath} /out_v SAVE {hstr}
		
		str hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/Na_fast_GP Ik}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/Na_slow_GP Ik}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/Kv2_GP Ik}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/Kv3_GP Ik}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/Kv4_fast_GP Ik}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/Kv4_slow_GP Ik}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/KCNQ_GP Ik}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/K_ahp_GP Ik}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/Ca_HVA_GP Ik}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/h_HCN_GP Ik}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/h_HCN2_GP Ik}
		addmsg {cellpath} /out_v SAVE {hstr}
		readcompartment = {readfile {complistfile}}
	end
end

function saveComptsVmAndConductances (cellpath, complistfile)
	openfile {complistfile} r
	str readcompartment = {readfile {complistfile}}
	while(!{eof {complistfile}})
		str hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment} Vm} 
		addmsg {cellpath} /out_v SAVE {hstr}
		
		str hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/Na_fast_GP Gk}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/Na_slow_GP Gk}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/Kv2_GP Gk}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/Kv3_GP Gk}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/Kv4_fast_GP Gk}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/Kv4_slow_GP Gk}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/KCNQ_GP Gk}
		addmsg {cellpath} /out_v SAVE {hstr}
		hstr = {findsolvefield {cellpath} {cellpath}/{readcompartment}/K_ahp_GP Gk}
		addmsg {cellpath} /out_v SAVE {hstr}
		readcompartment = {readfile {complistfile}}
	end
end

function saveTotalCurrents (cellpath)
	int i
	for(i=0; i<=17; i = i+1)
               addmsg {cellpath} /out_v SAVE itotal[{i}]
        end
end

function saveSomaticCurrents (cellpath)
	str hstr = {findsolvefield {cellpath} {cellpath}/soma/Na_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/Na_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/Kv2_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/Kv3_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/Kv4_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/Kv4_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/KCNQ_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/K_ahp_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
end

function saveSomaAxonSpikeCurrents(cellpath)
	str hstr = {findsolvefield {cellpath} {cellpath}/soma/Na_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/Kv2_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/Kv3_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/Kv4_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/Kv4_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	str hstr = {findsolvefield {cellpath} {cellpath}/axon/Na_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/Kv2_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/Kv3_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/Kv4_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/Kv4_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
end

function saveAxonSpikeGatingVars(cellpath)
	str hstr = {findsolvefield {cellpath} {cellpath}/axon/Kv4_fast_GP X}
	addmsg {cellpath} /out_v SAVE {hstr}
	str hstr = {findsolvefield {cellpath} {cellpath}/axon/Na_fast_GP Z}
	addmsg {cellpath} /out_v SAVE {hstr}
	str hstr = {findsolvefield {cellpath} {cellpath}/axon/Na_fast_GP X}
	addmsg {cellpath} /out_v SAVE {hstr}
end

function saveSomaticConductances(cellpath)
	str hstr = {findsolvefield {cellpath} {cellpath}/soma/Na_fast_GP Gk}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/Na_slow_GP Gk}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/Kv2_GP Gk}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/Kv3_GP Gk}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/Kv4_fast_GP Gk}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/Kv4_slow_GP Gk}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/KCNQ_GP Gk}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/soma/K_ahp_GP Gk}
	addmsg {cellpath} /out_v SAVE {hstr}
end

function saveAxonalConductances(cellpath)
	str hstr = {findsolvefield {cellpath} {cellpath}/axon/Na_fast_GP Gk}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/Na_slow_GP Gk}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/Kv2_GP Gk}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/Kv3_GP Gk}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/Kv4_fast_GP Gk}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/Kv4_slow_GP Gk}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/KCNQ_GP Gk}
	addmsg {cellpath} /out_v SAVE {hstr}
end

function saveMostProxComptsVmAndCurrents (cellpath)
	str hstr = {findsolvefield {cellpath} {cellpath}/p0b1 Vm}
	addmsg {cellpath} /out_v SAVE {hstr}
	if ({modelName} == "full")
		hstr = {findsolvefield {cellpath} {cellpath}/p1[1] Vm}
		str p1comp = "p1[1]"
	else
		hstr = {findsolvefield {cellpath} {cellpath}/p1 Vm}
		str p1comp = "p1"
	end
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/p2b2 Vm}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon Vm}
	addmsg {cellpath} /out_v SAVE {hstr}

	hstr = {findsolvefield {cellpath} {cellpath}/p0b1/Na_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/p0b1/Na_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/p0b1/Kv2_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/p0b1/Kv3_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/p0b1/Kv4_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/p0b1/Kv4_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/p0b1/KCNQ_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/p0b1/K_ahp_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}

	hstr = {findsolvefield {cellpath} {cellpath}/{p1comp}/Na_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{p1comp}/Na_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{p1comp}/Kv2_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{p1comp}/Kv3_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{p1comp}/Kv4_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{p1comp}/Kv4_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{p1comp}/KCNQ_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{p1comp}/K_ahp_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	
	hstr = {findsolvefield {cellpath} {cellpath}/p2b2/Na_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/p2b2/Na_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/p2b2/Kv2_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/p2b2/Kv3_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/p2b2/Kv4_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/p2b2/Kv4_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/p2b2/KCNQ_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/p2b2/K_ahp_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}

	hstr = {findsolvefield {cellpath} {cellpath}/axon/Na_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/Na_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/Kv2_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/Kv3_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/Kv4_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/Kv4_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon/KCNQ_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
end

function saveDistComptVmAndCurrents (cellpath)
	str distComp
	if ({modelNamePassive} == "5comp")
		distComp = "p2b2"
	elif ({modelNamePassive} == "14comp")
		distComp = "p2b2[3]"		
	elif ({modelNamePassive} == "50comp")
		distComp = "p2b2[15]"
	elif ({modelNamePassive} == "98comp")
		distComp = "p2b2[31]"
	elif ({modelNamePassive} == "41comp" || {modelNamePassive} == "59comp")
		distComp = "p2b2b2b1"
	elif ({modelNamePassive} == "93comp")
		distComp = "p2b2b2b1[1]"
	elif ({modelNamePassive} == "full")
		distComp = "p2b2b2b1[10]"
	end
	str hstr = {findsolvefield {cellpath} {cellpath}/{distComp} Vm}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{distComp}/Na_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{distComp}/Na_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{distComp}/Kv2_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{distComp}/Kv3_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{distComp}/Kv4_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{distComp}/Kv4_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{distComp}/KCNQ_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{distComp}/K_ahp_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
end

function saveClustComptVmAndCurrents (cellpath)
	str clustComp //see notes of 3/16/2009 --> DistA cluster
	if ({modelName} == "5comp")
		//clustComp = "p2b2"
		clustComp = "p1"
	elif ({modelName} == "14comp")
		//clustComp = "p2b2[3]"
		clustComp = "p1[1]"
	elif ({modelName} == "50comp")
		//clustComp = "p2b2[12]"
		clustComp = "p1[9]"
	elif ({modelName} == "98comp")
		clustComp = "p2b2[25]"
	elif ({modelName} == "41comp")
		clustComp = "p2b2b2"
	elif ({modelName} == "59comp")
		clustComp = "p2b2b2[3]"
	elif ({modelName} == "93comp")
		clustComp = "p2b2b2[6]"
	elif ({modelName} == "full")
		clustComp = "p2b2b2[46]"
	end
	str hstr = {findsolvefield {cellpath} {cellpath}/{clustComp} Vm}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{clustComp}/Na_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{clustComp}/Na_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{clustComp}/Kv2_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{clustComp}/Kv3_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{clustComp}/Kv4_fast_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{clustComp}/Kv4_slow_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{clustComp}/KCNQ_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/{clustComp}/K_ahp_GP Ik}
	addmsg {cellpath} /out_v SAVE {hstr}
end

function saveMostProxComptsVm (cellpath)
	str hstr = {findsolvefield {cellpath} {cellpath}/p0b1 Vm}
	addmsg {cellpath} /out_v SAVE {hstr}
	if ({modelName} == "full")
		hstr = {findsolvefield {cellpath} {cellpath}/p1[1] Vm}
		addmsg {cellpath} /out_v SAVE {hstr}
	else
		hstr = {findsolvefield {cellpath} {cellpath}/p1 Vm}
		addmsg {cellpath} /out_v SAVE {hstr}	
	end
	hstr = {findsolvefield {cellpath} {cellpath}/p2b2 Vm}
	addmsg {cellpath} /out_v SAVE {hstr}
	hstr = {findsolvefield {cellpath} {cellpath}/axon Vm}
	addmsg {cellpath} /out_v SAVE {hstr}
end

function saveDistComptVmPassive (cellpath)
	str hstr
	if ({modelNamePassive} == "5comp")
		hstr = {findsolvefield {cellpath} {cellpath}/p2b2 Vm}
		//hstr = {findsolvefield {cellpath} {cellpath}/p1 Vm}
	elif ({modelNamePassive} == "14comp")
		hstr = {findsolvefield {cellpath} {cellpath}/p2b2[3] Vm} //standard string
		//hstr = {findsolvefield {cellpath} {cellpath}/p1[2] Vm}
		//hstr = {findsolvefield {cellpath} {cellpath}/p0b1[0] Vm}
	elif ({modelNamePassive} == "50comp")
		hstr = {findsolvefield {cellpath} {cellpath}/p2b2[15] Vm}
		//hstr = {findsolvefield {cellpath} {cellpath}/p1[9] Vm}
		//hstr = {findsolvefield {cellpath} {cellpath}/p0b1[3] Vm}
	elif ({modelNamePassive} == "98comp")
		hstr = {findsolvefield {cellpath} {cellpath}/p2b2[31] Vm}
	elif ({modelNamePassive} == "41comp" || {modelNamePassive} == "59comp")
		//hstr = {findsolvefield {cellpath} {cellpath}/p2b2b2b1 Vm}
		//hstr = {findsolvefield {cellpath} {cellpath}/p2b2b1b2b1[2] Vm}
		//hstr = {findsolvefield {cellpath} {cellpath}/p2b2b2b2 Vm}
		hstr = {findsolvefield {cellpath} {cellpath}/p2b2b1b1 Vm}
	elif ({modelNamePassive} == "93comp")
		//hstr = {findsolvefield {cellpath} {cellpath}/p2b2b2b1[1] Vm}
		//hstr = {findsolvefield {cellpath} {cellpath}/p2b2b1b2b1[2] Vm}
		//hstr = {findsolvefield {cellpath} {cellpath}/p2b2b2b2 Vm}
		hstr = {findsolvefield {cellpath} {cellpath}/p2b2b1b1[6] Vm}
	elif ({modelNamePassive} == "full")
		//hstr = {findsolvefield {cellpath} {cellpath}/p2b2b2b1[10] Vm}
		//hstr = {findsolvefield {cellpath} {cellpath}/p2b2b1b2b1[40] Vm}
		//hstr = {findsolvefield {cellpath} {cellpath}/p2b2b2b2[9] Vm}
		hstr = {findsolvefield {cellpath} {cellpath}/p2b2b1b1[46] Vm}
	end
	addmsg {cellpath} /out_v SAVE {hstr}
end

function saveDistComptVmPassiveAlt (cellpath,injectCompt)
	str hstr = {findsolvefield {cellpath} {cellpath}/{injectCompt} Vm}
	addmsg {cellpath} /out_v SAVE {hstr}
end

function saveAxonVm (cellpath)
	str hstr = {findsolvefield {cellpath} {cellpath}/axon Vm} 
	addmsg {cellpath} /out_v SAVE {hstr}
end

function calccclamp
  	float Iinj = {{getfield /inputs/soma/cclampt output}}
	setpulse {Iinj} {0} {rundur} {"/pulseSoma"}
end

function doPreparations (cellpath)
	create disk_out /out_v
	useclock /out_v 1
	setfield /out_v flush 0 append 0 leave_open 1
	saveSomaVm {cellpath}	
	//saveComptsVm {cellpath} {compListFilename}
	//saveComptsVmAndCurrents {cellpath} {compListFilename}
	//saveComptsVmAndConductances {cellpath} {midDistACompts}
	//saveTotalCurrents {cellpath}
	//saveSomaticCurrents {cellpath}
	//saveSomaAxonSpikeCurrents {cellpath}
	//saveAxonSpikeGatingVars {cellpath}
	//saveSomaticConductances {cellpath}
	//saveAxonalConductances {cellpath}
	//saveDistComptVmAndCurrents {cellpath}
	//saveClustComptVmAndCurrents {cellpath} //see notes of 2/5/2009
	//saveMostProxComptsVmAndCurrents {cellpath} //see notes of 2/11/2009
	//saveMostProxComptsVm {cellpath}
	//saveDistComptVmPassive {cellpath}
	//saveAxonVm {cellpath}
end

function doPreparations_passive (cellpath,injectCompt)
	echo compt: {injectCompt}
	create disk_out /out_v
	useclock /out_v 1
	setfield /out_v flush 0 append 0 leave_open 1
	saveSomaVm {cellpath}
	//saveComptsVm {cellpath} {compListFilename}
	//saveDistComptVmPassiveAlt {cellpath} {injectCompt}
end

function setupClocks (simDt, outputDt, RUNDUR)
	rundur = RUNDUR
	dt = simDt
	setclock 0 {simDt}	// simulation
	setclock 1 {outputDt} 	// output 
end

function setupHinesSolver (cellpath)
	//silent -1
	setfield {cellpath} 						\
		path {cellpath}/##[][TYPE=compartment] 	\
        	comptmode       1 			\
        	chanmode        4 			\
        	calcmode        0 			\
        	outclock        1 			\
        	storemode       1
		call {cellpath} SETUP
		setmethod 11
end

function setupCurrentInjection_1comp
	create funcgen /pulseSoma
	setpulse_sine {0} {0} {0} {"/pulseSoma"}
	addmsg /pulseSoma {cellpath}/soma INJECT output
end

function setupCurrentInjection_41comp
	create funcgen /pulseSoma
	create funcgen /pulseDist
	setpulse_sine {0} {0} {0} {"/pulseSoma"}
	setpulse_sine {0} {0} {0} {"/pulseDist"}
	addmsg /pulseSoma {cellpath}/soma INJECT output
	addmsg /pulseDist {cellpath}/p2b2b1b1 INJECT output
end

function setupCurrentInjection_59comp
	create funcgen /pulseSoma
	create funcgen /pulseDist
	setpulse_sine {0} {0} {0} {"/pulseSoma"}
	setpulse_sine {0} {0} {0} {"/pulseDist"}
	addmsg /pulseSoma {cellpath}/soma INJECT output
	addmsg /pulseDist {cellpath}/p2b2b2b1 INJECT output
end

function setupCurrentInjection_93comp
	create funcgen /pulseSoma
	create funcgen /pulseDist
	setpulse_sine {0} {0} {0} {"/pulseSoma"}
	setpulse_sine {0} {0} {0} {"/pulseDist"}
	addmsg /pulseSoma {cellpath}/soma INJECT output
	addmsg /pulseDist {cellpath}/p2b2b1b1[6] INJECT output
end

function setupCurrentInjection_5comp
	create funcgen /pulseSoma
	create funcgen /pulseDist
	setpulse_sine {0} {0} {0} {"/pulseSoma"}
	setpulse_sine {0} {0} {0} {"/pulseDist"}
	addmsg /pulseSoma {cellpath}/soma INJECT output
	addmsg /pulseDist {cellpath}/p2b2 INJECT output //standard string
end

function setupCurrentInjection_alt (injectCompt)
	create neutral /pulse
	create funcgen /pulse/soma
	create funcgen /pulse/{injectCompt}
	setpulse_sine {0} {0} {0} {"/pulse/soma"}
	setpulse_sine {0} {0} {0} {"/pulse/" @ {injectCompt}}
	addmsg /pulse/soma {cellpath}/soma INJECT output //standard string
	addmsg /pulse/{injectCompt} {cellpath}/{injectCompt} INJECT output //standard string
end

function setupCurrentInjection_altDendPulses (injectCompt)
	create neutral /pulse
	create funcgen /pulse/soma
	create pulsegen /pulse/{injectCompt}
	setpulse_sine {0} {0} {0} {"/pulse/soma"}
	setpulse {0} {0} {0} {"/pulse/" @ {injectCompt}}
	addmsg /pulse/soma {cellpath}/soma INJECT output
	addmsg /pulse/{injectCompt} {cellpath}/{injectCompt} INJECT output 
end

function setupCurrentInjection_14comp
	create funcgen /pulseSoma
	create funcgen /pulseDist
	setpulse_sine {0} {0} {0} {"/pulseSoma"}
	setpulse_sine {0} {0} {0} {"/pulseDist"}
	addmsg /pulseSoma {cellpath}/soma INJECT output
	addmsg /pulseDist {cellpath}/p2b2[3] INJECT output
end

function setupCurrentInjection_50comp
	create funcgen /pulseSoma
	create funcgen /pulseDist
	setpulse_sine {0} {0} {0} {"/pulseSoma"}
	setpulse_sine {0} {0} {0} {"/pulseDist"}
	addmsg /pulseSoma {cellpath}/soma INJECT output 
	addmsg /pulseDist {cellpath}/p2b2[15] INJECT output
end

function setupCurrentInjection_98comp
	create funcgen /pulseSoma
	create funcgen /pulseDist
	setpulse_sine {0} {0} {0} {"/pulseSoma"}
	setpulse_sine {0} {0} {0} {"/pulseDist"}
	addmsg /pulseSoma {cellpath}/soma INJECT output
	addmsg /pulseDist {cellpath}/p2b2[31] INJECT output
end

function setupCurrentInjection_GP_full
	create funcgen /pulseSoma
	create funcgen /pulseDist
	setpulse_sine {0} {0} {0} {"/pulseSoma"}
	setpulse_sine {0} {0} {0} {"/pulseDist"}
	addmsg /pulseSoma {cellpath}/soma INJECT output
	addmsg /pulseDist {cellpath}/p2b2b1b1[46] INJECT output
end



