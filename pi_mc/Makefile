all:
	mpicc -o pi_mc src/pi_mc.c src/mpi_helpers.c -Wall

run:
	mpiexec -machinefile ./mpihosts -np 4 ./pi_mc

local:
	gcc -o pi_mc src/pi_mc.c -Wall
