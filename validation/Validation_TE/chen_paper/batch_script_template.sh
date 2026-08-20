#!/bin/bash
# Submits one SLURM job per MOOSE simulation.
# Each job runs independently on its own set of nodes.
# Usage: bash run_power_batch.sh

# Paths
SIM_DIR="/projects/USU/Thermoelectric-Hailey/tetra-test/tetra/validation/Validation_TE/chen_paper"         # "/projects/WTP/Zach/HLW/momentum_source/viscosity-flowrate-paramstudy"
MACRO="${SIM_DIR}/MST_MRC_paramstudy.java"


CURRENT=(1.6, 1.7, 1.8, 1.9, 2.0, 2.1, 2.2, 2.3, 2.4, 2.5)

# Simulation file list
SIM_FILES=(
    #"HLW_T7_abboud_MRC_nu1.sim"
    #"HLW_T7_abboud_MRC_nu2.sim"
    #"HLW_T7_abboud_MRC_nu333e-2.sim"
    #"HLW_T7_abboud_MRC_nu5.sim"
    #"HLW_T7_abboud_MRC_nu75e-1.sim"
    #"HLW_T7_abboud_MRC_nu10.sim"
    #"HLW_T7_abboud_MRC_Q12.sim"
    "HLW_T7_abboud_MRC_Q15.sim"
    "HLW_T7_abboud_MRC_Q18.sim"
    "HLW_T7_abboud_MRC_Q22.sim"
)




# Submit one job per simulation
for SIM in "${SIM_FILES[@]}"; do
    SIM_NAME="${SIM%.sim}"   # strip .sim extension for job name
    SIM_PATH="${SIM_DIR}/${SIM}"

    sbatch <<EOF
#!/bin/bash

#SBATCH --time=00:10:00
#SBATCH --ntasks-per-node=112
#SBATCH --nodes=1
#SBATCH --wckey melter
#SBATCH -J "${SIM_NAME}"
#SBATCH --mail-user=zachary.diermyer@inl.gov
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --output=${SIM_DIR}/${SIM_NAME}_%j.log
#SBATCH --error=${SIM_DIR}/${SIM_NAME}_%j.err

echo "Starting job for ${SIM_NAME} on \$(hostname) at \$(date)"

module load star-ccm-plus

starccm+ \
    -batch ${MACRO} \
    -np 28 \
    ${SIM_PATH}

echo "Finished job for ${SIM_NAME} at \$(date)"
EOF

    echo "Submitted job for ${SIM_NAME}"
done