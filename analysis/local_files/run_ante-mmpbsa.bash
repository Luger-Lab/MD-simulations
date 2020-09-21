NAME=msm0213
END1=64
ante-MMPBSA.py -p ../${NAME}_buffer.prmtop -c complex.prmtop -r receptor.prmtop -l ligand.prmtop -s :WAT,K+,K,Na+,NA,CL,Cl- -m :1-${END1} --radii mbondi2
