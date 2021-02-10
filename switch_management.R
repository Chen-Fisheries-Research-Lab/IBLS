#############################################################
## Switch_management
## This script helps choose running scenarios
## The scenarios include base case run/ tunning/ projection
#############################################################

ModelFunctionSwitch=1
# 1: Historical simulation
# 2: Tune model
# 3.1: Calculate biological reference points using ad hoc approach
# 3.2: Calculate biological reference points using theoretical approach
# 4: Future projection simulation

#if you select ModelFunction 3(theoretical BRP) or 4 and do not want to repeat the Historical simulation run, turn on the following switch. In any case, the model will save the Historical simulation results. 

HistoricalSimulationYesNo=0
# 0: yes, rerun the historical simulation
# 1: no, do not rerun the historical simulation. Load the previous run

PlotSwitch=1
# Set to 3 when running functions other than Historical simulation 
# 0: Plot the summary results for each time step and size class during the simulation
# 1: Plot the summary results by time step and year at the end of the simulation only
# 2: Plot both options 0 and 1
# 3: No summary plots (plots of reference points and projections are still produced)

source('Simulation.R')
