set  autoscale

set term png
set key outside

set term png size 1280, 720

set style line 1  lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.5
set style line 2  lc rgb '#ad0060' lt 1 lw 2 pt 7 ps 1.5
set style line 3  lc rgb '#0060ad' lt 1 lw 2 pt 7 ps 1.5
set style line 4  lc rgb '#60ad00' lt 1 lw 2 pt 7 ps 1.5
set style line 5  lc rgb '#00ad60' lt 1 lw 2 pt 7 ps 1.5
set style line 6  lc rgb '#6000ad' lt 1 lw 2 pt 7 ps 1.5
set style line 7  lc rgb '#cc2277' lt 1 lw 2 pt 7 ps 1.5
set style line 8  lc rgb '#77cc22' lt 1 lw 2 pt 7 ps 1.5
set style line 9  lc rgb '#2277cc' lt 1 lw 2 pt 7 ps 1.5


set title "Not scaled; time to processors"
set ylabel "Time [s]"
set xlabel "Number of processors"

set output "not_scaled_time.png"
plot \
  "not_scaled_time.dat" using 1:2  title "44352000"  with linespoints ls 1, \
  "not_scaled_time.dat" using 1:3  title "88704000"  with linespoints ls 2, \
  "not_scaled_time.dat" using 1:4  title "177408000" with linespoints ls 3, \
  "not_scaled_time.dat" using 1:5  title "266112000" with linespoints ls 4, \
  "not_scaled_time.dat" using 1:6  title "354816000" with linespoints ls 5, \
  "not_scaled_time.dat" using 1:7  title "709632000" with linespoints ls 6, \
  "not_scaled_time.dat" using 1:8  title "1064448000" with linespoints ls 7, \
  "not_scaled_time.dat" using 1:9  title "1419264000" with linespoints ls 8, \
  "not_scaled_time.dat" using 1:10 title "1774080000" with linespoints ls 9


set title "Not scaled; speed up to processors"
set ylabel "Speed up metric"
set xlabel "Number of processors"

set output "not_scaled_speed_up.png"
plot \
  "not_scaled_speed_up.dat" using 1:2  title "44352000"  with linespoints ls 1, \
  "not_scaled_speed_up.dat" using 1:3  title "88704000"  with linespoints ls 2, \
  "not_scaled_speed_up.dat" using 1:4  title "177408000" with linespoints ls 3, \
  "not_scaled_speed_up.dat" using 1:5  title "266112000" with linespoints ls 4, \
  "not_scaled_speed_up.dat" using 1:6  title "354816000" with linespoints ls 5, \
  "not_scaled_speed_up.dat" using 1:7  title "709632000" with linespoints ls 6, \
  "not_scaled_speed_up.dat" using 1:8  title "1064448000" with linespoints ls 7, \
  "not_scaled_speed_up.dat" using 1:9  title "1419264000" with linespoints ls 8, \
  "not_scaled_speed_up.dat" using 1:10 title "1774080000" with linespoints ls 9

set title "Not scaled; efficiency to processors"
set ylabel "Efficiency metric"
set xlabel "Number of processors"

set output "not_scaled_efficiency.png"
plot \
  "not_scaled_efficiency.dat" using 1:2  title "44352000"  with linespoints ls 1, \
  "not_scaled_efficiency.dat" using 1:3  title "88704000"  with linespoints ls 2, \
  "not_scaled_efficiency.dat" using 1:4  title "177408000" with linespoints ls 3, \
  "not_scaled_efficiency.dat" using 1:5  title "266112000" with linespoints ls 4, \
  "not_scaled_efficiency.dat" using 1:6  title "354816000" with linespoints ls 5, \
  "not_scaled_efficiency.dat" using 1:7  title "709632000" with linespoints ls 6, \
  "not_scaled_efficiency.dat" using 1:8  title "1064448000" with linespoints ls 7, \
  "not_scaled_efficiency.dat" using 1:9  title "1419264000" with linespoints ls 8, \
  "not_scaled_efficiency.dat" using 1:10 title "1774080000" with linespoints ls 9

set title "Not scaled; serial fraction to processors"
set ylabel "Serial fraction metric"
set xlabel "Number of processors"

set output "not_scaled_serial_fraction.png"
plot \
  "not_scaled_serial_fraction.dat" using 1:2  title "44352000"  with linespoints ls 1, \
  "not_scaled_serial_fraction.dat" using 1:3  title "88704000"  with linespoints ls 2, \
  "not_scaled_serial_fraction.dat" using 1:4  title "177408000" with linespoints ls 3, \
  "not_scaled_serial_fraction.dat" using 1:5  title "266112000" with linespoints ls 4, \
  "not_scaled_serial_fraction.dat" using 1:6  title "354816000" with linespoints ls 5, \
  "not_scaled_serial_fraction.dat" using 1:7  title "709632000" with linespoints ls 6, \
  "not_scaled_serial_fraction.dat" using 1:8  title "1064448000" with linespoints ls 7, \
  "not_scaled_serial_fraction.dat" using 1:9  title "1419264000" with linespoints ls 8, \
  "not_scaled_serial_fraction.dat" using 1:10 title "1774080000" with linespoints ls 9
