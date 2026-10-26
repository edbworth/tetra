# PeltierHeat

## Description

This kernel implements the combined Peltier-Thomson heat transport effects. The Peltier effect describes heat carried by electric current, while the Thomson effect describes heating/cooling when current flows through a temperature gradient.

The contribution to the weak form residual is:
\begin{equation}
- \int ST \vec{J} \cdot \nabla \phi d\Omega
\end{equation}

This formulation computes $-\nabla \cdot (\Pi \vec{J})$ where the Peltier coefficient $\Pi = ST$ (first Kelvin relation). The divergence form automatically includes both effects:

- **Peltier effect**: Heat transport proportional to current density
- **Thomson effect**: The divergence expansion yields $\nabla \cdot (ST \vec{J}) = ST \nabla \cdot \vec{J} + \vec{J} \cdot \nabla(ST)$. When $\Pi = ST$ varies with temperature, $\vec{J} \cdot \nabla(ST)$ produces the Thomson heating $\tau \vec{J} \cdot \nabla T$ where $\tau = T \frac{dS}{dT}$ (second Kelvin relation).

Parameters:
- $S$ is the Seebeck coefficient (V/K)
- $T$ is the temperature (K)
- $\vec{J}$ is the current density vector (A/m²)
- $\phi$ is the test function

**Note:** When the Seebeck coefficient is temperature-independent, the Thomson coefficient $\tau = 0$ and only the Peltier effect contributes.


!syntax parameters /Kernels/PeltierHeat

!syntax inputs /Kernels/PeltierHeat

!syntax children /Kernels/PeltierHeat
