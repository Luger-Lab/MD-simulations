#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=blanca
#SBATCH --account=blanca-biokem
#SBATCH --job-name=10us_md
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

PREVIOUS_TIME='1'
TIME_STEP='2'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='2'
TIME_STEP='3'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='3'
TIME_STEP='4'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='4'
TIME_STEP='5'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='5'
TIME_STEP='6'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='6'
TIME_STEP='7'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='7'
TIME_STEP='8'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='8'
TIME_STEP='9'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo

PREVIOUS_TIME='9'
TIME_STEP='10'

pmemd.cuda -O -i gpu_in/md_GB.in \
              -o ../outputs/${NAME}_${TIME_STEP}us.out \
              -p ../${NAME}.prmtop \
              -c ../restarts/${NAME}_${PREVIOUS_TIME}us.rst \
              -r ../restarts/${NAME}_${TIME_STEP}us.rst \
              -x ../trajectories/${NAME}_${TIME_STEP}us.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}us.mdinfo
