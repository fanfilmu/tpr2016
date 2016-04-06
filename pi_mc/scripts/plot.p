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
set style line 10 lc rgb '#7722cc' lt 1 lw 2 pt 7 ps 1.5


set title "Not scaled; time to processors"
set ylabel "Time [s]"
set xlabel "Number of processors"

set output "report/not_scaled_time.png"
plot \
  "results/not_scaled_time.dat" using 1:2  title "5544000"  with linespoints ls 1, \
  "results/not_scaled_time.dat" using 1:3  title "9979200"  with linespoints ls 2, \
  "results/not_scaled_time.dat" using 1:4  title "14414400" with linespoints ls 3, \
  "results/not_scaled_time.dat" using 1:5  title "18849600" with linespoints ls 4, \
  "results/not_scaled_time.dat" using 1:6  title "23284800" with linespoints ls 5, \
  "results/not_scaled_time.dat" using 1:7  title "27720000" with linespoints ls 6, \
  "results/not_scaled_time.dat" using 1:8  title "32155200" with linespoints ls 7, \
  "results/not_scaled_time.dat" using 1:9  title "36590400" with linespoints ls 8, \
  "results/not_scaled_time.dat" using 1:10 title "41025600" with linespoints ls 9, \
  "results/not_scaled_time.dat" using 1:11 title "45460800" with linespoints ls 10

set title "Not scaled; speed up to processors"
set ylabel "Speed up metric"
set xlabel "Number of processors"

set output "report/not_scaled_speed_up.png"
plot \
  "results/not_scaled_speed_up.dat" using 1:2  title "5544000"  with linespoints ls 1, \
  "results/not_scaled_speed_up.dat" using 1:3  title "9979200"  with linespoints ls 2, \
  "results/not_scaled_speed_up.dat" using 1:4  title "14414400" with linespoints ls 3, \
  "results/not_scaled_speed_up.dat" using 1:5  title "18849600" with linespoints ls 4, \
  "results/not_scaled_speed_up.dat" using 1:6  title "23284800" with linespoints ls 5, \
  "results/not_scaled_speed_up.dat" using 1:7  title "27720000" with linespoints ls 6, \
  "results/not_scaled_speed_up.dat" using 1:8  title "32155200" with linespoints ls 7, \
  "results/not_scaled_speed_up.dat" using 1:9  title "36590400" with linespoints ls 8, \
  "results/not_scaled_speed_up.dat" using 1:10 title "41025600" with linespoints ls 9, \
  "results/not_scaled_speed_up.dat" using 1:11 title "45460800" with linespoints ls 10

set title "Not scaled; efficiency to processors"
set ylabel "Efficiency metric"
set xlabel "Number of processors"

set output "report/not_scaled_efficiency.png"
plot \
  "results/not_scaled_efficiency.dat" using 1:2  title "5544000"  with linespoints ls 1, \
  "results/not_scaled_efficiency.dat" using 1:3  title "9979200"  with linespoints ls 2, \
  "results/not_scaled_efficiency.dat" using 1:4  title "14414400" with linespoints ls 3, \
  "results/not_scaled_efficiency.dat" using 1:5  title "18849600" with linespoints ls 4, \
  "results/not_scaled_efficiency.dat" using 1:6  title "23284800" with linespoints ls 5, \
  "results/not_scaled_efficiency.dat" using 1:7  title "27720000" with linespoints ls 6, \
  "results/not_scaled_efficiency.dat" using 1:8  title "32155200" with linespoints ls 7, \
  "results/not_scaled_efficiency.dat" using 1:9  title "36590400" with linespoints ls 8, \
  "results/not_scaled_efficiency.dat" using 1:10 title "41025600" with linespoints ls 9, \
  "results/not_scaled_efficiency.dat" using 1:11 title "45460800" with linespoints ls 10

set title "Not scaled; serial fraction to processors"
set ylabel "Serial fraction metric"
set xlabel "Number of processors"

set output "report/not_scaled_serial_fraction.png"
plot \
  "results/not_scaled_serial_fraction.dat" using 1:2  title "5544000"  with linespoints ls 1, \
  "results/not_scaled_serial_fraction.dat" using 1:3  title "9979200"  with linespoints ls 2, \
  "results/not_scaled_serial_fraction.dat" using 1:4  title "14414400" with linespoints ls 3, \
  "results/not_scaled_serial_fraction.dat" using 1:5  title "18849600" with linespoints ls 4, \
  "results/not_scaled_serial_fraction.dat" using 1:6  title "23284800" with linespoints ls 5, \
  "results/not_scaled_serial_fraction.dat" using 1:7  title "27720000" with linespoints ls 6, \
  "results/not_scaled_serial_fraction.dat" using 1:8  title "32155200" with linespoints ls 7, \
  "results/not_scaled_serial_fraction.dat" using 1:9  title "36590400" with linespoints ls 8, \
  "results/not_scaled_serial_fraction.dat" using 1:10 title "41025600" with linespoints ls 9, \
  "results/not_scaled_serial_fraction.dat" using 1:11 title "45460800" with linespoints ls 10

