#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH -t 10:00
#SBATCH -J Ex5
#SBATCH --mail-type=ALL

echo '-------------------------------'
cd ${SLURM_SUBMIT_DIR}
echo ${SLURM_SUBMIT_DIR}
echo Running on host $(hostname)
echo Time is $(date)
echo SLURM_NODES are $(echo ${SLURM_NODELIST})
echo '-------------------------------'
echo -e '\n\n'

module load MATLAB

EXEC=matlab
OPTS=' -singleCompThread -nodisplay -nosplash'

export PROCS=${SLURM_CPUS_ON_NODE}

${EXEC}${OPTS} < ex5.m
