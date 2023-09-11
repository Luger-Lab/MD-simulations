#!/bin/bash
#SBATCH --partition=blanca-biokem
#SBATCH --qos=blanca-biokem 
#SBATCH --account=blanca-biokem
#SBATCH --job-name=MMGBSA
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --mem=128gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

module load amber/v22
NAME='bd0055_DNA_0M_KCL'

echo "&general 
 startframe=10000,interval=10,verbose=1,netcdf=1,
/

&gb
 igb=5,saltcon=2,
/

&decomp
 dec_verbose=0,idecomp=1,
/" > igb5.in

mpirun -np 20 MMPBSA.py.MPI -i igb5.in -cp complex.prmtop -rp receptor.prmtop -lp ligand.prmtop -y ${NAME}_stripped_and_imaged.nc

