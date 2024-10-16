library(readr)
X2015 <- read_csv("2015.csv")

colnames(X2015)
str(X2015)
summary(X2015)
smaple_1 <- X2015[sample(nrow(X2015), 500), ]
colum_name <- names(smaple_1)
colum_extract <- c("RCSGENDR","IDATE","LADULT","CADULT","GENHLTH", 
                   "MENTHLTH","PERSDOC2", "CHECKUP1", "BPHIGH4", 
                   "BPMEDS", "BLOODCHO", "TOLDHI2", "CVDINFR4",
                   "CVDCRHD4", "CHCSCNCR", "CHCOCNCR", "SMOKDAY2",
                   "STOPSMK2", "_SMOKER3", "_RFSMOK3", "DIABETE3",
                   "PDIABTST", "PREDIAB1", "BLDSUGAR", "DOCTDIAB",
                   "CHKHEMO3", "DIABEYE", "DIABEDU", "_TOTINDA",
                   "_VEGETEX","_FRUITEX","STRFREQ_","PA1MIN_",
                   "PAVIG11_", "ALCDAY5","AVEDRNK2","DRNKANY5",
                   "_DRNKWEK")

indices <- which(colum_extract %in% colum_name)
print(indices) 

smaple_1_1 <- smaple_1[, colum_extract]

install.packages("ggplot2")
library(ggplot2)
# 
ggplot(smaple_1_1, aes(x = CVDINFR4)) +
  geom_bar( fill = "pink", color = "orange") +
  ggtitle("数值频率直方图") +
  xlab("值") +
  ylab("频率")
a <- list("_DRNKWEK", "DROCDY3_", "_RFSMOK3", "SMOKDAY2", "_MICHD")


# 500data with smoke graph
ggplot(drink_smoking_1, aes(x = drink_smoking_1$`_RFSMOK3` )) +
  geom_bar(fill = "pink", color = "orange" ) +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, color = "black") +
  labs(title = "who are current smokers",
       x = "Smoking Status") 

# variable relate -smoking and drinking

drink_smoking_1 <- X2015[, c("_DRNKWEK", "DROCDY3_", "_RFSMOK3", "SMOKDAY2","_SMOKER3", "_RFBING5", "_MICHD")]
#_DRNKWEK Calculated total number of alcoholic beverages consumed per week
#_RFBING5 Binge drinkers (males having five or more drinks on one occasion, females having four or more drinks on one occasion)
#DROCDY3_  Drink-occasions-per-day

#_SMOKER3 Four-level smoker status: Everyday smoker, Someday smoker, Former smoker, Non-smoker
#_RFSMOK3 Adults who are current smokers
#MOKDAY2 Do you now smoke cigarettes every day, some days, or not at all?

#_MICHD Respondents that have ever reported having coronary heart disease (CHD) or myocardial infarction (MI)

#  smoking factor
X2015$"_RFSMOK3" <- factor(X2015$"_RFSMOK3", levels = c(1, 2, 9),
                           labels = c("No", "Yes", "Refused"))
# percentage 
table_RFSMOK3 <- table(X2015$"_RFSMOK3")
percentages_RFSMOK3 <- round(100 * prop.table(table_RFSMOK3), 2)

# plot

barplot_result_smok <- barplot(table_RFSMOK3, 
        main = "who are current smokers", 
        xlab = "", 
        ylab = "Frequency", 
        col = "lightblue",
        ylim = c(0, max(table_RFSMOK3) *1.06))

text(x = barplot_result_smok, 
     y = table_RFSMOK3- max(table_RFSMOK3) * 0.08 ,
     label = paste0(percentages_RFSMOK3, "%"), 
     pos = 3, cex = 1, col = "black")

#  drinking factor

X2015$"_RFBING5" <- factor(X2015$"_RFBING5", levels = c(1, 2, 9),
                           labels = c("No", "Yes", "Refused"))
# percentage 
table__RFBING5 <- table(X2015$"_RFBING5")
percentages__RFBING5 <- round(100 * prop.table(table__RFBING5), 2)

# plot

barplot_result_drink <- barplot(table__RFBING5, 
                               main = "Binge drinkers", 
                               xlab = "", 
                               ylab = "Frequency", 
                               col = "orange",
                               ylim = c(0, max(table__RFBING5) *1.06))

text(x = barplot_result_drink, 
     y = table_RFSMOK3- max(table__RFBING5) * 0.08 ,
     label = paste0(percentages__RFBING5, "%"), 
     pos = 3, cex = 1, col = "black")

# smoking and drinking

