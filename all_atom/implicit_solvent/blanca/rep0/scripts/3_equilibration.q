#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=preemptable
#SBATCH --account=blanca-biokem
#SBATCH --job-name=equilibration
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=A100|A40
#SBATCH --ntasks=8
#SBATCH --mem=64gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

NAME='bd0055_rna'

pmemd.cuda -O -i eq1.in\
 -p ../${NAME}.prmtop -c ../restarts/${NAME}_heat.rst -ref ../restarts/${NAME}_heat.rst\
 -o ../outputs/eq1.out -x ../trajectories/${NAME}_eq1.nc -inf ../mdinfo/${NAME}_eq1.info\
 -r ../restarts/${NAME}_eq1.rst

pmemd.cuda -O -i eq2.in\
 -p ../${NAME}.prmtop -c ../restarts/${NAME}_eq1.rst -ref ../restarts/${NAME}_eq1.rst\
 -o ../outputs/eq2.out -x ../trajectories/${NAME}_eq2.nc -inf ../mdinfo/${NAME}_eq2.info\
 -r ../restarts/${NAME}_eq2.rst

