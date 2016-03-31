all:
	mpicc -o bin/concurrent src/concurrent.c -Wall

run:
	mpiexec -machinefile ./mpihosts -np 4 ./bin/concurrent > results/send.csv
