#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=preemptable
#SBATCH --account=blanca-biokem
#SBATCH --job-name=RMSD
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --mem=32gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

module load amber/v22
NAME='bd0055_DNA_0M_KCL'

echo "parm ../${NAME}_buffer.prmtop
trajin ../trajectories/${NAME}_25ns.nc
trajin ../trajectories/${NAME}_50ns.nc
trajin ../trajectories/${NAME}_75ns.nc
trajin ../trajectories/${NAME}_100ns.nc
trajin ../trajectories/${NAME}_125ns.nc
trajin ../trajectories/${NAME}_150ns.nc
trajin ../trajectories/${NAME}_175ns.nc
trajin ../trajectories/${NAME}_200ns.nc
trajin ../trajectories/${NAME}_225ns.nc
trajin ../trajectories/${NAME}_250ns.nc
trajin ../trajectories/${NAME}_275ns.nc
trajin ../trajectories/${NAME}_300ns.nc

autoimage

strip (:WAT,K+,K,Na+,NA,CL,Cl-) outprefix stripped_300ns

rms ToFirst @CA,C,N out rmsd_${NAME}_300ns.dat

trajout ${NAME}_stripped_and_imaged_300ns.nc

run" > rmsd_${NAME}.cpptraj

cpptraj -i rmsd_${NAME}.cpptraj
