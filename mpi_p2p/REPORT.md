# Omówienie wyników

Poniższy dokument zawiera opis doświadczenia analizę otrzymanych wyników.

## Implementacja

Program został napisany w języku C. Składa się z trzech części:

  * [benchmark.c](https://github.com/fanfilmu/tpr2016/blob/master/mpi_p2p/src/benchmark.c)/[h](https://github.com/fanfilmu/tpr2016/blob/master/mpi_p2p/src/benchmark.h)
    plik zawierający dwie pomocnicze funkcje: `repeat` powtarzającą wykonanie danej funkcji pewną ilość razy i `benchmark`, mierzącą średni czas jednego wykonania funkcji
  * [helpers.c](https://github.com/fanfilmu/tpr2016/blob/master/mpi_p2p/src/helpers.c)/[h](https://github.com/fanfilmu/tpr2016/blob/master/mpi_p2p/src/helpers.h)
    zawiera jedną funkcję inicjalizującą MPI i pobierającą Rank (numer nadany przez MPI procesowi) i Size (ilość procesów)
  * [p2p.c](https://github.com/fanfilmu/tpr2016/blob/master/mpi_p2p/src/p2p.c)
    główny plik zawierający logikę przeprowadzanego testu

W zależności od flagi SSEND ustawionej podczas kompilacji, program wyjściowy może korzystać z metody `MPI_Send` bądź `MPI_Ssend`.

## Metoda

Test przebiega następująco:

  1. Inicjalizacja MPI
  2. Bariera MPI
  3. Inicjalizacja bufora o wielkości 16 MiB
  4. Dopóki `size := 1` jest mniejsze niż 16 MiB:
    1. Wysyłka i odebranie komunikatu o wielkości `size` 100 razy
    2. Zapisanie średniego czasu trwania wysyłania jednego komunikatu
    3. `size := size * 2`
  5. Zamknięcie środowiska MPI

W eksperymencie biorą udział dwa procesy. Tylko jeden z nich - ten, który pierwszy wysyła wiadomość - oblicza przepustowość komunikacji.

## Wyniki

[resultsma]: https://raw.githubusercontent.com/fanfilmu/tpr2016/master/mpi_p2p/result-small.png "Wyniki eksperymentu - małe komunikaty"
[resultmed]: https://raw.githubusercontent.com/fanfilmu/tpr2016/master/mpi_p2p/result-med.png "Wyniki eksperymentu - średnie komunikaty"
[resultbig]: https://raw.githubusercontent.com/fanfilmu/tpr2016/master/mpi_p2p/result-big.png "Wyniki eksperymentu - duże komunikaty"

![Wyniki eksperymentu][resultsma]
![Wyniki eksperymentu][resultmed]
![Wyniki eksperymentu][resultbig]

### Opóźnienia

Dla funkcji `MPI_Send`: 0.001ms

Dla funkcji `MPI_Ssend`: 0.223ms
