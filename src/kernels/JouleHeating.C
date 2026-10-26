#include "JouleHeating.h"

registerMooseObject("TetraApp", JouleHeating);

InputParameters
JouleHeating::validParams()
{
  InputParameters params = ADKernelValue::validParams();
  params.addClassDescription("Compute the joule heating : "
                             "-$ \\sigma \\nabla u \\cdot \\nabla u \\phi $");
  params.addRequiredCoupledVar("elec", "Electrostatic potential for joule heating.");

  return params;
}

JouleHeating::JouleHeating(const InputParameters & parameters)
  : ADKernelValue(parameters),

    _grad_elec(adCoupledGradient("elec")),
    _resistivity(getADMaterialProperty<Real>("resistivity"))
{
}

ADReal
JouleHeating::precomputeQpResidual()
{
  return -(1 / _resistivity[_qp]) * _grad_elec[_qp] * _grad_elec[_qp];
}
