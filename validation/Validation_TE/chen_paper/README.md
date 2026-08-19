Authored by Hailey Tran-Kieu
Created on July 15, 2026


**run_batch_power.sh**
This is a bash script to run multiple SLURM scripts that run the *module_cuboid_pattern_sq.i* input file at varying currents. RUN this in the terminal and then run *plot_power_batch.py* to plot the Power vs. Current figure (see *TEM_power_batch.png*).

**run_batch_temp.sh**
Runs the *module_cuboid_pattern_sq.i* input file at varying temperature differences between the hot and cold side. The cold side is maintained at 300 K, but the hot side gradualyl increases from 325 K to 500 K. The .csv and .e files are outputted into the *temperature* folder.

**plot_voltage.py**
Plots the open-circuit voltage vs. temperature difference plot.

**chen_data**
Redigitized data from Chen et al. Used in plotting the open-circuit voltage vs. temperature difference plot. See *TEM_open_circuit_voltage.png*.



Extra stuff:

**flow_coupling** and **flow_coupling_I** 
These cases are to test simulating 3D gas flow using the Navier Stokes Physics capabilities briefly mentioned in the paper by Guillen & Charlot. The study conducted in Guillen & Charlot only implements 1D gas flow approximation. These two folders have essentially the same input files EXCEPT one has the current set at 0 A and the other has the current set at 0.5 A, respectively. The *flow_coupling_I* folder also has a SLURM script.