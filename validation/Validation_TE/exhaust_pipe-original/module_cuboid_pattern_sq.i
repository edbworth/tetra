
I = 1.

leg_size = 1.6
connect_height = 0.2


# [GlobalParams]
#   # thermal expansion
#   displacements = 'disp_x disp_y disp_z'
# []

[Mesh]
  # parallel_type = DISTRIBUTED
  [mesh]
    type = FileMeshGenerator
    file = module_cuboid_pattern_mesh_in.e
  []
[]
[Variables]
  [T]
    initial_condition = 400 #in K
  []
  [elec]
    block =  'n_leg 102 202 p_leg 104 204 interconnect_cold 101 103 201 203 interconnect_hot'
  []
[]

[Kernels]
  [HeatDiff]
    type = ADHeatConduction
    variable = T
  []
  [electric]
    type = ElectricConduction
    variable = elec
    block =  'n_leg 102 202 p_leg 104 204 interconnect_cold 101 103 201 203 interconnect_hot'
  []
  [seebeck_effect]
    type = SeebeckEnergy
    variable = elec
    temp =T
    block =  'n_leg 102 202 p_leg 104 204 interconnect_cold 101 103 201 203 interconnect_hot'
  []
  [Peltier_effect]
    type = PeltierHeat
    variable = T
    block =  'n_leg 102 202 p_leg 104 204 interconnect_cold 101 103 201 203 interconnect_hot'
  []
  [HeatSrc]
    type = TEJouleHeat
    variable = T
    current_density = current_density
    elec = elec
    block =  'n_leg 102 202 p_leg 104 204 interconnect_cold 101 103 201 203 interconnect_hot'
  []
[]

[BCs]
   [hot_temp]
    type = CoupledConvectiveHeatFluxBC
    variable = T
    boundary = 'top_plate_front'
    T_infinity = T_fluid
    htc = htc 
  []
  [cold_temp]
    type = CoupledConvectiveHeatFluxBC
    variable = T
    boundary = 'bottom_plate_back'
    T_infinity = 300
    htc = 1e4 
  []
  [elec_right]
    type = ADDirichletBC
    variable = elec
    boundary = plus_BC
    value = 0
  []
  [intensity]
    type = ADNeumannBC
    variable = elec
    boundary = minus_BC
    value = ${fparse -I/(connect_height*leg_size * 1e-6)}
  []

[]
[AuxVariables]
  [T_fluid]
    initial_condition = 400
    # block = 500
  []
  [htc]
    initial_condition = 2e4
    # block = 500
  []
[]

[Functions]
  [Bi2Te3_S_func]
    # Seebeck coefficient [V/K]
    type = ParsedFunction
    expression = '(-6.373e-6 *t*t*t+ 0.00359*t*t - 0.0924 * t +84.605) *1e-6'
  []
  [Bi2Te3_S_func_n]
    # Seebeck coefficient [V/K]
    type = ParsedFunction
    expression = '(-6.373e-6 *t*t*t+ 0.00359*t*t - 0.0924 * t +84.605) *1e-6* -1'
  []
  [Bi2Te3_R_func] 
    # Electrical resistivity [Ohm*m]
    type = ParsedFunction
    expression = '(-1.263e-7 *t*t*t + 1.327e-4 * t *t -0.0376 * t + 3.838) *1e-5'
  []
  [Bi2Te3_k_func] 
    # Thermal conductivity [W/(m*K)]
    type = ParsedFunction
    expression = '(3.2e-5 * t *t -0.0216 * t + 4.949)'
  []
[]


