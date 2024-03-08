

###############################################
# Wczytanie danych i sprawdzenie jej struktury
###############################################


# wczytanie tabeli z danymi w formacie csv
dane <- read.csv("healthcare-dataset-stroke-data.csv")

# podgląd i sprawdzenie struktury danych
head(dane)
str(dane)


#########################################################
# czyszczenie danych i uzupełnianie wartości brakujących 
#########################################################


# Sprawdzenie czy występują wartości NA
dane[!complete.cases(dane), ]

############################################################################################
##                                                                                        ##  
##  jak widać według zastosowanej funkcji nasze dane nie posiadają wartości brakujący     ##
##  NA jednakże należey zauwacyć, chociażby widać to przy funkcji str() mamy wartości     ##
##  NA w kolumnie bmi ale ze względu na zapis "N/A" program R, czyta to jako tekst a nie  ##
##  wartość brakującą                                                                     ##
##                                                                                        ##
############################################################################################

# wylistowanie wartości "N/A"
dane[dane == "N/A"]

# zamiana wartości "N/A" na NA
dane[dane == "N/A"] <- NA

# sprawdzenie ponownie czy są wartości NA
dane[!complete.cases(dane), ]

# sprawdzenie ponownie struktury danych
str(dane)

# zamiana klasy danych bmi z typu character na numeric
dane$bmi <- as.numeric(dane$bmi)

# sprawdzenie średniej i mediany z pominięciem wartości NA
mean(dane$bmi, na.rm = TRUE)
median(dane$bmi, na.rm = TRUE)

# uzupełnienie wartości NA medianą
dane$bmi[is.na(dane$bmi)] <- median(dane$bmi, na.rm = TRUE)

# sprawdzenie jak teraz wygladają dane z kolumny bmi podsumowane
summary(dane$bmi)

# sprawdzenie jeszcze raz czy nie ma wartości barkujących
dane[!complete.cases(dane), ]

# usunięcie nic nie wnoszącej do naszej analizy komórki z numerami ID
head(dane[,-1]) # sprawdzenie czy wszystko się zgadza 
dane <- dane[, -1] # nadpisanie danych z pominięciem kolumny pierwszej "ID"


#################################
# korygowanie formatów zmiennych
#################################


# gender #

# sprawdzenie poprawności zapisu danych jako factor
summary(factor(dane$gender)) 

##############################################################################
##  jest jedna wartość "other" którą należy nie brać do analiz pod uwagę,   ##
##  zbiór jest duży, więc jej brak, nie wpłynie w znaczący sosób na zmianę  ##
##  otrzymanych wyników                                                     ##
##############################################################################

# podpatrzenie danej, która w kolumnie gender posiada wartość "Other"
dane[dane$gender == "Other", ]

# zapisanie danych bez całego wiersza zawierającego w kolumnie gender wartość "Other"
dane <- dane[!dane$gender == "Other", ]

# ponowne sprawdzenie poprawności zapisu danych jako factor
summary(factor(dane$gender))

# przekształcenie danych z kolumny gender na typ factor
dane$gender <- factor(dane$gender)

# sprawdzenie poprawności zapisu danych i ich nadpisania
summary(dane$gender)


# hypertension, heart_disease i stroke #

####################################################################################
##  mamy trzy zmienne binarne, które zostały zapisane w postaci 0 i 1 gdzie       ##
##  0 oznacza nie, natomiast 1 tak. W związku z tym, że te trzy zmienne posiadają ##
##  takie same dane (0 lub 1) możemy je zautomatyzować i wszytskie na raz         ##
##  przekształcić na typ factor i nadać im etykiety "No" i "Yes"                  ##
####################################################################################

# utworzenie wektora z danymi binarnymi, które są do zmiany
zmienneBinarne <- c("hypertension", "heart_disease", "stroke")

# podgląd podusmowanych danych - trzech na raz
lapply(dane[, zmienneBinarne], function(x){summary(factor(x))}) # wygląda ok, więc zastosujmy

# zamiana danych hypertension, heart_disease i stroke na factor
dane[, zmienneBinarne] <- lapply(dane[, zmienneBinarne], factor,
                                 levels = c(0, 1),
                                 labels = c("No", "Yes")
                                 )

# sprwwdzenie czy przekształcenie przebiegło w sposób prawidłowy
summary(dane[, zmienneBinarne])

str(dane) # podpatrzenie struktury co jest jeszcze do zmiany 


# ever_married #
summary(factor(dane$ever_married))
dane$ever_married <- factor(dane$ever_married)
summary(dane$ever_married)


