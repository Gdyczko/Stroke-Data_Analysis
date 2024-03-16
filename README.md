# Stroke Data Analysis
* The acquired dataset underwent analysis to determine whether there are any factors influencing the increased risk of stroke.
* Additionally, the BMI index among study participants was analyzed to check if the place of residence or type of work has an impact on this indicator.

## Dataset
The dataset contains information about patients and their health problems as well as lifestyle. The dataset consists of 12 columns and 5111 rows. The dataset was downloaded from [Kaggle](https://www.kaggle.com/datasets/fedesoriano/stroke-prediction-dataset) and includes information about:
* patient ID
* gender
* hypertension
* heart disease
* marital status
* type of work
* place of residence
* average glucose level
* BMI
* smoking status
* history of stroke

Full information about the data contained in each column and their type can be found in the provided [description.](https://github.com/Gdyczko/Stroke_analiza_danych_R/blob/main/Context.txt)

## Data Cleaning
* After loading the dataset, its structure and missing values were checked. According to the applied function, our data does not contain missing NA values. However, when using the str() function, it was noticed that there are NA values in the BMI column, but due to the "N/A" notation, R reads it as text rather than missing values.
* Missing values were replaced with the median.
* The classes were ordered according to the available data, and unnecessary columns for analysis were removed.
* The correctness of data encoding was checked.
* Binary data was converted to Factor type, and appropriate labels were assigned.
* Where possible, this process was automated.

## Statistical Analysis
From the conducted statistical analysis, it can be inferred that both children and older individuals participated in the study. The youngest child was less than a month old (0.08), while the oldest participant was 82 years old. The average age for the study group is around 43 years. The standard deviation, indicating the spread of data from the mean value, is 22.61358. Additionally, it was observed that the distribution of analyzed age data exhibits slight left-skewness (approximately -0.14), suggesting that there are slightly more individuals above the age of 43 in our study group. During the conducted research, half of the respondents (50%) were aged between 25 and 61 years.

## Data Visualization
![alt text](https://github.com/Gdyczko/Stroke_analiza_danych_R/blob/main/Number%20of%20people%20by%20employment.png "Rodzaj zatrudnienia")
The graph depicts the number of participants, depending on the type of employment. Among the five declared categories, besides individuals employed in private companies (Private) and government agencies (Government job) and self-employed (Self-employed), there were individuals who never worked (Never worked) and a group of children (Children). From the analysis, it can be concluded that the dominant group in the study were individuals who declared working in private companies (almost 3000 individuals), several times outnumbering other categories. The group of individuals declaring work in government agencies is very close to the number of children participating in the study. Slightly more numerous are individuals working in their own companies (self-employed), there are slightly over 800 individuals. The least numerous group consisted of individuals who never worked.

![alt text](https://github.com/Gdyczko/Stroke_analiza_danych_R/blob/main/BMI%20level%20by%20place%20of%20residence.png "BMI a miejsce zamieszkania")
The above graph shows the BMI index level among study participants according to their place of residence. Additionally, a dashed blue line representing the maximum correct BMI level (MAX correct BMI) at 24.9 is marked on the graph. From the analysis, it can be concluded that the majority of individuals (approximately 75%), regardless of their place of residence, have a BMI above the norm. Inhabitants of rural areas exhibit greater diversity in BMI values (greater data spread of about 20 points) than those living in urban areas. Half of the study participants, both those living in rural and urban areas, have a BMI ranging from about 24 to 33 points.

![alt text](https://github.com/Gdyczko/Stroke_analiza_danych_R/blob/main/BMI%20level%20by%20type%20of%20work.png "BMI a rodzaj pracy")
The "BMI level by type of work" chart illustrates the range of BMI values depending on the type of work performed. In this graph, as in the previous one, a red dashed line representing the upper limit of the correct BMI level (MAX correct BMI) is added. From the analyzed graph, it can be concluded that the majority of respondents exhibit BMI values above the norm regardless of their type of employment. Only individuals who never worked fall within the correct BMI range of about 50%. An exception on the graph is the group of children studied, which in a significant part (over 75% of respondents) falls below the upper limit of the normal body mass. The group of respondents working in the private sector shows the widest range of BMI values, and individuals with the highest BMI index are found in this group.

![alt text](https://github.com/Gdyczko/Stroke_analiza_danych_R/blob/main/Corelation%20between%20all%20data.png "korelacja pomiędzy wszytskimi danymi")
The "Corelation between all data" chart displays the results of correlations between all the factors studied. Thanks to this visualization, the graph itself indicates possible correlations between individual factors. From the graph, it can be inferred that there is practically no correlation between the factors studied, or it is very weak, with some cases being moderate. The visualization mainly shows positive values, but there are also negative values in the case of individuals who did not provide smoking status. Given that the study was conducted to analyze the occurrence of stroke, interpreting the above graph leads to the conclusion that no factors (such as smoking, heart attacks, hypertension) were found to have a significant impact on the onset of this disease. The correlation with any factor does not exceed the value of 0.25. The only strong correlation observed in the visualization relates to age and marital status. It is a positive correlation with a value of 0.68. This means that the older a person is, the greater the likelihood that they are or have been in a marital relationship.
