#!/bin/bash
#SBATCH --partition=blanca-biokem
#SBATCH --qos=blanca-biokem
#SBATCH --account=blanca-biokem
#SBATCH --job-name=RMSD
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --mem=32gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

module load amber/v22

NAME=$(basename -s _heat.nc $(ls ../trajectories/*heat.nc))

echo "parm ../*.prmtop

$(ls -tr1 ../trajectories/*ns.nc | awk '{print "trajin " $0}')

autoimage

strip (:WAT,K+,K,Na+,NA,CL,Cl-) outprefix stripped_and_dehydrated

rms first @CA,C,N out rmsd_${NAME}.dat

trajout stripped_and_dehydrated_${NAME}.nc

run" > rmsd.cpptraj

cpptraj -i rmsd.cpptraj
