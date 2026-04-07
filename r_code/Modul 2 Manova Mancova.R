# 1. Install & Import library
# install.packages(c("MVN","biotools","car"))
library(MVN)
library(biotools)
library(car)
library(psych)
library(readxl)
library(dplyr)
library(tidyr)

# 2. Load Data
data <- read.csv("D:/KULIYEAH/Semester 4/Analisis Multivariat/Performance_of_Students.csv")

# Cek nama variabel
names(data)

# Dependent Variables (Y)
Y <- cbind(data$math.score, data$science.score)

# Independent Variables (X)
data$gender <- as.factor(data$gender) # X1
data$parental.education.level <- as.factor(data$parental.education.level) # X2
data$lunch <- as.factor(data$lunch) # X3
data$test.prep.course <- as.factor(data$test.prep.course) # X4

# Covariate (C)
covariate <- data$english.score

# 3. UJI ASUMSI MANOVA
# 3.1 Normalitas Multivariat
hasil_mvn <- MVN::mvn(data[, c("math.score","science.score")])
hasil_mvn$multivariate_normality
hasil_mvn$univariate_normality
hasil_mvn$descriptives

# 3.2 Homogenitas Matriks Kovarians (Box's M)
boxM(Y, data$gender)
boxM(Y, data$parental.education.level)
boxM(Y, data$lunch)
boxM(Y, data$test.prep.course)

# 3.3 Uji Dependensi (Korelasi antar Y)
hasil_bartlett <- cortest.bartlett(cor(data[, c("math.score","science.score")]), n = nrow(data))
print(hasil_bartlett)

# 4. UJI ASUMSI MANCOVA
# 4.1 Uji Linearitas Regresi
# Scatter plot C vs Y1 (Math Score) per gender
png("scatter_math_gender.png", width=800, height=600)
par(mar=c(5,5,4,2))

plot(data$english.score[data$gender=="Female"],
     data$math.score[data$gender=="Female"],
     col="#E05C8A", pch=16, cex=0.6,
     main="Linearitas: English Score vs Math Score per Gender",
     xlab="English Score (C)", ylab="Math Score (Y1)",
     xlim=range(data$english.score), ylim=range(data$math.score))

points(data$english.score[data$gender=="Male"],
       data$math.score[data$gender=="Male"],
       col="#3A82C4", pch=16, cex=0.6)

abline(lm(math.score ~ english.score,
          data=subset(data, gender=="Female")),
       col="#E05C8A", lwd=2)

abline(lm(math.score ~ english.score,
          data=subset(data, gender=="Male")),
       col="#3A82C4", lwd=2)

dev.off()

# Scatter plot C vs Y2 (Science Score) per gender
png("scatter_science_gender.png", width=800, height=600)
par(mar=c(5,5,4,2))

plot(data$english.score[data$gender=="Female"],
     data$science.score[data$gender=="Female"],
     col="#E05C8A", pch=16, cex=0.6,
     main="Linearitas: English Score vs Science Score",
     xlab="English Score (C)", ylab="Science Score (Y2)",
     xlim=range(data$english.score), ylim=range(data$science.score))

points(data$english.score[data$gender=="Male"],
       data$science.score[data$gender=="Male"],
       col="#3A82C4", pch=16, cex=0.6)

abline(lm(science.score ~ english.score,
          data=subset(data, gender=="Female")),
       col="#E05C8A", lwd=2)

abline(lm(science.score ~ english.score,
          data=subset(data, gender=="Male")),
       col="#3A82C4", lwd=2)

legend("topleft",
       legend=c("Female","Male"),
       col=c("#E05C8A","#3A82C4"),
       pch=16)

dev.off()

# 4.2 Homogenitas Varians Error
# Levene's Test - semua faktor
leveneTest(math.score ~ gender, data=data)
leveneTest(math.score ~ parental.education.level, data=data)
leveneTest(math.score ~ lunch, data=data)
leveneTest(math.score ~ test.prep.course, data=data)

leveneTest(science.score ~ gender, data=data)
leveneTest(science.score ~ parental.education.level, data=data)
leveneTest(science.score ~ lunch, data=data)
leveneTest(science.score ~ test.prep.course, data=data)

# 4.3 UJI INDEPENDENSI ERROR (DURBIN-WATSON)
#install.packages("lmtest")
library(lmtest)

model_math <- lm(math.score ~ gender + parental.education.level +
                   lunch + test.prep.course + covariate, data = data)

model_science <- lm(science.score ~ gender + parental.education.level +
                      lunch + test.prep.course + covariate, data = data)

dw_math <- dwtest(model_math)
print(dw_math)

dw_science <- dwtest(model_science)
print(dw_science)

# 4.4 Normalitas Residual
res <- residuals(lm(math.score ~ covariate + gender, data=data))
shapiro.test(res)
res_science <- residuals(lm(science.score ~ covariate + gender, data=data))
shapiro.test(res_science)

res_math    <- residuals(model_math)
shapiro.test(res_math)

res_science <- residuals(model_science)
shapiro.test(res_science)

# MINOR — QQ-Plot residual Y2 untuk normalitas

png("qqplot_residual_science.png", width=1000, height=400)
par(mfrow=c(1,2), mar=c(5,5,4,2))

# Histogram
hist(res_science,
     main="Histogram Residual Y2 (Science Score)",
     xlab="Residual", col="#5DCAA5", border="white", breaks=30)

# QQ-Plot
qqnorm(res_science,
       main="QQ Plot Residual Y2 (Science Score)",
       pch=16, col="#3A82C4", cex=0.6)
qqline(res_science, col="red", lwd=2)

dev.off()

# 4.5 Homogenitas Slope (Interaksi)
# Math score
anova(lm(math.score ~ covariate * gender, data=data))
anova(lm(math.score ~ covariate * parental.education.level, data=data))
anova(lm(math.score ~ covariate * lunch, data=data))
anova(lm(math.score ~ covariate * test.prep.course, data=data))

# Science score
anova(lm(science.score ~ covariate * gender, data=data))
anova(lm(science.score ~ covariate * parental.education.level, data=data))
anova(lm(science.score ~ covariate * lunch, data=data))
anova(lm(science.score ~ covariate * test.prep.course, data=data))

# 5. ANALISIS MANOVA
model_manova <- manova(cbind(math.score, science.score) ~ 
                         gender + parental.education.level + lunch + test.prep.course, data = data)

summary(model_manova, test = "Wilks")

# 6. ANALISIS MANCOVA
model_mancova <- manova(cbind(math.score, science.score) ~ 
                          gender + parental.education.level + lunch + test.prep.course + english.score, 
                        data = data)

summary(model_mancova, test = "Wilks")