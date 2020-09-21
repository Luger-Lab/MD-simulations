#!/bin/bash
#SBATCH -p short # Partition or queue. In this case, short!
#SBATCH --job-name=ante_mmpbsa # Job name
#SBATCH --mail-type=END # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=shla9937@colorado.edu
#SBATCH --nodes=1 # Only use a single node
#SBATCH --ntasks=1 # Run on a single node
#SBATCH --cpus-per-task=8 # cpus
#SBATCH --mem=4gb # Memory limit
#SBATCH --time=24:00:00 # Time limit hrs:min:sec
#SBATCH --output=/Users/%u/slurmfiles_out/slurm_%j.out # Standard output and error log
#SBATCH --error=/Users/%u/slurmfiles_err/slurm_%j.err # %j inserts job number

module purge

NAME=
END1=
ante-MMPBSA.py -p ../${NAME}_buffer.prmtop -c complex.prmtop -r receptor.prmtop -l ligand.prmtop -s :WAT,K+,K,Na+,NA,CL,Cl- -m :1-${END1} --radii mbondi2
