# MD-simulations
This repository will provide explanations and examples on how to run molecular dynamics simulations through parmed in the Amber18 suite. The following is an example of how to run a molecular dynamics simulation starting from a PDB.


# MD example
0. create a directory with the name of the simulation you'd like to run (can add a number to the end of it if it's a replicate) 

        mkdir 2M_KCL_hpya_DNA
        cd 2M_KCL_hpya_DNA
        
    set up your working directory

        mkdir mdinfo pdb_prep scripts outputs restarts trajectories
        
   *prep your pdb in pdb_prep, then move the prmtop out to same level as all the directories, run all simulations from the scripts directory 
   
1. (just prepping pdb here) create Hpya + 30bp DNA pdb by deleting two other monomers and trimming DNA from Hpya nucleosome model in Chimera
    - sequence = ATCAATTAAAGCGTTCTACGGCGTTTTTGA
    - output: hpya_DNA.pdb
    
2. edit pdb file to remove model info, contacts, 2nd structure, 5' phosphate, and add 'TER' to end of chains output: hpya_DNA_ready.pdb

3. copied over to workstation 3 (can use rsync)

4. prep'd the pdb for amber using:

        module load amber
        pdb4amber -i hpya_DNA_ready.pdb -o hpya_DNA_amber.pdb --dry --reduce
        
5. now we need to build the prmtop, neutralize this system using tleap:
    - create 0_neutralize.leap:
    
            #load forcefield parameters
            source leaprc.protein.ff14SB
            source leaprc.DNA.bsc1
            source leaprc.water.tip3p
            
            unit = loadpdb ../files_hpya_DNA_ambers/hpya_DNA_amber.pdb
            #'loadpbd' fills in missing H atoms, and missing heavy atoms
            
            #add counter-ions
            addions unit K+ 0
            
            #save neutralized PDB
            savepdb unit ../hpya_DNA_neutralized.pdb
            
            quit

    - run this file:

            tleap -s -f 0_neutralize.leap

6. to figure out how many ions to add, we'll build the water box and see how many waters we added:
    - create 1_addwater.leap (made water box 25A to accomedate loat of ions):

            #load forcefield parameters
            source leaprc.protein.ff14SB
            source leaprc.DNA.bsc1
            source leaprc.water.tip3p

            unit = loadpdb ../hpya_DNA_neutralized.pdb
            #'loadpbd' fills in missing H atoms, and missing heavy atoms

            #add water box
            solvatebox unit TIP3PBOX 25.0

            quit

    - run this file:

            tleap -s -f 1_addwater.leap

7. that created a file called leap.log, go to bottom of file and look for 'Added 54979 residues.', copy number.
8. run 2_salt_concentration.py and copy text it tells you too (I changed Na+ to K+):

        python 2_salt_concentration.py --wat 54979 --conc 2
        
9. paste into 3_addions.leap and run (needed to remove a 5' phosphate):

        tleap -s -f 3_addions.leap
        
10. HMass repartitioning to speed up simulations:
    - Load prmtop into parmed:
    
            parmed -p non_hmass_2M_KCL_hpya_DNA_buffer.prmtop
            
    - run repartitioning:
            
            HMassRepartition
            
    - output new prmtop:
    
            outparm 2M_KCL_hpya_DNA_buffer.prmtop
            
    - quit parmed:
    
            quit

10. then minimize structure

    - first by letting solutes move (make in file called min1.in):

            Minimization 1
             &cntrl
              imin=1,maxcyc=5000,irest=0,ntx=1,
              ntpr=5,
              ntr=1, restraint_wt=10.0,restraintmask='(!:WAT,Cl-,K+)&!(@H=)',
              cut=10.0,ntt=3,gamma_ln=3,temp0=10.0,
              ntb=1,iwrap=1,
            /

    - then minimize whole system using min2.in:

            Minimization 2
             &cntrl
              imin=1,maxcyc=5000,irest=0,ntx=1,
              ntpr=5,
              cut=10.0,ntt=3,gamma_ln=3,temp0=10.0,
              ntb=1,iwrap=1,
            /

    - run back to back with 4_run_2M_minimization.bash (using 'bash 4_run_2M_minimization.bash' command):

            #!/bin/bash

            module load cuda/8.0 anaconda/2 mpi amber
            NAME='2M_KCL_hpya_DNA_no_loop'

            #run the first minimization
            mpirun -np 9 pmemd.MPI -O -i min1.in -o ../outputs/min1.out -p ../${NAME}_buffer.prmtop -c ../${NAME}_buffer.inpcrd -r ../restarts/${NAME}_min1.rst\
             -x ../trajectories/${NAME}_min1.nc -inf ../mdinfo/${NAME}_min1.mdinfo -ref ../${NAME}_buffer.inpcrd

            #run the second minimization
            mpirun -np 9 pmemd.MPI -O -i min2.in -o ../outputs/min2.out -p ../${NAME}_buffer.prmtop -c ../restarts/${NAME}_min1.rst -r ../restarts/${NAME}_min2.rst\
             -x ../trajectories/${NAME}_min2.nc -inf ../mdinfo/${NAME}_min2.mdinfo

11. run heating and density equilibration (using 'bash 5_2M_KCL_heat_and_density_equilibrate.bash' command for local GPU or 'sbatch 5_2M_KCL_heat_and_density_equilibrate.bash' for Slurm system):
    
*the example scripts are written for a Slurm managed system, replace the #SBATCH lines with the following to run on a local GPU:

        #!/bin/bash
        module load amber
        export CUDA_VISIBLE_DEVICES=2
        
5_2M_KCL_heat_and_density_equilibrate.bash:

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
              
12. run production step (6_run_2M_production_50ns.bash):

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

run on Slurm:

        sbatch 6_run_2M_production_50ns.bash

run on local machine (remember to change header):

        nohup bash 6_run_2M_production_50ns.bash & 

*this command suppresses the output and allows you to close connection with the workstation, because this will take multiple hours
        
14. after running production use this command to sync external hard drive with all files on workstation (be in the directory above the local 2020_hpya_DNA_md, luger_lab in this case):
        
        cu-genvpn-tcom-10:luger_lab shawn$ rsync -ravzhP shla9937@luger-imaging-3.int.colorado.edu:/data/shawn/2020_hpya_DNA_md .

15. run more timesteps using the scripts starting with 7, 8, and 9 (they are modular so just follow the instructions from making custom timesteps, you could also write a loop very easily, just make sure not to overwrite already completed simulations).
