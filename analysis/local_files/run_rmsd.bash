NAME=${msm0213}
echo 'parm ../${NAME}_buffer.prmtop
trajin ../trajectories/${NAME}_25ns.nc
trajin ../trajectories/${NAME}_50ns.nc
trajin ../trajectories/${NAME}_75ns.nc
trajin ../trajectories/${NAME}_100ns.nc
trajin ../trajectories/${NAME}_125ns.nc
trajin ../trajectories/${NAME}_150ns.nc

autoimage

strip (:WAT,K+,K,Na+,NA,CL,Cl-) outprefix stripped

rms ToFirst @CA,C,N out rmsd_${NAME}_150ns.dat

trajout ${NAME}_stripped_and_imaged.nc

run' > rmsd_${NAME}.cpptraj

cpptraj -i rmsd_${NAME}.cpptraj
