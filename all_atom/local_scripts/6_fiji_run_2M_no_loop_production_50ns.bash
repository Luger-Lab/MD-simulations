#!/bin/bash
#SBATCH -p titan # Partition or queue. In this case, short!
#SBATCH --job-name=md_sim_50ns # Job name
#SBATCH --mail-type=END # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=shla9937@colorado.edu
#SBATCH --nodes=1 # Only use a single node
#SBATCH --ntasks=1 # Run on a single node
#SBATCH --cpus-per-task=1 # cpus
#SBATCH --mem=4gb # Memory limit
#SBATCH --time=24:00:00 # Time limit hrs:min:sec
#SBATCH --output=/Users/%u/slurmfiles_out/slurm_%j.out # Standard output and error log
#SBATCH --error=/Users/%u/slurmfiles_err/slurm_%j.err # %j inserts job number

NAME='2M_KCL_hpya_DNA_no_loop'

pmemd.cuda -O -i 25ns_4ps_per_step.in \
              -o ../outputs/${NAME}_25ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_release5.rst \
              -r ../restarts/${NAME}_25ns.rst \
              -x ../trajectories/${NAME}_25ns.nc \
              -inf ../mdinfo/${NAME}_25ns.mdinfo


pmemd.cuda -O -i 25ns_4ps_per_step.in \
              -o ../outputs/${NAME}_50ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_25ns.rst \
              -r ../restarts/${NAME}_50ns.rst \
              -x ../trajectories/${NAME}_50ns.nc \
              -inf ../mdinfo/${NAME}_50ns.mdinfo 

