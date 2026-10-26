# SeebeckEnergy

## Description

This kernel implements the Seebeck effect contribution to the current continuity equation. The Seebeck effect causes current flow driven by temperature gradients—charge carriers diffuse from hot to cold regions, creating an electric current even in the absence of an applied voltage.

The contribution to the weak form residual is:
\begin{equation}
- \int \frac{S}{\rho} \nabla T \cdot \nabla \phi d\Omega
\end{equation}

where:
- $S$ is the Seebeck coefficient (V/K)
- $\rho$ is the electrical resistivity (Ω·m)
- $T$ is the temperature (K)
- $\phi$ is the test function

This represents the Seebeck current density contribution: $\vec{J}_{Seebeck} = -\sigma S \nabla T$, where $\sigma = 1/\rho$ is the electrical conductivity. Combined with ElectricConduction, this gives the full thermoelectric current density: $\vec{J} = -\sigma(\nabla V + S \nabla T)$.


!syntax parameters /Kernels/SeebeckEnergy

!syntax inputs /Kernels/SeebeckEnergy

!syntax children /Kernels/SeebeckEnergy
