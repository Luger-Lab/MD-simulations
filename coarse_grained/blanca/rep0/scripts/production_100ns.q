#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=preemptable
#SBATCH --account=blanca-biokem
#SBATCH --job-name=rep0
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --ntasks=2
#SBATCH --mem=32gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

source /programs/sbgrid.shrc
NAME=''

TIME_STEP=$( tail -n 1 step.txt )
((TIME_STEP+=100))

if [ $TIME_STEP -le 20000 ] 
then
  pmemd.cuda -O -i gpu_in/md_WT4.in \
                -o ../outputs/${NAME}_${TIME_STEP}ns.out \
                -p ../${NAME}.prmtop \
                -c ../restarts/${NAME}_$(( ${TIME_STEP} - 100 ))ns.rst \
                -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
                -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
              -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

  sleep 30
  (cd ../analysis && sbatch 0_blanca_strip_image_rmsd.q)

  echo $TIME_STEP >> step.txt

  sbatch production_100ns.q 
fi