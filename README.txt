The full model code resides in the commonGPFull directory while the
reduced model code (for all reduced models) resides in the
commonGPRedu directory.  All parameter sets used in the article are
stored in the parameter sets directory (including the random parameter
sets used in Figure 9).  Simulation scripts reside in the
scripts/genesisScripts directory.  Relative path order is important to
preserve for the proper functioning of the scripts.

Scripts used to generate the data for the paper (* --> insert the name
of the model you're interested in):

Passive data for Fig. 2 --> passive_GP1axonless_*.g

MockAP data for Fig. 3 --> passive_GP1axonless_*_mock_actionPotential.g

Active responses to somatic injection for Fig. 4, Fig. 5, Fig. 6,
Fig. 10, Supp. Fig. S1, Supp. Fig. S2, and Supp. Fig. S4 -->
genesis_GP1axonless_*.g

Dendritic injection responses for Fig. 6, Fig. 7, Fig. 10, and
Supp. Fig. S4 --> GP1axonless_*_distp200only.g

Synaptic response data for Fig. 8, Fig. 9, and Supp. Fig. S5 are
called GP1axonless_*_synaptic.g

Dendritic spike initiation data shown in Supp. Fig. 3 are called
GP1axonless_*_dendSpikeInit.g

To change parameter values for the reduced models, edit actpars.g in
the reduced model code directory.  Likewise, to change full model
parameter values, edit actpars.g in the full model code directory.
