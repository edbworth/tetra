import matplotlib.pyplot as plt
import numpy as np
from thm_utilities import readCSVFile

I = []
Volt = []
power=[]
position_file = open('TE_positions.txt')
y=[]
z=[]
# plt.figure(figsize=(8, 6))
# plt.rc('font', family='sans-serif', size=14)
# ax = plt.subplot(1, 1, 1)
# ax.get_yaxis().get_major_formatter().set_useOffset(False)
for (i, position) in enumerate(position_file.readlines()):

   y.append(float(position.split(', ')[0]) + 0.02)
   z.append(float(position.split(', ')[1])+0.02)
   result_name = "Pipe_only_out_TE"+str(i).zfill(2)+".csv"
   print(result_name)
   data = readCSVFile(result_name)
#    # disp.append(data['disp'][-1])
#    I.append(item/100.)
   I.append(-1 *data['I_out'][-1])
   Volt.append(data['U_load'][-1])
   power.append(data['P_load'][-1])


f, ax = plt.subplots(figsize=(8.5, 8.2))
ax.set_xlim([0,0.16] )
ax.set_ylim([0.05,0.25] )
plt.rc('font', family='sans-serif', size=22)
points = ax.scatter(y, z, c=power, s=9000, marker="s", cmap="viridis")

f.colorbar(points, label = 'Power [W]')

plt.axis('off')
plt.tight_layout()
plt.savefig('power.png', dpi=1000)

print(np.sum(power))


