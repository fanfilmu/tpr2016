# Omówienie wyników

Poniższy dokument zawiera opis doświadczenia analizę otrzymanych wyników.

## Implementacja

Program został napisany w języku C. Składa się z dwóch plików z kodem źródłowym i szeregiem pomocniczych skryptów.

  * [mpi_helpers.c](https://github.com/fanfilmu/tpr2016/blob/master/pi_mc/src/mpi_helpers.c)/[h](https://github.com/fanfilmu/tpr2016/blob/master/pi_mc/src/mpi_helpers.h)
    zawiera jedną funkcję inicjalizującą MPI i pobierającą Rank (numer nadany przez MPI procesowi) i Size (ilość procesów)
  * [pi_mc.c](https://github.com/fanfilmu/tpr2016/blob/master/pi_mc/src/pi_mc.c)
    główny plik zawierający logikę przeprowadzanego testu

## Metoda

Test przebiega następująco:

  1. Inicjalizacja MPI i seed
  2. Wyliczenie wielkości problemu dla jednej instancji
  3. Bariera MPI
  4. Powtórzenie 10 razy:
    1. Wylosowanie odpowiedniej ilości punktów i zliczenie tych znajdujących się w kole
    2. Propagacja wyliczonej wartości z pomocą MPI_Reduce
  5. Uśrednienie i wypisanie czasu wykonania przez proces Root
  6. Zamknięcie środowiska MPI

Program uruchamiany był z pomocą środowiska Scalarm. Skrypt egzekutora znajduje się [w repozytorium](https://github.com/fanfilmu/tpr2016/blob/master/pi_mc/scripts/new_executor.rb).

## Wyniki

Liczba w legendzie oznacza wielkość problemu, czyli liczbę losowanych punktów przez wszystkie procesy.

W przypadku metryk skalowanych, liczba ta oznacza wielkość problemu w przypadku wykonania z jednym procesorem.

[no_tim]: https://raw.githubusercontent.com/fanfilmu/tpr2016/master/pi_mc/report/not_scaled_time.png "Średni czas wykonania, nie skalowana"
[sc_tim]: https://raw.githubusercontent.com/fanfilmu/tpr2016/master/pi_mc/report/scaled_time.png "Średni czas wykonania, skalowana"

[no_spu]: https://raw.githubusercontent.com/fanfilmu/tpr2016/master/pi_mc/report/not_scaled_speed_up.png "Miara speed up, nie skalowana"
[sc_spu]: https://raw.githubusercontent.com/fanfilmu/tpr2016/master/pi_mc/report/scaled_speed_up.png "Miara speed up, skalowana"

[no_efi]: https://raw.githubusercontent.com/fanfilmu/tpr2016/master/pi_mc/report/not_scaled_efficiency.png "Miara efficiency, nie skalowana"
[sc_efi]: https://raw.githubusercontent.com/fanfilmu/tpr2016/master/pi_mc/report/scaled_efficiency.png "Miara efficiency, skalowana"

[no_krp]: https://raw.githubusercontent.com/fanfilmu/tpr2016/master/pi_mc/report/not_scaled_serial_fraction.png "Miara Karpa-Flatta, nie skalowana"
[sc_krp]: https://raw.githubusercontent.com/fanfilmu/tpr2016/master/pi_mc/report/scaled_serial_fraction.png "Miara Karpa-Flatta, skalowana"

![Wyniki eksperymentu][no_tim]
![Wyniki eksperymentu][no_spu]
![Wyniki eksperymentu][no_efi]
![Wyniki eksperymentu][no_krp]

![Wyniki eksperymentu][sc_tim]
![Wyniki eksperymentu][sc_spu]
![Wyniki eksperymentu][sc_efi]
![Wyniki eksperymentu][sc_krp]
