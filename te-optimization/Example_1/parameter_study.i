[ParameterStudy]
  input = pleg_cuboid2.i
  parameters = 'BCs/cold_temp/Tinfinity'
  quantities_of_interest = 'P_load/value I_out/value T_cold/value'

  sampling_type = LHS
  num_samples = 100
  distributions = 'normal'
  normal_mean = 475
  normal_standard_deviation = 25
[]