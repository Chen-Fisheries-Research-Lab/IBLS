# IBLS
An individual-based lobster simulator (IBLS) that allows users to simulate the Gulf of Maine (GOM) American lobster fishery. The IBLS was developed by Chen et al. (2005) to test the performance of the stock assessment model, further developed by Chang (2015) for management evaluation, and modified and parameterized for the GOM lobster fishery by Mazur et al. (2018). An individual-based model was used to develop the IBLS for the GOM lobster ﬁshery by expressing numerous components of the model equations as random Bernoulli trials (Chen et al. 2005; Chang 2015; Mazur et al. 2018). Insteadofcalculatingthe number of lobsters that survive a given process such as natural mortality or ﬁshing mortality, we simulate natural or ﬁshing mortality acting on Nt individual lobsters (Mazur et al. 2018). 

![](Figure%201.png)

# Input
The IBLS requires abundance, recruitment, and other types of data (Table 1). Most of the probabilities and other input data are from the stock assessment data (ASMFC 2015), but fishing effort data are from the Maine Department of Marine Resources (DMR) harvester data, and V-notching information is from personal communication with managers (Table 1).These are the best available data representing the GOM lobster fishery dynamics.

![](Table1.png)

Input files include:
BRPControl.xlsx
EncounterRate.csv
LifeHistoryControl.xlsx
ManagementControl.xlsx
MoltIncrement.csv
MoltProb.csv
ProjectionControlGeneralSetting.xlsx
ProjectionControlScenario1.xlsx
Switches.xlsx
TunningControl.xlsx

# State variables and scales
Individual lobsters are characterized by the state variables size (carapace length (CL) in millimetres), sex, maturity status, egg status, survival status (if the lobster is alive or dead because of either fishing or natural mortality), and V-notch presence. The current historical temporal range is from the years 1982 to 2013 following the 2015 benchmark American lobster stock assessment (ASMFC 2015). However, this will need to be updated to 1982 to 2018 following the most recent American lobster stock assessment (ASMFC 2020). The spatial extent is the GOM lobster stock area (Fig. 2). The model has four time steps: winter (January–March), spring (April–June), summer (July–September), and fall (October–December).

![](Figure%202.png)

# Output
Some output include (LobstaRecord.txt and LobstaRecordDie.txt; only output if individual output is switched on) and summary statistics (LobstaRecordSummary.txt). The columns of individual records include ID (individual unique id), Type (1-first come in to the model; 2-remainders), sex (0 – female; 1 – male), timestep (simulation time step), lenght (lobster CL in mm), bin (size class bin number), mature counter (how many time steps since the last molt; used when LSwitch2=0), No molt counter (molt duration), v-notch counter (number of time steps lobster has v-notch), egg counter (number of time steps lobster has kept eggs), egg time step (time step the lobster became berried), molt number (total
number lifetime molts), die information (#0: default, #1: death due to natural mortality, #3: death due to fishery, #4: death due to handling mortality, #5: death due to molting mortality), v-notch information (#0: default, #1: caught v-notch lobster, #2: lobster got v-notch at this time step), fishery recruitment information (#0: default, #1: recruited at this time step), molt increment information (molt increment), molt time step (the time step lobster molts), area (which area the lobster is in at this time step), MPA (0 - inside MPA; 1 – outside MPA), and fishery (which fishery, if any, the lobster has encountered).

