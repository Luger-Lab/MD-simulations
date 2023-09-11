#!/bin/bash
#SBATCH --partition=blanca-biokem
#SBATCH --qos=blanca-biokem 
#SBATCH --account=blanca-biokem
#SBATCH --job-name=ante-MMGBSA
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=128gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

module load amber/v22
NAME='bd0055_DNA_0M_KCL'

END1=234
ante-MMPBSA.py -p ../${NAME}_buffer.prmtop -c complex.prmtop -r receptor.prmtop -l ligand.prmtop -s :WAT,K+,K,Na+,NA,CL,Cl- -m :1-${END1} --radii mbondi2
