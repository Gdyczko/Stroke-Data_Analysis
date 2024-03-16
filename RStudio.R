# Loading data and checking its structure

# Loading a table with data in CSV format
dane <- read.csv("healthcare-dataset-stroke-data.csv")

# Previewing and checking the structure of the data
head(dane)
str(dane)

# Data cleaning and imputation of missing values

# Checking for the presence of NA values
dane[!complete.cases(dane), ]

# As can be seen from the applied function, our data does not have missing values NA. 
# However, it should be noted that, although it is visible when using the str() function,
# we have NA values in the bmi column, but due to the entry "N/A," the R program
# interprets it as text rather than a missing value.


# Listing values of "N/A"
dane[dane == "N/A"]

# Replacing values of "N/A" with NA
dane[dane == "N/A"] <- NA

# Checking again for the presence of NA values
dane[!complete.cases(dane), ]

# Checking the data structure again
str(dane)

# Converting the data class of the bmi variable from character to numeric
dane$bmi <- as.numeric(dane$bmi)

# Checking the mean and median with NA values excluded
mean(dane$bmi, na.rm = TRUE)
median(dane$bmi, na.rm = TRUE)

# Imputing NA values with the median
dane$bmi[is.na(dane$bmi)] <- median(dane$bmi, na.rm = TRUE)

# Checking the summary of the bmi column data now
summary(dane$bmi)

# Checking once again for any missing values
dane[!complete.cases(dane), ]

# Removing cells with ID numbers that do not contribute to our analysis
head(dane[,-1]) # sprawdzenie czy wszystko się zgadza 
dane <- dane[, -1] # nadpisanie danych z pominięciem kolumny pierwszej "ID"


# Correcting variable formats

# gender #

# Checking the correctness of data encoding as factors
summary(factor(dane$gender)) 

# There is one value "other" that should not be considered in the analysis.
# Since the dataset is large, its absence will not significantly affect the
# obtained results.                                                      


# Observing the record(s) where the gender column has the value "Other"
dane[dane$gender == "Other", ]

# Saving the data without the entire row containing the value "Other" in the gender column
dane <- dane[!dane$gender == "Other", ]

# Rechecking the correctness of data encoding as factors
summary(factor(dane$gender))

# Transforming data from the gender column into a factor type
dane$gender <- factor(dane$gender)

# Checking the correctness of data encoding and overwriting it
summary(dane$gender)

# hypertension, heart_disease i stroke #

# We have three binary variables, which have been encoded as 0 and 1, where
# 0 represents "No" and 1 represents "Yes". Since these three variables have
# the same data (0 or 1), we can automate the process and convert all of them
# at once into a factor type and assign labels "No" and "Yes".

# Creating a vector with binary data that needs to be changed
zmienneBinarne <- c("hypertension", "heart_disease", "stroke")

# Previewing the subset of data - three at a time
lapply(dane[, zmienneBinarne], function(x){summary(factor(x))}) # Looks good, so let's apply it

# Converting data in hypertension, heart_disease, and stroke columns to factors
dane[, zmienneBinarne] <- lapply(dane[, zmienneBinarne], factor,
                                 levels = c(0, 1),
                                 labels = c("No", "Yes")
                                 )

# Checking if the transformation has been carried out correctly
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

# Checking the data structure again to see if any data is left for processing
str(dane)


# Statistical analysis

# Calculating the 25% and 75% quantiles of age from the sample
quantile(dane$age, c(p=0.25, p=0.75))

# Youngest age among the participants
min(dane$age)

# Oldest age among the participants
max(dane$age)

# Mean age of the participants
mean(dane$age)

# Calculating the standard deviation
sd(dane$age)

# Calculating skewness
install.packages("moments") # Installing the moments package
library(moments) # Loading the package 
skewness(dane$age) # Skewness

