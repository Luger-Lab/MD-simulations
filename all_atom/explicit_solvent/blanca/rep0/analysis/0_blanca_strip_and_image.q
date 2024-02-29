#!/bin/bash
#SBATCH --partition=blanca-biokem
#SBATCH --qos=blanca-biokem
#SBATCH --account=blanca-biokem
#SBATCH --job-name=strip_and_image
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --mem=80gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

module load amber/v22

NAME=$(basename -s _heat.nc $(ls ../trajectories/*heat.nc))

echo "parm ../*.prmtop

$(ls -tr1 ../trajectories/*ns.nc | awk '{print "trajin " $0}')

autoimage

strip (:WAT) outprefix dehydrated

trajout dehydrated_${NAME}.nc

run" > dehydrated.cpptraj

cpptraj -i dehydrated.cpptraj

