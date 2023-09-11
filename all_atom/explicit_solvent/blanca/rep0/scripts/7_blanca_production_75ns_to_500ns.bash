#!/bin/bash
#SBATCH --partition=blanca-biokem
#SBATCH --qos=blanca-biokem 
#SBATCH --account=blanca-biokem
#SBATCH --job-name=md_sim_500ns
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks=1
#SBATCH --mem=128gb
#SBATCH --time=7-00:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

module load amber/v22
NAME=''

# Copy the next chunk of code and change the PREVIOUS_TIME and TIME_STEP variables.

PREVIOUS_TIME='50'
TIME_STEP='75'

pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='75'
TIME_STEP='100'

pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='100'
TIME_STEP='125'
	
pmemd.cuda -O -i 25ns_4fs_per_step.in \
	      -o ../outputs/${NAME}_${TIME_STEP}ns.out \
	      -p ../${NAME}_buffer.prmtop \
	      -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
	      -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='125'
TIME_STEP='150'
	
pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='150'
TIME_STEP='175'

pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='175'
TIME_STEP='200'

pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='200'
TIME_STEP='225'
	
pmemd.cuda -O -i 25ns_4fs_per_step.in \
	      -o ../outputs/${NAME}_${TIME_STEP}ns.out \
	      -p ../${NAME}_buffer.prmtop \
	      -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
	      -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='225'
TIME_STEP='250'
	
pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='250'
TIME_STEP='275'

pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='275'
TIME_STEP='300'

pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='300'
TIME_STEP='325'

pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='325'
TIME_STEP='350'

pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='350'
TIME_STEP='375'
	
pmemd.cuda -O -i 25ns_4fs_per_step.in \
	      -o ../outputs/${NAME}_${TIME_STEP}ns.out \
	      -p ../${NAME}_buffer.prmtop \
	      -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
	      -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='375'
TIME_STEP='400'
	
pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='400'
TIME_STEP='425'

pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='425'
TIME_STEP='450'

pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='450'
TIME_STEP='475'

pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

PREVIOUS_TIME='475'
TIME_STEP='500'

pmemd.cuda -O -i 25ns_4fs_per_step.in \
              -o ../outputs/${NAME}_${TIME_STEP}ns.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}ns.rst \
              -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo
