#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=preemptable
#SBATCH --account=blanca-biokem
#SBATCH --job-name=strip_image_rmsd
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=24gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

source /programs/sbgrid.shrc

NAME=$(basename -s _eq2.nc $(ls ../trajectories/*eq2.nc))
echo "parm ../*.prmtop
$(ls -tr1 ../trajectories/*ns.nc | awk '{print "trajin " $0}')
autoimage
strip (:WT4) outprefix dehydrated
rms ToFirst @GC,PX out rmsd_${NAME}.dat
trajout dehydrated_${NAME}.nc
run" > dehydrated.cpptraj
cpptraj -i dehydrated.cpptraj