[Materials]
  [J_mat]
    type = CurrentDensityMaterial
    temp = T
    elec = elec
    block =  'n_leg 102 202 p_leg 104 204 interconnect_cold 101 103 201 203 interconnect_hot'
  []
  [nleg_thermal]
    type = ADHeatConductionMaterial
    temperature = T
    thermal_conductivity_temperature_function = Bi2Te3_k_func
    specific_heat_temperature_function = 188.6    # [J/(kg*K)]
    block = 'n_leg 102 202'
  []
  [pleg_thermal]
    type = ADHeatConductionMaterial
    temperature = T
    thermal_conductivity_temperature_function = Bi2Te3_k_func
    specific_heat_temperature_function = 188.6    # [J/(kg*K)]
    block = 'p_leg 204 104'
  []

  [pleg]
    # Setup a material that will provide varying Seebeck coefficients with changing temperature
    type = ADThermalElectricMaterial
    temp = T
    seebeck_temperature_function =Bi2Te3_S_func
    resistivity_temperature_function = Bi2Te3_R_func
    block = 'p_leg 104 204'
    # outputs = exodus
    # output_properties = 'seebeck'
  []
  [nleg]
    # Setup a material that will provide varying Seebeck coefficients with changing temperature
    type = ADThermalElectricMaterial
    temp = T
    seebeck_temperature_function = Bi2Te3_S_func_n
    resistivity_temperature_function = Bi2Te3_R_func
    block = 'n_leg 102 202'
    # outputs = exodus
    # output_properties = 'seebeck'
  []
  [interconnect_th]
    # Copper
    type = ADHeatConductionMaterial
    temperature = T
    thermal_conductivity = 387.6    # W/mK
    specific_heat = 385             # J/kgK
    block =  'interconnect_cold 101 103 201 203 interconnect_hot'
  []
  [interconnect_TE]
    type = ADThermalElectricMaterial
    temp = T
    seebeck_temperature_function = 0
    resistivity_temperature_function = 1.75e-8  # Electrical resistivity [Ohm*m]
    block =  'interconnect_cold 101 103 201 203 interconnect_hot'
  []
  [plates]
    # Setup a material that will provide varying Seebeck coefficients with changing temperature
    type = ADThermalElectricMaterial
    temp = T
    seebeck_temperature_function = 0
    resistivity_temperature_function = 1e12           # Electrical Resistivity [Ohm*m]
    block = '500 600'
    # outputs = exodus
    # output_properties = 'seebeck'
  []
  [plates_thermal]    # Material is alumina
    type = ADHeatConductionMaterial
    temperature = T
    thermal_conductivity = 29   # Thermal conductivity [W/(m*K)]
    specific_heat = 850         # Specific heat capacity [J/(kg*K)]
    block = '500 600'
  []
[]

[Postprocessors]
  [Vmin]
    type = SideAverageValue
    boundary = minus_BC
    variable = elec
  []
  [Vmax]
    type = SideAverageValue
    boundary = plus_BC
    variable = elec
  []
  [U_load]
    type = ParsedPostprocessor
    pp_names = 'Vmax Vmin'
    expression = 'Vmax - Vmin'
  []

  [heat_in]
    type = ADSideDiffusiveFluxIntegral
    variable = T
    diffusivity = thermal_conductivity
    boundary = 'top_plate_front'
  []
  [I_out]
    type = ADSideDiffusiveFluxIntegral
    variable = elec
    diffusivity = elec_conductivity
    boundary = 'minus_BC'
  []
  [P_load]
    type = ParsedPostprocessor
    pp_names = 'I_out U_load'
    expression = '-U_load*I_out'
  []

[]

[Preconditioning]
  [SMP]
    type = SMP
    full = true
  []
[]

[Executioner]
  type = Steady
  solve_type = 'NEWTON'
  # line_search = 'none'
  # Serial for Debugging
  petsc_options_iname = '-pc_type -pc_factor_shift_type -pc_factor_shift_amount  '
  petsc_options_value = '       lu         NONZERO               1e-12        '
  # petsc_options_iname = '-pc_type -pc_hypre_type'
  # petsc_options_value = 'hypre     boomeramg'
  # petsc_options_iname = '-pc_type'
  # petsc_options_value = 'lu'
  automatic_scaling = True
  nl_abs_tol = 1e-10

[]

# [Executioner]
#   type = Transient
#   scheme = bdf2
#   # solve_type = NEWTON
#   solve_type = PJFNK
#   # petsc_options_iname = '-pc_type'
#   # petsc_options_value = 'hypre'
#   dt = 1
#   end_time = 10
  # automatic_scaling = true
# []

[Outputs]
  # file_base= 'pattern_sq'
  [out]
    type = Exodus
    output_material_properties = true
  []

  # perf_graph = true
  # file_base = 'GA_results/test'
  # file_base = optimial_post
  csv = true
[]