all:
	mpicc -o ssend src/p2p.c src/benchmark.c src/helpers.c -Wall -D SSEND=1
	mpicc -o send  src/p2p.c src/benchmark.c src/helpers.c -Wall

run:
	mpiexec -machinefile ./mpihosts -np 2 ./ssend > results/ssend.csv
	mpiexec -machinefile ./mpihosts -np 2 ./send  > results/send.csv

zeus:
	mpiexec ./ssend > results/ssend.csv
	mpiexec ./send  > results/send.csv
