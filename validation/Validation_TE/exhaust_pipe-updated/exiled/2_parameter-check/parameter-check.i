# This file is to document and keep track of the problem parameters for the exhaust waste gas recovery system

MESHES for TEM, gas_THM, and Pipe MATCH.

Individual TEMs: module_cuboid_pattern_sq.i
Mesh size = 0.2 mm

I = 1               # Current [A]

Convective boundary condition on cold side with T = 300 K and htc = 10000 W/(m^2*K). Cold side is maintained at T = 300 K

Heat conductance on the hot side to couple the exhaust duct to TEM

Geometry and characteristics are identical to those modeled in the emsh convergence study or the Chen paper 

    Changing AuxVariable T_fluid initial condition from 400 K to 600 K did nothing
    Changing AuxVariable htc initial condition from 2e4 to 1e4 decreased P+load and heat_in



    
Gas flow: gas_THM.i 

Type of gas: Air 
Temperature of gas: T = 600 K 
Atmospheric pressure: p = 101325 Pa 
Initial velocity of gas: 100 m/s 
htc is calculated using Dittus-Boelter and friction losses is calculated using Churchill


Exhaust duct: Pipe_only.i 
Duct structure is thermally coupled to the hot gas via convective boundary condition
Dimensions: width = 15.72 cm, height = 6.4 cm, length = 29.6 cm, thickness = 0.2 mm
Spacing of the TEMs: 2 mm 

