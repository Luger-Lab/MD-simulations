#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=preemptable
#SBATCH --account=blanca-biokem
#SBATCH --job-name=production
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=A100|A40
#SBATCH --ntasks=8
#SBATCH --mem=64gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

ml amber/v22

NAME='bd0055_rna'

pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_25ns.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_eq2.rst \
              -r ../restarts/${NAME}_25ns.rst \
              -x ../trajectories/${NAME}_25ns.nc \
              -inf ../mdinfo/${NAME}_25ns.mdinfo


pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_50ns.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_25ns.rst \
              -r ../restarts/${NAME}_50ns.rst \
              -x ../trajectories/${NAME}_50ns.nc \
              -inf ../mdinfo/${NAME}_50ns.mdinfo 
