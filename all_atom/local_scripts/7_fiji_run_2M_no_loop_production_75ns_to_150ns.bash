#!/bin/bash
#SBATCH -p titan # Partition or queue
#SBATCH --job-name=md_sim # Job name
#SBATCH --mail-type=END # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=shla9937@colorado.edu
#SBATCH --nodes=1 # Only use a single node
#SBATCH --ntasks=1 # Run on a single node
#SBATCH --cpus-per-task=1 # cpus
#SBATCH --gres=gpu:1
#SBATCH --mem=4gb # Memory limit
#SBATCH --time=60:00:00 # Time limit hrs:min:sec
#SBATCH --output=/Users/%u/slurmfiles_out/slurm_%j.out # Standard output and error log
#SBATCH --error=/Users/%u/slurmfiles_err/slurm_%j.err # %j inserts job number

NAME='2M_KCL_hpya_DNA_no_loop'

# Copy the next chunk of code and change the PREVIOUS_TIME and TIME_STEP variables.

PREVIOUS_TIME='50'
TIME_STEP='75'

pmemd.cuda -O -i 25ns_4ps_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='75'
TIME_STEP='100'

pmemd.cuda -O -i 25ns_4ps_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='100'
TIME_STEP='125'
	
pmemd.cuda -O -i 25ns_4ps_per_step.in \
	      -o ../outputs/${NAME}_${TIME_STEP}ns.out \
	      -p ../${NAME}_buffer.prmtop \
	      -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
	      -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='125'
TIME_STEP='150'
	
pmemd.cuda -O -i 25ns_4ps_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo
