//identical to full model parameters specified in file of the same name in the full model directory

int activeSomaAxon = 1
int activeDendrites = 1
float dendNaF = 40

if ({activeSomaAxon} == 1)
	//see notes of 3/10/09
	//Voltage-gated ion channel densities
	float G_NaF_soma  	= 2500
	float G_NaP_soma  	= 1
	float G_Kv2_soma  	= 320
	float G_Kv3_soma  	= 640
	float G_Kv4f_soma 	= 160
	float G_Kv4s_soma 	= {G_Kv4f_soma}*1.5
	float G_KCNQ_soma 	= 0.4
	float G_SK_soma    	= 50
	float G_Ca_HVA_soma   	= 2	
	float G_h_HCN_soma    	= 0.2
	float G_h_HCN2_soma   	= {G_h_HCN_soma}*2.5

	float G_NaF_axon  	= 5000
	float G_NaP_axon  	= 40
	float G_Kv2_axon  	= 640
	float G_Kv3_axon  	= 1280	
	float G_Kv4f_axon 	= 1600
	float G_Kv4s_axon 	= {G_Kv4f_axon}*1.5  
	float G_KCNQ_axon 	= 0.4
else
	float G_NaF_soma  	= 0
	float G_NaP_soma  	= 0
	float G_Kv2_soma  	= 0
	float G_Kv3_soma  	= 0
	float G_Kv4f_soma 	= 0
	float G_Kv4s_soma 	= 0
	float G_KCNQ_soma 	= 0
	float G_SK_soma    	= 0
	float G_Ca_HVA_soma   	= 0	
	float G_h_HCN_soma    	= 0
	float G_h_HCN2_soma   	= 0

	float G_NaF_axon  	= 0
	float G_NaP_axon  	= 0
	float G_Kv2_axon  	= 0
	float G_Kv3_axon  	= 0	
	float G_Kv4f_axon 	= 0
	float G_Kv4s_axon 	= 0
	float G_KCNQ_axon 	= 0
end

if ({activeDendrites} == 1)
	float G_NaF_dend = {dendNaF}
	if ({dendNaF} > 0)
		float G_NaP_dend = 1
	else
		float G_NaP_dend = 0
	end
	float G_Kv2_dend  	= 64
	float G_Kv3_dend  	= 128	
	float G_Kv4f_dend 	= 160
	float G_Kv4s_dend 	= {G_Kv4f_dend}*1.5
	float G_KCNQ_dend 	= 0.4
	float G_SK_dend    	= 4
	float G_Ca_HVA_dend   	= 0.15	
	float G_h_HCN_dend    	= 0.2
	float G_h_HCN2_dend   	= {G_h_HCN_dend}*2.5
else
	float G_NaF_dend 	= 0 
	float G_NaP_dend 	= 0
	float G_Kv2_dend  	= 0
	float G_Kv3_dend  	= 0	
	float G_Kv4f_dend 	= 0
	float G_Kv4s_dend 	= 0
	float G_KCNQ_dend 	= 0
	float G_SK_dend    	= 0
	float G_Ca_HVA_dend   	= 0	
	float G_h_HCN_dend    	= 0
	float G_h_HCN2_dend   	= 0
end


