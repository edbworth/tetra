import matplotlib.pyplot as plt
import numpy as np
import csv

# Helper function to read CSV files into a dictionary format
def read_csv_file(filepath):
    data = {}
    with open(filepath, mode='r') as file:
        reader = csv.reader(file)
        headers = next(reader)  # Read the first row as headers
        for header in headers:
            data[header] = []  # Initialize empty lists for each column

        for row in reader:
            for i, value in enumerate(row):
                data[headers[i]].append(float(value))  # Convert values to float
    return data

# Case range
cases = range(0, 21)

# Initialize data containers
I = []
T_cold = []
disp = []
disp2 = []

# Process data for MOOSE
for item in cases:
    filename = "results_aniso/I" + str(item).zfill(2) + ".csv"
    filename2 = "results/I" + str(item).zfill(2) + ".csv"

    print(f"Reading file: {filename}")
    print(f"Reading file: {filename2}")

    data = read_csv_file(filename)
    data2 = read_csv_file(filename2)

    disp.append(data['disp'][-1])  # Displacement
    disp2.append(data2['disp'][-1])  # Displacement

    I.append(item / 10.0)  # Current in Amps

    # T_cold.append(-1 * data['delta_T'][-1] + 273.15)  # Convert cold-side temperature to Kelvin
    # T_cold.append(-1 * data['delta_T'][-1] + 273.15)  # Convert cold-side temperature to Kelvin

# Read COMSOL data
# data_comsol_T = read_csv_file('T_cold_comsol.csv')
# data_comsol_disp = read_csv_file('disp_comsol.csv')

data_jaegle_disp = read_csv_file('jaegle_ex5_disp.csv')

# Convert COMSOL temperature to Kelvin
# data_comsol_T['T'] = [temp + 273.15 for temp in data_comsol_T['T']]

# Plot: Cold Side Temperature vs Current
# plt.figure(figsize=(8, 6), dpi = 1000)
# plt.rc('font', family='sans-serif', size=16)  # Increased font size to 16
# ax = plt.subplot(1, 1, 1)
# ax.get_yaxis().get_major_formatter().set_useOffset(False)
# plt.xlabel("Current [A]")
# plt.ylabel("Cold side temperature [K]")  # Updated Y-axis label for Kelvin
# plt.plot(I, T_cold, linewidth=2, linestyle='-', marker='', color='cornflowerblue', label='MOOSE')
# plt.plot(data_comsol_T["I"], data_comsol_T["T"], linewidth=2, linestyle='--', marker='', color='orange', label='COMSOL')
# ax.legend(frameon=False, prop={'size': 16}, loc='upper right')  # Increased legend font size
# plt.tight_layout()
# plt.savefig('figures/T_cold_K.png')  # Updated filename to reflect Kelvin
# plt.close()

# Plot: Displacement vs Current
plt.figure(figsize=(8, 6), dpi = 1000)
plt.rc('font', family='sans-serif', size=20)  # Increased font size to 16
ax = plt.subplot(1, 1, 1)
ax.get_yaxis().get_major_formatter().set_useOffset(False)
plt.xlabel("Current [A]", fontsize=20)
plt.ylabel("Displacement [m]", fontsize=20)
plt.plot(I, disp, linestyle='-', marker='', linewidth=2, color='cornflowerblue', label='MOOSE anisotropic')
plt.plot(I, disp2, linestyle='-', marker='', linewidth=2, color='red', label='MOOSE isotropic')
plt.plot(data_jaegle_disp["I"], data_jaegle_disp["disp"], linewidth=2, linestyle='--', marker='', color='orange', label='COMSOL')

ax.legend(frameon=False, prop={'size': 20})  # Increased legend font size
ax.tick_params(axis='both', labelsize=20)
plt.grid(alpha=0.4)
# ax.set_xlim([0.0, 2.0])
ax.set_xlim([0.25, 1.25])
# ax.set_ylim([-6e-6, 4e-6])
ax.set_ylim([-6e-6, -4e-6])
plt.tight_layout()
plt.savefig('disp_font_comparison.png')  # Displacement plot filename remains unchanged
plt.close()


# Calculate RMSE
from scipy.interpolate import interp1d

interpolated_aniso = interp1d(I, disp, kind="quadratic", fill_value="extrapolate")
interpolated_aniso_values =  interpolated_aniso(data_jaegle_disp["I"])

interpolated_iso = interp1d(I, disp2, kind="quadratic", fill_value="extrapolate")
interpolated_iso_values =  interpolated_iso(data_jaegle_disp["I"])

rmse_disp_jaegle_aniso = np.sqrt(np.mean((data_jaegle_disp["disp"] - interpolated_aniso_values) ** 2))
rmse_disp_jaegle_iso = np.sqrt(np.mean((data_jaegle_disp["disp"] - interpolated_iso_values) ** 2))

range_comsol = max(data_jaegle_disp["disp"]) - min(data_jaegle_disp["disp"])

norm_aniso = (rmse_disp_jaegle_aniso / range_comsol) * 100
norm_iso = (rmse_disp_jaegle_iso / range_comsol) * 100

print("----------------------------")
print("RMSE wrt Jaegle COMSOL")
print("----------------------------")
print("MOOSE anisotropic: Raw = ", f"{rmse_disp_jaegle_aniso:.4e}", ", Normalized = ", round(norm_aniso, 4))
print("MOOSE isotropic: Raw = ", f"{rmse_disp_jaegle_iso:.4e}", ", Normalized = ", round(norm_iso, 4))