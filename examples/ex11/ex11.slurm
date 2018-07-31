#!/usr/bin/env bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH -t 10:00
#SBATCH -J Ex11
#SBATCH -o log.%j

echo '-------------------------------'
cd ${SLURM_SUBMIT_DIR}
echo ${SLURM_SUBMIT_DIR}
echo Running on host $(hostname)
echo Time is $(date)
echo SLURM_NODES are $(echo ${SLURM_NODELIST})
echo '-------------------------------'
echo -e '\n\n'

module load Apps/Matlab/R2017b

EXEC=matlab
OPTS1=' -nodisplay -nosplash -nojvm'
OPTS2=' -singleCompThread'

${EXEC}${OPTS1} -r "ex11"
${EXEC}${OPTS1} -r "ex11"

${EXEC}${OPTS1}${OPTS2} -r "ex11"
${EXEC}${OPTS1}${OPTS2} -r "ex11"