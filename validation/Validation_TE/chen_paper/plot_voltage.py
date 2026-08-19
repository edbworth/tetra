import matplotlib.pyplot as plt
import numpy as np
from thm_utilities import readCSVFile
import subprocess
# from subprocess import check_output
import os


# expr_BiSbTeSe = read_csv_file('chen_data/expr_BiSbTeSe.csv')
expr_BiTe = readCSVFile('chen_data/expr_BiTe.csv')
# sim_BiSbTeSe = read_csv_file('chen_data/sim_BiSbTeSe.csv')
sim_BiTe = readCSVFile('chen_data/sim_BiTe.csv')


temperature = [325, 350, 375, 400, 425, 450, 475, 500]
temp_diff = []
voltage=[]

for t in temperature:

   base = 'temperature/temp_' + str(t)
   result_name = base +".csv"
   data = readCSVFile(result_name)
   temperature_diff = t - 300
   temp_diff.append(temperature_diff)
   voltage.append(data['U_load'][-1])


plt.figure(figsize=(8, 6))
plt.rc('font', family='sans-serif', size=14)
ax = plt.subplot(1, 1, 1)
ax.get_yaxis().get_major_formatter().set_useOffset(False)
plt.ylabel("Open-circuit Voltage [V]", fontsize=22)
plt.xlabel("Temperature Difference [T]", fontsize=22)



plt.plot(temp_diff, voltage, marker='', color='green', linewidth=3, label='MOOSE')
plt.plot(sim_BiTe['T'], sim_BiTe['V'], label='Simulation - Chen et al.', color='orange', linewidth=3)
plt.plot(expr_BiTe['T'], expr_BiTe['V'], marker='s', markersize=10, linestyle="", label='Experiment', color='cornflowerblue')

ax.legend(frameon=False, prop={'size':20})
ax.tick_params(axis='both', labelsize=20)
plt.tight_layout()
# plt.grid(alpha=0.4)
plt.savefig('TEM_open_circuit_voltage.png', dpi=1000)



# Calculate RMSE

from scipy.interpolate import interp1d

interpolated_sim = interp1d(sim_BiTe['T'], sim_BiTe['V'], kind="linear", fill_value="extrapolate")
interpolated_sim_values = interpolated_sim(expr_BiTe['T'])

interpolated_moose = interp1d(temp_diff, voltage, kind="linear", fill_value="extrapolate")
interpolated_moose_values = interpolated_moose(expr_BiTe['T'])

rmse_sim = np.sqrt(np.mean((expr_BiTe['V'] - interpolated_sim_values) ** 2))
rmse_moose = np.sqrt(np.mean((expr_BiTe['V'] - interpolated_moose_values) ** 2))

range_expr = expr_BiTe['V'].max() - expr_BiTe['V'].min()

norm_rmse_sim = (rmse_sim / range_expr) * 100
norm_rmse_moose = (rmse_moose / range_expr) * 100

print("-------------------------------")
print("RMSE wrt Experimental Results:")
print("-------------------------------")
print("Chen et al. simulation: Raw = ", round(rmse_sim, 4), 'Normalized = ', round(norm_rmse_sim, 4))
print("MOOSE simulation: Raw = ", round(rmse_moose, 4), "Normalized = ", round(norm_rmse_moose, 4))