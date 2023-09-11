#!/bin/bash
#SBATCH --partition=blanca-biokem
#SBATCH --qos=blanca-biokem 
#SBATCH --account=blanca-biokem
#SBATCH --job-name=strip_and_image
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --mem=128gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

module load amber/v22
NAME='bd0055_DNA_0M_KCL'

echo "parm ../${NAME}_buffer.prmtop
trajin ../trajectories/${NAME}_25ns.nc
trajin ../trajectories/${NAME}_50ns.nc

autoimage

strip (:WAT) outprefix dehydrated

trajout ${NAME}_dehydrated_and_imaged.nc

run" > dehydrated_${NAME}.cpptraj

cpptraj -i dehydrated_${NAME}.cpptraj
