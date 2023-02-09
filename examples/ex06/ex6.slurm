#!/bin/bash

#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH -t 10:00
#SBATCH -J Ex6
#SBATCH --mail-type=ALL

echo '-------------------------------'
cd ${SLURM_SUBMIT_DIR}
echo ${SLURM_SUBMIT_DIR}
echo Running on host $(hostname)
echo Time is $(date)
echo SLURM_NODES are $(echo ${SLURM_NODELIST})
echo '-------------------------------'
echo -e '\n\n'

module load R/4.2.0-foss-2020b

srun Rscript ex6.R
