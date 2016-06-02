set datafile separator ","

set terminal png size 1024,768
set output 'result.png'

set logscale x 2
set logscale y 10

set title "Adding vectors - time to the problem size"

set ylabel "time elapsed [ms]"
set xlabel "problem size"

set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.5
set style line 2 lc rgb '#60ad00' lt 1 lw 2 pt 7 ps 1.5

plot 'result.csv' using 1:4 with linespoints ls 1 title "CPU time", \
     'result.csv' using 1:5 with linespoints ls 2 title "GPGPU time"
