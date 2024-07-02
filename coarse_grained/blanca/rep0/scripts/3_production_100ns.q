#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=preemptable
#SBATCH --account=blanca-biokem
#SBATCH --job-name=arc_slinkie-wat4-neutral-rep0
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks=2
#SBATCH --mem=32gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

module load amber/v22
NAME='cg_arc_slinkie'

pmemd.cuda -O -i gpu_in/md_WT4.in \
              -o ../outputs/${NAME}_100ns.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_eq2.rst \
              -r ../restarts/${NAME}_100ns.rst \
              -x ../trajectories/${NAME}_100ns.nc \
              -inf ../mdinfo/${NAME}_100ns.mdinfo

echo "100" >> step.txt

sbatch production_100ns.q  