#!/bin/bash
#SBATCH -p titan # Partition or queue. In this case, short!
#SBATCH --job-name=md_heat_and_eq # Job name
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

pmemd.cuda -O -i heat.in \
              -o ../outputs/${NAME}_heat.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_min2.rst \
              -r ../restarts/${NAME}_heat.rst \
              -x ../trajectories/${NAME}_heat.nc \
              -inf ../mdinfo/${NAME}_heat.mdinfo \
              -ref ../restarts/${NAME}_min2.rst

pmemd.cuda -O -i release1.in \
              -o ../outputs/${NAME}_release1.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_heat.rst \
              -r ../restarts/${NAME}_release1.rst \
              -x ../trajectories/${NAME}_release1.nc \
              -inf ../mdinfo/${NAME}_release1.mdinfo \
              -ref ../restarts/${NAME}_heat.rst

pmemd.cuda -O -i release2.in \
              -o ../outputs/${NAME}_release2.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_release1.rst \
              -r ../restarts/${NAME}_release2.rst \
              -x ../trajectories/${NAME}_release2.nc \
              -inf ../mdinfo/${NAME}_release2.mdinfo \
              -ref ../restarts/${NAME}_release1.rst

pmemd.cuda -O -i release3.in \
              -o ../outputs/${NAME}_release3.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_release2.rst \
              -r ../restarts/${NAME}_release3.rst \
              -x ../trajectories/${NAME}_release3.nc \
              -inf ../mdinfo/${NAME}_release3.mdinfo \
              -ref ../restarts/${NAME}_release2.rst

pmemd.cuda -O -i release4.in \
              -o ../outputs/${NAME}_release4.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_release3.rst \
              -r ../restarts/${NAME}_release4.rst \
              -x ../trajectories/${NAME}_release4.nc \
              -inf ../mdinfo/${NAME}_release4.mdinfo \
              -ref ../restarts/${NAME}_release3.rst

pmemd.cuda -O -i release5.in \
              -o ../outputs/${NAME}_release5.out \
              -p ../${NAME}_buffer.prmtop \
              -c ../restarts/${NAME}_release4.rst \
              -r ../restarts/${NAME}_release5.rst \
              -x ../trajectories/${NAME}_release5.nc \
              -inf ../mdinfo/${NAME}_release5.mdinfo \
              -ref ../restarts/${NAME}_release4.rst

