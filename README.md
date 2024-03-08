# Stroke_analiza_danych_R
* Pozyskaną bazę danych poddano analizie w celu ustalenia, czy isnieją jakieś czynniki, które wpływają na zwiększenie ryzyka udaru.
* Dodatkowo przeanalizowano wskaźnik BMI u osób biorących udział w badaniu, w celu sprawdzenia czy miejsce zamieszkania lub rodzaj wykonywanej pracy ma wpływ na poziom tego wskaźnika.

## Czszczenie danych
* Po wczytaniu bazy danych, sprawdzono jej struktórę oraz watości brakujące. Według zastosowanej funkcji nasze dane nie posiadają wartości brakujący NA jednakże przy zastosowaniu funkcji str() zauważono, że występują wartości NA w kolumnie bmi ale ze względu na zapis "N/A" program R, czyta to jako tekst a nie jako wartość brakujące.
* Wartości barkujące zastąpiono medianą.
* Uporzadkowano klasy zgodnie z posiadanymi danymi oraz usunięto niepotrzebne do analiz kolumny.
* Sprawdzono poprawność zapisu danych.
* Dane zapisane w sposób binarny przekształcono na dane typu Factor i nadano im stosowne etykiety.
* Tam, gdzie było to możliwe proces ten zautomatyzowano.

## Analiza statystyczna
Z przeprowadzonych analiz ststystycznych można wywnioskować, że w badaniach brały udział zarówno dzieci jak i osoby starsze. Najmłodzsze dziecko miało niecały miesiąc (0,08), natomiast najstarsza badana osoba miała 82 lata. Średnia wieku dla badanej grópy wynosi około 43 lata. Odchylenie standardowe mówiące o rozrzucie danych od wartości średniej wynosi 22.61358. Zaobserwowano również, że rozkład analizowanych danych dotyczących wieku przyjmuje lekką asymetrię lewostronną (około -0,14), co oznacza, że w naszej badanej grópie jest trochę wiecej osób z wiekiem powyżej 43 roku życia. Podczas przeprowadzonych badań, połowa respondentów (50%) była w wieku w przedziale 25 - 61 lat.

## Wizualizacja danych
![alt text](https://github.com/Gdyczko/Stroke_analiza_danych_R/blob/main/Number%20of%20people%20by%20employment.png "Rodzaj zatrudnienia")
