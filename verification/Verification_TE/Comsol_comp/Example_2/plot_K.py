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

# Read data from CSV files
data = read_csv_file('pleg_cuboid_tr_csv.csv')
data_comsol_T = read_csv_file('ex2.csv')

# Convert temperatures from Celsius to Kelvin
data['T_cold'] = [temp for temp in data['T_cold']]  # MOOSE temperature in Kelvin
data_comsol_T['T'] = [temp for temp in data_comsol_T['T']]  # COMSOL temperature in Kelvin

# Plot setup
plt.figure(figsize=(12, 8), dpi=1000)
plt.rc('font', family='sans-serif', size=22)
ax = plt.subplot(1, 1, 1)
ax.get_yaxis().get_major_formatter().set_useOffset(False)
plt.xlabel("Time [s]", fontsize=22)
plt.ylabel("Cold side temperature [K]", fontsize=22)  # Updated Y-axis label for Kelvin

# Plot data
plt.plot(data['time'], data['T_cold'], linestyle='-', marker='', color='cornflowerblue')  # MOOSE data
plt.plot(data_comsol_T["time"], data_comsol_T["T"], linestyle='--', color='orange')  # COMSOL data

# Add legend
ax.legend(['MOOSE', "COMSOL"], frameon=False, prop={'size': 22}, loc='lower right')
# plt.grid() # Tran-Kieu: Added 6/29/2026 

# Finalize and save plot
ax.tick_params(axis='both', labelsize=20)
# plt.xlim(0, 20) # Tran-Kieu: Added 6/29/2026 
plt.ylim(215, 222) # Tran-Kieu: Added 6/29/2026 
plt.tight_layout()
plt.savefig('T_cold_K.png')  # Updated filename to reflect Kelvin
plt.close()
