# CurrentDensityMaterial

## Description

This material computes the thermoelectric current density vector field $\vec{J}$ including both Ohmic conduction and Seebeck effect contributions.

The current density is calculated as:
\begin{equation}
 \vec{J} = - \frac{1}{\rho} (\nabla V + S \nabla T)
\end{equation}

This can also be written as $\vec{J} = -\sigma (\nabla V + S \nabla T)$ where $\sigma = 1/\rho$ is the electrical conductivity.

### Physical Interpretation

The current density has two contributions:
- **Ohmic term** ($-\sigma \nabla V$): Current driven by electric potential gradients (Ohm's law)
- **Seebeck term** ($-\sigma S \nabla T$): Current driven by temperature gradients (Seebeck effect)

In a thermoelectric device, both mechanisms operate simultaneously, allowing electrical and thermal energy to be directly converted.

### Required Inputs
- $V$ (`elec`): Electric potential (V)
- $T$ (`temp`): Temperature (K)
- $S$ (`seebeck`): Seebeck coefficient from material model (V/K)
- $\rho$ (`resistivity`): Electrical resistivity from material model (Ω·m)

### Output Property
- `current_density`: Vector field in A/m²


!syntax parameters /Materials/CurrentDensityMaterial

!syntax inputs /Materials/CurrentDensityMaterial

!syntax children /Materials/CurrentDensityMaterial