# From the conducted statistical analysis, it can be inferred that both children and 
# older individuals participated in the study. The youngest child was less than a month old (0.08), 
# while the oldest participant was 82 years old. The average age for the study group is around 43 years. 
# The standard deviation, indicating the spread of data from the mean value, is 22.61358. Additionally, 
# it was observed that the distribution of analyzed age data exhibits slight left-skewness (approximately -0.14), 
# suggesting that there are slightly more individuals above the age of 43 in our study group. During the conducted 
# research, half of the respondents (50%) were aged between 25 and 61 years.


# Data Visualization

# Installing additional packages that may be useful during the analysis
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

# Barplot for employment type
barplot(summary(dane$work_type),
        main = "Number of people by employment",
        ylim = c(0, 3000),
        ylab = "Number of people",
        xlab = "Type of work",
        col = viridis(5))

# The above barplot represents the number of respondents, depending on the type of employment.    
# Within the five declared categories, besides people employed in private enterprises (Private),  
# government jobs (Government job), and self-employed (Self-employed), there were also people who 
# had never worked (Never worked) and a group of children.                                        
# From the analysis, it follows that the dominant group in the study were people who declared that 
# they work in private enterprises (close to 3000 people), several times more numerous than other  
# categories. The group of people declaring work in government institutions is very similar in     
# number to the number of children participating in the study. Slightly more numerous are the      
# people working in their own companies (self-employed), with just over 800 people. The least      
# numerous group consisted of people who had never worked.                                          


# Boxplot for BMI level by place of residence
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

# The above plot shows the BMI index level in respondents according to their place of residence.
# Additionally, a dashed blue line indicating the maximum correct BMI level (MAX corect BMI)   
# at 24.9 is marked on the plot. From the analysis, it follows that most people (about 75%),    
# regardless of their place of residence, have a BMI above the norm. Rural residents exhibit a  
# greater diversity of BMI values (a larger spread of data by about 20 points) than urban       
# residents. Half of the respondents, both rural and urban, have a BMI ranging from about 24    
# to 33 points.                                                                                


# Boxplot for BMI level by type of work
boxplot(dane$bmi ~ dane$work_type,
        range = 0,
        main = "BMI level by type of work",
        ylab = "BMI",
        xlab = "Work type",
        col = viridis(5))
abline(h=24.9, col="red", lty = 5, lwd = 2)
text(28, "MAX correct BMI", col = "red", cex = 1.3)


# The plot "BMI level by type of work" presents the range of BMI values depending on the type   
# of work performed. Also, in this plot as in the previous one, a dashed red line, which        
# indicates the upper limit of the correct BMI level (MAX corect BMI), was marked. From the     
# analyzed plot, it can be inferred that most respondents present a BMI value above the norm,   
# regardless of the type of employment. Only people who have never worked are within the normal 
# BMI range in about 50% of the cases. An exception on the plot is the group of children, who   
# in a significant part (over 75% of respondents) have BMI below the upper limit of the normal  
# body mass. The group of respondents working in the private sector presents the widest range   
# of BMI values, and there are people with the highest BMI index.                               


# Checking if there are strong correlations between any of the data among all the data
model.matrix(~0+., data = dane) %>% 
  cor(use="pairwise.complete.obs") %>% 
  ggcorrplot(show.diag = FALSE,
             type="lower", 
             lab=TRUE, 
             lab_size=3,
             title = "Corelation between all data")

# The "Corelation between all data" plot presents the results of the correlations between  
# all examined factors. Thanks to this approach, the plot itself indicates possible        
# correlations between individual factors. From the plot, it can be seen that there is      
# practically no correlation between the examined factors or it is very weak, and in some   
# cases moderate. The visualization mainly takes positive values, but there are also        
# negative values in the case of people who did not provide smoking status. Since the        
# research was collected to conduct analyses regarding the occurrence of stroke, interpreting
# the above plot, it can be inferred that no factors (e.g., smoking, heart attacks, high blood
# pressure) were found to have a significant impact on the occurrence of this disease.       
# Correlation with any factor does not exceed the value of 0.25. The only strong correlation
# appearing in the visualization is between age and marital status. This is a positive      
# correlation and it is 0.68. It means that the older the person, the higher the probability
# that they are or have been in a marital relationship.                                      
