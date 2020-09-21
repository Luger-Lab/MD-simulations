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

module purge
module load openmpi

mpirun -np 20 MMPBSA.py.MPI -i igb5.in -cp complex.prmtop -rp receptor.prmtop -lp ligand.prmtop -y stripped_and_imaged.nc

