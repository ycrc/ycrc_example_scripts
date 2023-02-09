#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH -t 05:00

module load R/4.2.0-foss-2020b

Rscript -e 'rnorm(1e3)'
