#!/bin/bash
#SBATCH --partition=blanca-biokem
#SBATCH --qos=blanca-biokem
#SBATCH --account=blanca-biokem
#SBATCH --job-name=RMSD
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --mem=32gb
#SBATCH --time=24:00:00
#SBATCH --output=/home/%u/slurmfiles_out/slurm_%j.out
#SBATCH --error=/home/%u/slurmfiles_err/slurm_%j.err

module load amber/v22

NAME=$(basename -s _heat.nc $(ls ../trajectories/*heat.nc))
echo "parm ../*.prmtop
$(ls -tr1 ../trajectories/*ns.nc | awk '{print "trajin " $0}')
autoimage
strip (:WAT,K+,K,Na+,NA,CL,Cl-) outprefix stripped_and_dehydrated
trajout stripped_and_dehydrated_${NAME}.nc
run" > strip.cpptraj
cpptraj -i strip.cpptraj

echo "parm s*.prmtop
trajin s*nc
rms ToFirst !@H= out rmsd_all.dat
run" > rmsd.cpptraj
cpptraj -i rmsd.cpptraj

echo "parm s*.prmtop
trajin s*nc
rms ToFirst :4-87&!@H=  out rmsd_rna.dat
run" > rmsd_rna.cpptraj
cpptraj -i rmsd_rna.cpptraj

echo "parm s*.prmtop
trajin s*nc
rms ToFirst :23-73&@N6 out rmsd_23-73_n6.dat
run" > rmsd_23-73_n6.cpptraj
cpptraj -i rmsd_23-73_n6.cpptraj

echo "parm s*.prmtop
trajin s*nc
angle :73@C5 :2@C6 :23@C5 out angle.dat
run" > angle.cpptraj
cpptraj -i angle.cpptraj
