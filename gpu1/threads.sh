#!/bin/sh
#PBS -l nodes=1:ppn=1:gpus=1
#PBS -q gpgpu
#PBS -l walltime=00:10:00
#PBS -A plgfan2016a

module add gpu/cuda

WRDIR="$HOME/tpr2016/gpu1"
cd $WRDIR

nvcc -gencode arch=compute_20,code=sm_20 -o vectors vectors.cu

echo "problem_size,block_size,grid_size,cpu_time,gpu_time,errors"
for exp in `seq 16 25`; do
  size=`echo "2^$exp" | bc`

  for block_size_factor in `seq 1 32`; do
    block_size=`echo "32*$block_size_factor" | bc`
    
    for k in `seq 1 10`; do
      ./vectors $size $block_size 1
    done
  done 
done

rm vectors
