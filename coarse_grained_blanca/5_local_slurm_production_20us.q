#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=blanca
#SBATCH --account=blanca-biokem
#SBATCH --job-name=20us_md
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=A100|A40
#SBATCH --ntasks=2
#SBATCH --mem=32gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

module load amber/v22
NAME=''

PREVIOUS_TIME='10'
TIME_STEP='11'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='11'
TIME_STEP='12'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='12'
TIME_STEP='13'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='13'
TIME_STEP='14'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='14'
TIME_STEP='15'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='15'
TIME_STEP='16'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='16'
TIME_STEP='17'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='17'
TIME_STEP='18'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='18'
TIME_STEP='19'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='19'
TIME_STEP='20'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

