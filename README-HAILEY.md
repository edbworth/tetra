Authored by Hailey Tran-Kieu
Created on July 16, 2026



Please refer below for information on the contents of this TETRA folder!




**convergence-study**
This folder contains files for conducting a mesh convergence study to compare the MOOSE model to the analytical solution outlined in the paper by Guillen & Charlot (see Equations 25 & 26).


**validation**
This folder contains the validation studies found in Section 4 of the paper by Guillen & Charlot. 

    Section     Folder          Contents
    4.1         TEM             Mesh convergence study
    4.1         chen_paper      A single thermoelectric module
    4.2         exhaust_pipe    Multiple thermoelectric modules to cool an exhaust heat pipe


**verification**
This folder contains the Comsol/Jaegle verification studies where the input files were edited. You will find the anisotropic thermal expansion coefficient implementation attempts here. The folders named 0_new-runs within each Example_# folder contain the results for each version of TEJouleHeat.C with and without the negative temperature check from ThermalElectricMaterial.C.