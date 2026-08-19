pipe_thickness = 2e-3
pipe_outs = 50e-3
TE_size_x = 36.8e-3
TE_size_y = 37.6e-3
TE_spacing = 2e-3
nx_TE = 4
ny_TE = 5


position_file = open('TE_positions.txt', 'w')

for i in range(0, nx_TE):
  x_TE = pipe_thickness + i*(TE_size_x + TE_spacing)
  for j in range(0, ny_TE):
    y_TE = pipe_outs + j*(TE_size_y + TE_spacing)
    position_file.write( '%f, %f, 0 \n' %(x_TE, y_TE))

position_file.close()
