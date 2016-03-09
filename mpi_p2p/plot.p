set  autoscale

set title "MPI Point to Point bandwidth test"
set ylabel "Bandwidth [MiB/s]"
set xlabel "Message size"

set term png
set datafile separator ","

set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.5
set style line 2 lc rgb '#ad0060' lt 1 lw 2 pt 7 ps 1.5

set xtics ("1B" 1, "32B" 32, "256B" 256, "512B" 512, \
           "1KiB" 1024, "16KiB" 16384, "32KiB" 32768, "64 KiB" 65536, \
           "4MiB" 4194304, "8MiB" 8388608, "16MiB" 16777216)

set output "result-small.png"
plot \
  "results/send.csv"  every ::1::10 using 1:3 title "MPI_Send"  with linespoints ls 1, \
  "results/ssend.csv" every ::1::10 using 1:3 title "MPI_Ssend" with linespoints ls 2

set output "result-med.png"
plot \
  "results/send.csv"  every ::11::16 using 1:3 title "MPI_Send"  with linespoints ls 1, \
  "results/ssend.csv" every ::11::16 using 1:3 title "MPI_Ssend" with linespoints ls 2

set output "result-big.png"
plot \
  "results/send.csv"  every ::17::26 using 1:3 title "MPI_Send"  with linespoints ls 1, \
  "results/ssend.csv" every ::17::26 using 1:3 title "MPI_Ssend" with linespoints ls 2
