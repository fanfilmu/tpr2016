set datafile separator ","

set terminal png size 1024,768
set output 'threads.png'

set logscale y 2

set title "GPU efficiency - time to thread amount"

set ylabel "time elapsed [ms]"
set xlabel "amount of threads"

set style line 1 lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.5
set style line 2 lc rgb '#60ad00' lt 1 lw 2 pt 7 ps 1.5
set style line 3 lc rgb '#ad0060' lt 1 lw 2 pt 7 ps 1.5
set style line 4 lc rgb '#00ad60' lt 1 lw 2 pt 7 ps 1.5
set style line 5 lc rgb '#ad6000' lt 1 lw 2 pt 7 ps 1.5

plot 'threads.dat' using 1:7 with linespoints ls 1 title "2097152", \
     'threads.dat' using 1:8 with linespoints ls 2 title "4194304", \
     'threads.dat' using 1:9 with linespoints ls 3 title "8388608", \
     'threads.dat' using 1:10 with linespoints ls 4 title "16777216", \
     'threads.dat' using 1:11 with linespoints ls 5 title "33554432"

