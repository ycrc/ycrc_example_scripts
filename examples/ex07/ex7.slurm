#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH -t 10:00
#SBATCH -J Ex7
#SBATCH --mail-type=ALL

echo '-------------------------------'
cd ${SLURM_SUBMIT_DIR}
echo ${SLURM_SUBMIT_DIR}
echo Running on host $(hostname)
echo Time is $(date)
echo SLURM_NODES are $(echo ${SLURM_NODELIST})
echo '-------------------------------'
echo -e '\n\n'

export TOTALPROCS=${SLURM_CPUS_ON_NODE}

module load R/4.2.0-foss-2020b

Rscript ex7.R