set title "Scaled; time to processors"
set ylabel "Time [s]"
set xlabel "Number of processors"

set output "report/scaled_time.png"
plot \
  "results/scaled_time.dat" using 1:2  title "5544000"  with linespoints ls 1, \
  "results/scaled_time.dat" using 1:3  title "9979200"  with linespoints ls 2, \
  "results/scaled_time.dat" using 1:4  title "14414400" with linespoints ls 3, \
  "results/scaled_time.dat" using 1:5  title "18849600" with linespoints ls 4, \
  "results/scaled_time.dat" using 1:6  title "23284800" with linespoints ls 5, \
  "results/scaled_time.dat" using 1:7  title "27720000" with linespoints ls 6, \
  "results/scaled_time.dat" using 1:8  title "32155200" with linespoints ls 7, \
  "results/scaled_time.dat" using 1:9  title "36590400" with linespoints ls 8, \
  "results/scaled_time.dat" using 1:10 title "41025600" with linespoints ls 9, \
  "results/scaled_time.dat" using 1:11 title "45460800" with linespoints ls 10

set title "Scaled; speed up to processors"
set ylabel "Speed up metric"
set xlabel "Number of processors"

set output "report/scaled_speed_up.png"
plot \
  "results/scaled_speed_up.dat" using 1:2  title "5544000"  with linespoints ls 1, \
  "results/scaled_speed_up.dat" using 1:3  title "9979200"  with linespoints ls 2, \
  "results/scaled_speed_up.dat" using 1:4  title "14414400" with linespoints ls 3, \
  "results/scaled_speed_up.dat" using 1:5  title "18849600" with linespoints ls 4, \
  "results/scaled_speed_up.dat" using 1:6  title "23284800" with linespoints ls 5, \
  "results/scaled_speed_up.dat" using 1:7  title "27720000" with linespoints ls 6, \
  "results/scaled_speed_up.dat" using 1:8  title "32155200" with linespoints ls 7, \
  "results/scaled_speed_up.dat" using 1:9  title "36590400" with linespoints ls 8, \
  "results/scaled_speed_up.dat" using 1:10 title "41025600" with linespoints ls 9, \
  "results/scaled_speed_up.dat" using 1:11 title "45460800" with linespoints ls 10

set title "Scaled; efficiency to processors"
set ylabel "Efficiency metric"
set xlabel "Number of processors"

set output "report/scaled_efficiency.png"
plot \
  "results/scaled_efficiency.dat" using 1:2  title "5544000"  with linespoints ls 1, \
  "results/scaled_efficiency.dat" using 1:3  title "9979200"  with linespoints ls 2, \
  "results/scaled_efficiency.dat" using 1:4  title "14414400" with linespoints ls 3, \
  "results/scaled_efficiency.dat" using 1:5  title "18849600" with linespoints ls 4, \
  "results/scaled_efficiency.dat" using 1:6  title "23284800" with linespoints ls 5, \
  "results/scaled_efficiency.dat" using 1:7  title "27720000" with linespoints ls 6, \
  "results/scaled_efficiency.dat" using 1:8  title "32155200" with linespoints ls 7, \
  "results/scaled_efficiency.dat" using 1:9  title "36590400" with linespoints ls 8, \
  "results/scaled_efficiency.dat" using 1:10 title "41025600" with linespoints ls 9, \
  "results/scaled_efficiency.dat" using 1:11 title "45460800" with linespoints ls 10

set title "Scaled; serial fraction to processors"
set ylabel "Serial fraction metric"
set xlabel "Number of processors"

set output "report/scaled_serial_fraction.png"
plot \
  "results/scaled_serial_fraction.dat" using 1:2  title "5544000"  with linespoints ls 1, \
  "results/scaled_serial_fraction.dat" using 1:3  title "9979200"  with linespoints ls 2, \
  "results/scaled_serial_fraction.dat" using 1:4  title "14414400" with linespoints ls 3, \
  "results/scaled_serial_fraction.dat" using 1:5  title "18849600" with linespoints ls 4, \
  "results/scaled_serial_fraction.dat" using 1:6  title "23284800" with linespoints ls 5, \
  "results/scaled_serial_fraction.dat" using 1:7  title "27720000" with linespoints ls 6, \
  "results/scaled_serial_fraction.dat" using 1:8  title "32155200" with linespoints ls 7, \
  "results/scaled_serial_fraction.dat" using 1:9  title "36590400" with linespoints ls 8, \
  "results/scaled_serial_fraction.dat" using 1:10 title "41025600" with linespoints ls 9, \
  "results/scaled_serial_fraction.dat" using 1:11 title "45460800" with linespoints ls 10