# work_type
summary(factor(dane$work_type))
dane$work_type <- factor(dane$work_type,
                         levels = c("children", "Govt_job", "Never_worked", 
                                    "Private", "Self-employed"),
                         labels = c("Children", "Government job", "Never worked", 
                                    "Private", "Self-employed")
                         )
summary(dane$work_type)


# Residence_type
summary(factor(dane$Residence_type))
dane$Residence_type <- factor(dane$Residence_type)


# smoking_status
summary(factor(dane$smoking_status))
dane$smoking_status <- factor(dane$smoking_status,
                              levels = c("never smoked", "formerly smoked",
                                         "smokes", "Unknown"),
                              labels = c("never smoked", "formerly smoked",
                                         "smokes", "unknown")
                            )
summary(dane$smoking_status)

# sprawdzenie ponownie struktury czy jakieś dane zostały do przetworzenia
str(dane)


#######################
# Analiza statystyczna
#######################


# Obliczenie dla wieku kwantylu na poziomie 25% i 75% z próby
quantile(dane$age, c(p=0.25, p=0.75))

# najmłodszy wiekiem z badanych osób
min(dane$age)

# najstarszy wiekiem z badanych osób
max(dane$age)

# średnia wieku u badanych
mean(dane$age)

# obliczenie odchylenia standardowego 
sd(dane$age)

# obliczenie skośności
install.packages("moments") # instalacja pakietu moments
library(moments) # załadowanie pakietu 
skewness(dane$age) # skośność

############################################################################################
# Z przeprowadzonych analiz ststystycznych można wywnioskować, że w badaniach brały udział #  
# zarówno dzieci jak i osoby starsze. Najmłodzsze dziecko miało niecały miesiąc (0,08),    #
# natomiast najstarsza badana osoba miała 82 lata. Średnia wieku dla badanej grópy wynosi  #
# około 43 lata. Odchylenie standardowe mówiące o rozrzucie danych od wartości średniej    #
# wynosi 22.61358. Zaobserwowano również, że rozkład analizowanych danych dotyczących      #
# wieku przyjmuje lekką asymetrię lewostronną (około -0,14), co oznacza, że w naszej       #
# badanej grópie jest trochę wiecej osób z wiekiem powyżej 43 roku życia. Podczas          #
# przeprowadzonych badań, połowa respondentów (50%) była w wieku w przedziale 25 - 61 lat. #  
############################################################################################


######################
# Wizualizacja danych
######################


# instalacja dodatkowych pakeitów, które mogą nam się przydać podzczas prowadzonych analiz
install.packages("ggplot2")
install.packages("tidyr")
install.packages("ggcorrplot")
install.packages("viridis")
install.packages("corrplot")
install.packages("wesanderson")
library(ggplot2)
library(tidyr)
library(ggcorrplot)
library(viridis)
library(corrplot)
library(wesanderson)


# wykres dotyczący rodzaju zatrudnienia
barplot(summary(dane$work_type),
        main = "Number of people by employment",
        ylim = c(0, 3000),
        ylab = "Number of people",
        xlab = "Type of work",
        col = viridis(5))

###################################################################################################
# Wykres przedstawia liczbę badanych, w zależności od rodzaju zatrudnienia. W ramach pięciu       #
# zadeklarowanych kategrii obok osób zatrudnionych w prywatnych przedsiębiorstwach (Private)      #
# jak i jednostkach rządowych (Government job) oraz samozatrudninych (Self-employed) znalały się  #
# osoby, które nigdy nie pracowały (Never worked) oraz grupa dzieci (Children).                   #
# Z przeprowadzonej analizy wynika, że dominującą grupą w badaniu były osoby, które               #
# deklarowały, iż pracują w przedsiębiorstwach prywatnych (blisko 3000 osób), kilkakrotnie        #
# przewyższając liczebnie pozostałe kategorie. Grupa osób deklarujących pracę w jednostkach       #
# rządowych jest bardzo zbliżona do liczby dzieci biorących udział w badaniu. Nieznacznie         #
# liczniejszą grupę stanowią osoby pracujące we własnych firmach (samozatrudnione), jest nieco    #
# ponad 800 osób. Natomiast najmniej liczącą grupę stanowiły osoby, kótre nigdny nie pracowały.   #
###################################################################################################

# wykres dotyczący poziomu BMI według miejsca zmaieszkania
boxplot(dane$bmi ~ dane$Residence_type,
        range = 0,
        main = "BMI level by place of residence",
        ylab = "BMI",
        ylim = range(0:100),
        yaxt = "n",
        xlab = "", xaxt ="n",
        col = wes_palette("Royal1"))
