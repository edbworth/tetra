[StochasticTools]
  
[]

[Distributions]
  [T_infinity]
    type = Uniform
    lower_bound = 273.15
    upper_bound = 1273.15
  []
[]

[Samplers]
  [monte_carlo]
    type = MonteCarlo
    num_rows = 100
    distributions = 'T_infinity'
  []
[]

[MultiApps]
  [pleg_cuboid]
    type = SamplerFullSolveMultiApp
    input_files = 'pleg_cuboid2.i'
    sampler = monte_carlo
  []
[]

[Transfers]
  [parameters]
    type = SamplerParameterTransfer
    to_multi_app = pleg_cuboid
    sampler = monte_carlo
    parameters = 'Functions/T_inf_func/value'
  []
  [results]
    type = SamplerReporterTransfer
    from_reporter = 'P_load/value I_out/value T_cold/value'
    stochastic_reporter = results
    sampler = monte_carlo
    from_multi_app = pleg_cuboid
  []
[]

[Reporters]
  [results]
    type = StochasticReporter
  []
  [stats]
    type = StatisticsReporter
    reporters = 'results/results:P_load:value results/results:I_out:value results/results:T_cold:value'
    compute = 'mean stddev'
    ci_method = 'percentile'
    ci_levels = '0.05 0.95'
  []
[]

[Outputs]
  execute_on = 'FINAL'
  [out]
    type = JSON
  []
[]