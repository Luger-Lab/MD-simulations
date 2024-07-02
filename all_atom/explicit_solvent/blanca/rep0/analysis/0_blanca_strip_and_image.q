#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=preemptable
#SBATCH --account=blanca-biokem
#SBATCH --job-name=strip_and_image
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=24gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

source /programs/sbgrid.shrc

NAME=$(basename -s _heat.nc $(ls ../trajectories/*heat.nc))
echo "parm ../*.prmtop
$(ls -tr1 ../trajectories/*ns.nc | awk '{print "trajin " $0}')
autoimage
strip (:WAT) outprefix dehydrated
trajout dehydrated_${NAME}.nc
run" > dehydrated.cpptraj

cpptraj -i dehydrated.cpptraj

