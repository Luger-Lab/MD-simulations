#!/bin/bash
#SBATCH -p short # Partition or queue. In this case, short!
#SBATCH --job-name=MMGBSA # Job name
#SBATCH --mail-type=END # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=shla9937@colorado.edu
#SBATCH --nodes=1 # Only use a single node
#SBATCH --ntasks=1 # Run on a single node
#SBATCH --cpus-per-task=20 # cpus
#SBATCH --mem=4gb # Memory limit
#SBATCH --time=24:00:00 # Time limit hrs:min:sec
#SBATCH --output=/Users/%u/slurmfiles_out/slurm_%j.out # Standard output and error log
#SBATCH --error=/Users/%u/slurmfiles_err/slurm_%j.err # %j inserts job number

NAME=${msm0213}
echo 'parm ../${NAME}_buffer.prmtop
trajin ../trajectories/${NAME}_25ns.nc
trajin ../trajectories/${NAME}_50ns.nc
trajin ../trajectories/${NAME}_75ns.nc
trajin ../trajectories/${NAME}_100ns.nc
trajin ../trajectories/${NAME}_125ns.nc
trajin ../trajectories/${NAME}_150ns.nc

autoimage

strip (:WAT,K+,K,Na+,NA,CL,Cl-) outprefix stripped

rms ToFirst @CA,C,N out rmsd_${NAME}_150ns.dat

trajout ${NAME}_stripped_and_imaged.nc

run' > rmsd_${NAME}.cpptraj

cpptraj -i rmsd_${NAME}.cpptraj
