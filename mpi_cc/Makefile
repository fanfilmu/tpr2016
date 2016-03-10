all:
	mpicc -o scan src/scan.c -Wall -lm
	mpicc -o p2p  src/p2p.c  -Wall -lm

run:
	mpiexec -machinefile ./mpihosts -np 4 ./scan
	mpiexec -machinefile ./mpihosts -np 4 ./p2p
