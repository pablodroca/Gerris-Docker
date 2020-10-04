#! /bin/bash
N_CORES=2
./clear_results.sh
time mpirun -np $N_CORES gerris2D -m cylinder_control.gfs 2>log.txt