axis(2, at = seq(0, 100, 10))
legend("topright", 
       title = "Place of residence:",
       c("Rural", "Urban"),
       fill = wes_palette("Royal1"))
abline(h=24.9, col="blue", lty = 5, lwd = 2)
text(21.5, "MAX correct BMI", col = "blue", pos = 2, cex = 1.3)

################################################################################################
# Powyższy wykres przedstawia poziom indeksu BMI u badanych osób według                        #
# miejsca zamieszkania. Dodatkowo na wykresie zaznaczono przerywaną niebieską linię            #
# przedstawiającą maksymlany poziom prawidłowego BMI (MAX corect BMI) na poziomie 24.9.        #
# Z przeprowadzonej analizy wynika, że większość osób (ok. 75%), niezaleźnie od miejsca        #
# zamieszkania, ma poziom BMI powyżej normy. U ludzi mieszkających na wsi występuje większa    #
# różnorodność wartości BMI (większy rozrzut danych o ok. 20 pkt) niż u ludzi mieszkających    #
# w mieście. Połowa badanych osób, zarówno tych mieszkających na wsi jak i w mieście ma BMI na #
# poziomie od ok. 24 do 33 punktów.                                                            #
################################################################################################

# wykres dotyczący poziomu BMI według typu pracy
boxplot(dane$bmi ~ dane$work_type,
        range = 0,
        main = "BMI level by type of work",
        ylab = "BMI",
        xlab = "Work type",
        col = viridis(5))
abline(h=24.9, col="red", lty = 5, lwd = 2)
text(28, "MAX correct BMI", col = "red", cex = 1.3)

#################################################################################################
# Wykres "BMI level by type of work" przedstawia zakres wartości BMI w zależoności od rodzaju   #
# wykonywanej pracy. Również w tym wykresie jak i poprzednim naniesiono dodatkowo czerwoną      #
# przerywaną linię, która wskazuje górną granicę prawidłowego poziomu BMI (MAX corect BMI).     #
# Z analizowanego wykresu możemy wywnioskować, że większość badanych prezentuje wartość BMI     #
# powyżej normy niezależnie od rodzaju ztrudnienia. Jedynie osoby nigdy nie pracujące w ok. 50% #
# mieszczą się w granicach prawidłowego BMI. Wyjątkiem na wykresie jest grupa badanych dzieci,  #
# które w znaczenj części (ponad 75% badanych) znajdują się poniżej górnej granicy prawidłowej  #
# masy ciała. Grupa badanych, pracująca w sektorze prywatnym prezentuje najszerszy zakres       #
# wartości BMI oraz znajdują się osoby z najwyższym wskaźniekiem BMI.                           #
#################################################################################################

# sprawdzenie czy występują silne korelacje pomiędzy którymiś danymi z psośród wszystkich danych
model.matrix(~0+., data = dane) %>% 
  cor(use="pairwise.complete.obs") %>% 
  ggcorrplot(show.diag = FALSE,
             type="lower", 
             lab=TRUE, 
             lab_size=3,
             title = "Corelation between all data")

############################################################################################
# Wykres "Corelation between all data" prezentuje wyniki zależnośći pomiędzy wszytskimi    #
# badanymi czynikami. Dzięki takiemu zabiegowi wykres sam wskazuje możliwe istneijące      #
# korelacje pomiędzy poszczegónymi czynnikami. Z wykresu wynika, że pomiędzy badanymi      #
# czynnikami praktycznie nie ma żadnej korelacji lub jest ona bardzo słaba, a w niektórych #
# przypadkach umiarkowana. Wizualizacja głównie przyjmuje wartości dodatnie, ale wystęują  #
# również wartości ujemne w przypadku osób, które nie podały statusu palenia. Ze względu   #
# na fak iż badania zebrano w celu przeprowadzenia analiz dotyczących występowania udaru,  #
# interpretując powyższy wykres możemy wywnioskować, że nie odnaleziono żadnych czynników  #
# (np. palenie tytoniu, zawały serca, nadciśnienie), które miałby by istotny wpływ na      #
# pojawienie się tej choroby. Korelacja z żadnym czynnikiem nie przekracza wartości 0,25.  #
# Jedyna silna korelacja jak pojawia sie wizualizacji dotyczy wieku i bycia w związku      #
# małżeńskim. Jest to korelacja dodatnia i wynosi 0,68. Oznacza to, że im osoba jest       #
# starza tym większe prawdopodobieństo, że znajduje się lub znajdowała się w związku       #
# małżeńskim.                                                                              #
############################################################################################
