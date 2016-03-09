set  autoscale

set title "MPI Point to Point bandwidth test"
set ylabel "Bandwidth [MiB/s]"
set xlabel "Message size"

set term png
set output "result.png"

set datafile separator ","

set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.5
set style line 2 lc rgb '#ad0060' lt 1 lw 2 pt 7 ps 1.5

set xtics ("1KiB" 1024, "1MiB" 1048576, "4MiB" 4194304, "8MiB" 8388608, "16MiB" 16777216)

plot \
  "results/send.csv" using 1:3 title "MPI_Send" with linespoints ls 1, \
  "results/ssend.csv" using 1:3 title "MPI_Ssend"  with linespoints ls 2

