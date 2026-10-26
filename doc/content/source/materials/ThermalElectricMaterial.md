# ThermalElectricMaterial

## Description

This material defines the fundamental thermoelectric properties and their temperature-dependent relationships. It accepts either constant values or temperature-dependent functions for the Seebeck coefficient and electrical resistivity, and automatically computes derived properties.

### Input Properties
- **Seebeck coefficient** ($S$): Can be specified as a constant or temperature function `seebeck_temperature_function`
- **Electrical resistivity** ($\rho$): Can be specified as a constant or temperature function `resistivity_temperature_function`

### Derived Properties

The material automatically computes four additional properties using the Kelvin relations:

1. **Electrical conductivity**: $\sigma = 1/\rho$ (S/m)
   - Property name: `elec_conductivity`
   - Used in current density calculations

2. **Peltier coefficient**: $\Pi = ST$ (V)
   - Property name: `peltier`
   - First Kelvin relation relating Peltier and Seebeck effects
   - Describes heat transported per unit current

3. **Thomson coefficient**: $\tau = T \frac{dS}{dT}$ (V/K)
   - Property name: `thomson`
   - Second Kelvin relation relating Thomson and Seebeck effects
   - Computed automatically when `seebeck_temperature_function` is provided
   - Zero when Seebeck coefficient is temperature-independent
   - Describes heating/cooling when current flows through temperature gradients

### Thermodynamic Consistency

The Kelvin relations ensure thermodynamic consistency between the three thermoelectric effects. Users only need to specify the two independent properties ($S$ and $\rho$), and the material model ensures the Peltier and Thomson coefficients satisfy the thermodynamic relationships automatically.

!syntax parameters /Materials/ThermalElectricMaterial

!syntax inputs /Materials/ThermalElectricMaterial

!syntax children /Materials/ThermalElectricMaterial
