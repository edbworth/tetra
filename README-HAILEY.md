Authored by Hailey Tran-Kieu
Created on July 16, 2026



Please refer below for information on the contents of this TETRA folder!




**convergence-study**
This folder contains files for conducting a mesh convergence study to compare the MOOSE model to the analytical solution outlined in the paper by Guillen & Charlot (see Equations 25 & 26).




**te-optimization**
Contains my attempt at running a Parameter sweep stochastic tools study on Example_1 Case. I was able to successfully run it locally.




**validation**
This folder contains the validation studies found in Section 4 of the paper by Guillen & Charlot. 

    Section     Folder          Contents
    ---------------------------------------------------------------------------------------
    4.1         TEM             Mesh convergence study
    4.1         chen_paper      A single thermoelectric module
    4.2         exhaust_pipe    Multiple thermoelectric modules to cool an exhaust duct




**verification**
This folder contains the Comsol/Jaegle verification studies where the input files were edited. You will find the anisotropic thermal expansion coefficient implementation here (see table below). The folders named 0_new-runs within each Example_# folder contain the results for each version of TEJouleHeat.C with and without the negative temperature check from ThermalElectricMaterial.C.

    Section     Folder          Contents
    ---------------------------------------------------------------------------------------
    3.1.1       Example_1       Single leg as a cooler (Steady-state)
    3.1.1       Example_2       Single leg as a cooler (Transient, varied current)
    3.1.2       Example_3       Single leg as a generator
    3.2         Example_5       Thermoelectric couple with anisotropic thermal expansion (see module_cuboid_aniso.i)