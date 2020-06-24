#!/bin/bash
#SBATCH -p titan # Partition or queue
#SBATCH --gres=gpu:1
#SBATCH --job-name=hpya_0 # Job name
#SBATCH --mail-type=END # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=shla9937@colorado.edu
#SBATCH --nodes=1 # Only use a single node
#SBATCH --ntasks=1 # Run on a single node
#SBATCH --cpus-per-task=1 # cpus
#SBATCH --mem=4gb # Memory limit
#SBATCH --time=150:00:00 # Time limit hrs:min:sec
#SBATCH --output=/Users/%u/slurmfiles_out/slurm_%j.out # Standard output and error log
#SBATCH --error=/Users/%u/slurmfiles_err/slurm_%j.err # %j inserts job number

NAME='2M_KCL_hpya_DNA_no_loop'

# Copy the next chunk of code and change the PREVIOUS_TIME and TIME_STEP variables.

PREVIOUS_TIME='300'
TIME_STEP='325'

pmemd.cuda -O -i 25ns_4ps_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='325'
TIME_STEP='350'

pmemd.cuda -O -i 25ns_4ps_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='350'
TIME_STEP='375'
	
pmemd.cuda -O -i 25ns_4ps_per_step.in \
	      -o ../outputs/${NAME}_${TIME_STEP}ns.out \
	      -p ../${NAME}_buffer.prmtop \
	      -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
	      -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='375'
TIME_STEP='400'
	
pmemd.cuda -O -i 25ns_4ps_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='400'
TIME_STEP='425'

pmemd.cuda -O -i 25ns_4ps_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='425'
TIME_STEP='450'

pmemd.cuda -O -i 25ns_4ps_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='450'
TIME_STEP='475'

pmemd.cuda -O -i 25ns_4ps_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='475'
TIME_STEP='500'

pmemd.cuda -O -i 25ns_4ps_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo
