#!/bin/bash
#SBATCH --partition=blanca
#SBATCH --qos=preemptable 
#SBATCH --account=blanca-biokem
#SBATCH --job-name=-rep0
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --exclude=bgpu-bortz1
#SBATCH --ntasks=1
#SBATCH --mem=32gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

module load amber/v22
NAME=''

TIME_STEP=$( tail -n 1 step.txt )
((TIME_STEP+=25))

if [ $TIME_STEP -le 500 ] 
then
  pmemd.cuda -O -i 25ns_4fs_per_step.in \
                -o ../outputs/${NAME}_${TIME_STEP}ns.out \
                -p ../${NAME}_buffer.prmtop \
                -c ../restarts/${NAME}_$(( ${TIME_STEP} - 25 ))ns.rst \
                -r ../restarts/${NAME}_${TIME_STEP}ns.rst \
                -x ../trajectories/${NAME}_${TIME_STEP}ns.nc \
                -inf ../mdinfo/${NAME}_${TIME_STEP}ns.mdinfo

  sleep 30

  (cd ../analysis && sbatch 0_blanca_strip_and_image.q)
  (cd ../analysis && sbatch 1_blanca_rmsd.q)

  echo $TIME_STEP >> step.txt

  sbatch production_25ns.q 
fi
