# ElectricConduction

## Description

This kernel implements the Ohmic conduction term in the current continuity equation, representing current flow driven by electric potential gradients according to Ohm's law.

The contribution to the weak form residual is:
\begin{equation}
- \int \frac{1}{\rho} \nabla V \cdot \nabla \phi d\Omega
\end{equation}

where:
- $\rho$ is the electrical resistivity (Ω·m)
- $V$ is the electric potential (V)
- $\phi$ is the test function
- $1/\rho = \sigma$ is the electrical conductivity (S/m)

This represents the classical Ohm's law current density contribution: $\vec{J} = -\sigma \nabla V$.


!syntax parameters /Kernels/ElectricConduction

!syntax inputs /Kernels/ElectricConduction

!syntax children /Kernels/ElectricConduction