drink_smoking_1 <- X2015[, c("_DRNKWEK", "DROCDY3_", "_RFSMOK3", "SMOKDAY2","_SMOKER3", "_RFBING5", "_MICHD")]

drinkers_data <- drink_smoking_1[drink_smoking_1$`_RFBING5` == "Yes", ]

smokers_data <- drink_smoking_1[drink_smoking_1$`_RFSMOK3` == "Yes", ]
smokers_drinking_data <-smokers_data[smokers_data$`_RFBING5`=="Yes",]

table_smokdrink_MICHD <- table(smokers_drinking_data$`_MICHD`)
percentages_smokdrink_MICHD <- round(100 * prop.table(table_smokdrink_MICHD), 2)


barplot_smokdrink_MICHD <- barplot(table_smokdrink_MICHD, 
                                 main = "smokers and drinkers who have heart disease", 
                                 xlab = "", 
                                 names.arg = c("Yes", "No"),
                                 ylab = "Frequency", 
                                 col = "lightblue",
                                 ylim = c(0, max(table_smokdrink_MICHD) *1.06))

text(x = barplot_smokdrink_MICHD, 
     y = table_smokdrink_MICHD- max(table_smokdrink_MICHD) * 0.08 ,
     label = paste0(percentages_smokdrink_MICHD, "%"), 
     pos = 3, cex = 1, col = "black")


# drinkers who have heart disease 
drinkers_data
table_drinkers_MICHD <- table(drinkers_data$`_MICHD`)
percentages_drinkers_MICHD <- round(100 * prop.table(table_drinkers_MICHD), 2)


barplot_drinkers_MICHD <- barplot(table_drinkers_MICHD, 
                                 main = "drinkers who have heart disease", 
                                 xlab = "", 
                                 names.arg = c("Yes", "No"),
                                 ylab = "Frequency", 
                                 col = "pink",
                                 ylim = c(0, max(table_drinkers_MICHD) *1.06))

text(x = barplot_drinkers_MICHD, 
     y = table_drinkers_MICHD- max(table_drinkers_MICHD) * 0.08 ,
     label = paste0(percentages_drinkers_MICHD, "%"), 
     pos = 3, cex = 1, col = "black")


# smokers who have heart disease
table_smokers_MICHD <- table(smokers_data$`_MICHD`)
percentages_smokers_MICHD <- round(100 * prop.table(table_smokers_MICHD), 2)


barplot_smokers_MICHD <- barplot(table_smokers_MICHD, 
                               main = "smokers who have heart disease", 
                               xlab = "", 
                               names.arg = c("Yes", "No"),
                               ylab = "Frequency", 
                               col = "lightblue",
                               ylim = c(0, max(table_smokers_MICHD) *1.06))

text(x = barplot_smokers_MICHD, 
     y = table_smokers_MICHD- max(table_smokers_MICHD) * 0.08 ,
     label = paste0(percentages_smokers_MICHD, "%"), 
     pos = 3, cex = 1, col = "black")


#non-smoking 
drink_smoking_1 <- X2015[, c("_DRNKWEK", "DROCDY3_", "_RFSMOK3", "SMOKDAY2","_SMOKER3", "_RFBING5", "_MICHD")]

nonsmokers_data <- drink_smoking_1[drink_smoking_1$`_RFSMOK3` == "No", ]

table_nonsmokers <- table(nonsmokers_data$`_MICHD`)
percentages_nonsmokers <- round(100 * prop.table(table_nonsmokers), 2)


barplot_nonsmokers <- barplot(table_nonsmokers, 
                                   main = "non-smokers who have heart disease", 
                                   xlab = "", 
                                   names.arg = c("Yes", "No"),
                                   ylab = "Frequency", 
                                   col = "lightblue",
                                   ylim = c(0, max(table_nonsmokers) *1.06))

text(x = barplot_nonsmokers, 
     y = table_nonsmokers- max(table_nonsmokers) * 0.08 ,
     label = paste0(percentages_nonsmokers, "%"), 
     pos = 3, cex = 1, col = "black")




missing_data_1 <- X2015[, c("_RFSMOK3", "SMOKDAY2", "_SMOKER3", "SMOKE100","STOPSMK2", "LASTSMK2", "USENOW3")] 
install.packages("naniar")
library(naniar)

vis_miss(missing_data_1 ,warn_large_data = FALSE)

gg_miss_upset(missing_data_1)


weight_height_data <- X2015[, c(65, 262,265, 66,260, 261)]
vis_miss(weight_height_data,warn_large_data = FALSE )
















