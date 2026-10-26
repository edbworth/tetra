# TEJouleHeat

## Description

This kernel implements the Joule heating term in the heat equation. Joule heating (also called resistive or ohmic heating) is the process by which electric current flowing through a resistive material generates heat due to energy dissipation.

The contribution to the weak form residual is:
\begin{equation}
\int \nabla V \cdot \vec{J} \phi d\Omega
\end{equation}

where:
- $V$ is the electric potential (V)
- $\vec{J}$ is the current density vector (A/m²)
- $\phi$ is the test function

This represents the Joule heating power density: $q_J = \vec{J} \cdot \vec{E} = -\vec{J} \cdot \nabla V = \rho |\vec{J}|^2$, where $\rho$ is the electrical resistivity. The energy dissipated by electrical resistance appears as heat in the material.


!syntax parameters /Kernels/TEJouleHeat

!syntax inputs /Kernels/TEJouleHeat

!syntax children /Kernels/TEJouleHeat
