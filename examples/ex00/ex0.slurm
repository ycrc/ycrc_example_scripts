#!/usr/bin/env bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH -t 05:00

module load Apps/R/3.4.1-generic

Rscript -e 'rnorm(1e3)'
