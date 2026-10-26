!config navigation breadcrumbs=False scrollspy=False

# TETRA

## ThermoElectric Transport and Response Analysis

This MOOSE-based application is used to solve the coupled current continuity and heat conduction equations in the presence of Seebeck, Peltier, and Thomson effects.

## Physical Background

Thermoelectric effects couple electrical current and heat transport in materials. Three fundamental effects govern this coupling:

### Seebeck Effect
When a temperature gradient exists in a conductor, charge carriers diffuse from hot to cold regions, creating an electric potential difference. The Seebeck coefficient $S$ (V/K) quantifies this effect: $\Delta V = -S \Delta T$.

### Peltier Effect
When electric current flows through a conductor, it carries heat proportional to the current density. The Peltier coefficient $\alpha_P$ or $\Pi$ (V) describes the heat transported per unit current.

### Thomson Effect
When current flows through a region with a temperature gradient, additional heating or cooling occurs due to the temperature-dependence of the Seebeck coefficient. The Thomson coefficient $\alpha_{Th}$ or $\tau$ (V/K) characterizes this effect.

## Governing Equations

The weak form of the heat conduction equation is:
\begin{equation}
    \int_\Omega k \vec{\nabla} T \cdot  \nabla \phi~d\Omega
     -  \int_\Omega ST \vec{J} \cdot  \nabla \phi~d\Omega+ \int_\Omega q_J \phi~d\Omega  + \int_\Gamma  \left(-k\vec{\nabla} T + ST \vec{J} \right) \cdot \vec{n}~d\Gamma = 0
\end{equation}
The weak form of the current continuity equation is:
\begin{equation}
      - \int_\Omega \sigma \vec{\nabla} V \cdot  \vec{\nabla}\phi~d\Omega    -  \int_\Omega \sigma S \vec{\nabla} T \cdot  \vec{\nabla}~d\Omega
      + \int_\Gamma\sigma \left(  \vec{\nabla} V + S\vec{\nabla} T\right)\cdot \vec{n}~d\Gamma = 0
\end{equation}

### Physical Interpretation

The **heat conduction equation** includes:
- $k \vec{\nabla} T$: Classical Fourier heat conduction
- $-ST \vec{J}$: Combined Peltier-Thomson heat transport (using $\Pi = ST$)
- $q_J$: Joule heating from electrical resistance, $q_J = \vec{J} \cdot \vec{E} = -\vec{J} \cdot \vec{\nabla}V$

The **current continuity equation** includes:
- $-\sigma \vec{\nabla} V$: Ohmic conduction
- $-\sigma S \vec{\nabla} T$: Seebeck-driven current due to temperature gradients

where $\sigma$ is the electrical conductivity (S/m), $\rho$ is the electrical resistivity (Ω·m) with $\sigma = 1/\rho$, $V$ is the electric potential (V), $T$ is temperature (K), $\vec{J}$ is current density (A/m²), and $S$ is the Seebeck coefficient (V/K).
