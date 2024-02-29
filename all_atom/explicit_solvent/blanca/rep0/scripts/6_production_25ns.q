#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=preemptable 
#SBATCH --account=blanca-biokem
#SBATCH --job-name=rep0
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks=1
#SBATCH --mem=32gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

module load amber/v22
NAME=''

pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_25ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_release5.rst \
              -r ../restarts/${NAME}_25ns.rst \
              -x ../trajectories/${NAME}_25ns.nc \
              -inf ../mdinfo/${NAME}_25ns.mdinfo

sleep 30

echo 25 >> step.txt

sbatch production_25ns.q
