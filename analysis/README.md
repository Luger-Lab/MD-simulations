# RMSD analysis

# MMGBSA analysis
Now that we've found out when our complex has fully equillibrated via analyzing RMSD vs. frame, we can calculate the free energy of binding of our complex to see how strong this interaction is. Generally, the MMGBSA calculation will calculate the free energy of the overall "complex", the "'receptor'" molecule and the "'ligand'" molecule. It will the subtract the receptor and ligand free energies from the complex to get a free energy of binding.

0. The first thing we need to do is create three prmtops that will seperate the atoms in our simulation into:
   - complex: all of the atoms we want to run the calculation on
   - receptor: binding partner 1, usually protein of ligand (which partner is the receptor/ligand is fairly arbitrary)
   - ligand: binding partner 2 
        
   We'll create these files using the ante-MMPBSA.py (this tool is also used for MMGBSA). 
        
   we can keep track of everything we are doing by running these commands through a script called run_ante-MMPBSA.bash        

        NAME=msm0213
        END1=64
        ante-MMPBSA.py -p ../${NAME}_buffer.prmtop -c complex.prmtop -r receptor.prmtop -l ligand.prmtop -s :WAT,K+,K,Na+,NA,CL,Cl- -m :1-${END1} --radii mbondi2
        
    - -p : prmtop you are inputting 
    - -c : name of the complex prmtop you'd like to create
    - -r : name of the receptor prmtop  you'd like to create
    - -l : name of ligand prmtop you'd like to create
    - -s : mask to define which atoms need to be stripped from the input to create complex prmtop (i.e waters, salts)
    - -m : mask to define which atoms need to be stripped from the new complex prmtop to make the receptor prmtop
    - -n (not used here) : same as -m, but for the ligand (you can only use -m or -n, not both)
    - --radii : set the radius of in the generated topology files (use mbondi2 when in doubt)
    
    Run the file and it should create 3 new prmtops.
    
1. Now that we have the prmtops we need for the MMGBSA calculations, we can set up our input file, in this case igb5.in
    
        &general 
         startframe=1000,interval=10,verbose=1,netcdf=1,
        /

        &gb
         igb=5,saltcon=0,
        /

        &decomp
         dec_verbose=0,idecomp=1,
        /
    
    - startframe : set this to a frame after you are confident the system has equilibrated
    - interval : how often (frame-wise) to do the calculation (lower number = more compute time)
    - verbose : whether or not to output everything in the output file (0 = False, 1 = True)
    - netcdf : whether or not trajectory type is .nc (0 = False, 1 = True)
    - &gb : run MMGBSA commands
    - igb : which Born solvation model to use, igb=5 is the generalized model with extra parameters (meant to be used with mbondi2)
    - saltcon : simply the concentration (in M) that your MD sim was ran at
    - &decomp : run decomposition analysis (decompose the contribution of each residue to the overall free energy)
    - dec_verbose : whether or not to output everything to the output file (0 = False, 1 = True)
    - idecomp : how to run decomposition (1 & 2 are for per-residue, 3 & 4 are for pairwise-residue) (1 adds the non-bonded interactions,  1-4 EEL and 1-4 VDW, to the internal potential terms
    
2. We will run the MMGBSA calculation using another shell script to keep track of our work, run_mmgbsa.bash

        mpirun -np 20 MMPBSA.py.MPI -i igb5.in -cp complex.prmtop -rp receptor.prmtop -lp ligand.prmtop -y stripped_and_imaged.nc
   
    - mpirun -np : calls for multiple CPUs to run calculation in parallel (don't ask for more than are available)
    - MMPSBA.py.MPI : the MPI enabled version of MMPSBA.py to carry out our MMGBSA calculations
    - -i : input file we just made
    - -cp : complex prmtop we created with ante-MMPBSA.py
    - -rp : receptor prmtop we created with ante-MMPBSA.py
    - -lp : ligand prmtop we created with ante-MMPBSA.py
    - -y : trajectory file we want to run the analysis on (could use the original non-stripped version because the masks will look at the same atoms whether or not the trajectory is solvated, but this will run faster and is smaller)
   
    Run the bash file (this will take a few minutes depending on stepsize, number of frames and size of complex).
   
3. You'll get a whole bunch of intermediate files that start with an underscore, I'd just move them to a temporary folder.
    
    The FINAL_RESULTS_MMPBSA.dat will hold your overall results with the final free energy at the bottom of the file.
    
    The FINAL_DECOMP_MMPBSA.dat will hold your per-residue decomposition data.
    
   