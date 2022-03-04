
rm(list = ls())

##### Pakete laden #####
library(dplyr)
library(xlsx)
library(tibble)
library(magrittr)
library(haven)

getwd()

#### Pfad ####
try(setwd("../../../Corona"), silent = T)

### Funktionen ###

## Funktion zum Trimmen###
trunc.bounds <- function(di, bound) {
  n <- sum(di)
  nopt <- di
  i <- 0
  s <- which(di <= 0 | di < bound[1] | di > bound[2])

  while(i < n) {
    if(length(s) != 0) {
      s1 <- which(nopt <= 0)
      s2 <- which(nopt < bound[1])
      s3 <- which(nopt > bound[2])
      nopt[s1] <- bound[1]
      nopt[s2] <- bound[1]
      nopt[s3] <- bound[2]
      su <- length(s1) * bound[1] + length(s2) * bound[1] + length(s3) * bound[2]
      ge <- (n-su) * nopt[-s] / sum(nopt[-s])
      nopt[-s] <- ge
      s <- which(nopt <= 0 | nopt < bound[1] | nopt > bound[2])
    }
    if(length(s) != 0) {
      i  <- i + 1
      fi <- i
    }
    else {
      fi <- i + 1
      i <- n
    }
  }

  cat("Anzahl der Iterationen: ", fi, "\n",
      "Anzahl der getrimmten Gewichte: ", length(which(nopt%in%bound)), "\n",
      "Minimalwert: ", sum(di^2/nopt))

  return(nopt)
}



#### Daten einlesen ###
load("Daten/Gewichte/Daten.imputiert.R")


### Populationswerte #####
Gender <- read.xlsx2("Daten/Gewichte/DESTATIS/3_Fam_Beruf_Erwerbst_BL_MZ2019.xlsx",
                     sheetName = "Geschlecht", header = T) %>%
  mutate(rel = as.numeric(Anzahl)/sum(as.numeric(Anzahl)))

Age <- read.xlsx2("Daten/Gewichte/DESTATIS/1_Bevoelkerung_Alter_100uae_Gebiet_2019.xlsx",
                  sheetName = "DTL. 18+", header = T) %>%
                  mutate(Alter   = 18:100,
                         Altergr = cut(Alter, breaks = c(0, 18, seq(25, 80, by = 5), 101),
                                       right = F,
                                       include.lowest = T)) %>%
                  droplevels()

Emp <- read.xlsx2("Daten/Gewichte/DESTATIS/3_Fam_Beruf_Erwerbst_BL_MZ2019.xlsx",
                        sheetName = "Employment",
                        header = T) %>%
  mutate(rel = as.numeric(Anzahl)/sum(as.numeric(Anzahl)))

Edu <- read.xlsx2("Daten/Gewichte/DESTATIS/3_Fam_Beruf_Erwerbst_BL_MZ2019.xlsx",
                  sheetName = "EDU",
                  header = T) %>%
  mutate(rel = as.numeric(Anzahl)/sum(as.numeric(Anzahl)))

Fam <- read.xlsx2("Daten/Gewichte/DESTATIS/3_Fam_Beruf_Erwerbst_BL_MZ2019.xlsx",
                  sheetName = "Familienstand",
                  header = T) %>%
  mutate(rel = as.numeric(Anzahl)/sum(as.numeric(Anzahl)))

BL <- read.xlsx2("Daten/Gewichte/DESTATIS/3_Fam_Beruf_Erwerbst_BL_MZ2019.xlsx",
                 sheetName = "BL",
                 header = T) %>%
  mutate(rel = as.numeric(Anzahl)/sum(as.numeric(Anzahl)))


### Population auf Kategorien im Survey bringen ###

## Geschlecht: keine Änderungen

## Age: sum(as.numeric(Age$Anzahl))
# [1] 69488809 -> Muss renormiert werden, da andere Datenquelle + Populationsgröße
Age$Anzahl2 <- as.numeric(Age$Anzahl) / sum(as.numeric(Age$Anzahl)) * sum(as.numeric(BL$Anzahl))

Age2 <- tapply(Age$Anzahl2, Age$Altergr, sum) %>%
  as.data.frame() %>%
  rownames_to_column() %>%
  set_colnames(c("aggr", "Anzahl")) %>%
  mutate(rel = Anzahl / sum(Anzahl))

### Bundesland
# Unterschiedliche Anordnung -> umsortieren damit es den levels aus surv_imp1 gleicht
BL2 <- arrange(BL, Bundesland)

## Employment
# Auf dichotom "Nein", "Ja"
Emp2 <- Emp[,c(1,3)] %>%
  mutate(Beschaeftigung = factor(Beschaeftigung, labels = c("Ja", "Nein", "Ja"))) %>%
  group_by(Beschaeftigung) %>%
  summarise_all(funs(sum)) %>%
  arrange(desc(Beschaeftigung))

### Familienstand
## Umbenennen, zusammenfassen (5 Ausprägungen), umsortieren
Fam$Familienstand <- as.factor(Fam$Familienstand)

levels(Fam$Familienstand) <- c("Alleinerziehend","Single, keine Kinder",
                               "Single, keine Kinder",
                               "Partner u Kind(er)","Partner, keine Kinder")

Fam2 <- Fam[,c(1,3)]  %>%
  group_by(Familienstand) %>%
  summarise_all(funs(sum))

### Edu
# gleiches wie fam -> von 7 auf 4 Ausprägungen
Edu$Abschluss <- as.factor(Edu$Schulabschluss)
levels(Edu$Abschluss) <- c("Ausbildung","Ausbildung",
                           "keine oder Anlernausbildung",
                           "in Schule/Ausbildung/Studium",
                           "keine oder Anlernausbildung",
                           "keine oder Anlernausbildung","Hochschulabschluss")
Edu2 <- Edu[,c(4,3)]  %>%
  group_by(Abschluss) %>%
  summarise_all(funs(sum))

Edu2 <- Edu2[c(3,2,1,4),]

##### Alter zusammenfassen um Anzahl der Zellen zu verringern ####

age_groups <- c("18-29", "18-29", "30-39", "30-39", "40-49", "40-49",
                "50-59", "50-59", "60-69", "60-69", "70-79", "70-79",
                "80+")

levels(surv_imp1$agegr) <- age_groups
levels(surv_imp2$agegr) <- age_groups
levels(surv_imp3$agegr) <- age_groups

Age2$aggr <- factor(Age2$aggr)

levels(Age2$aggr) <- age_groups

Age2 <- Age2[,c(1,3)] %>%
  group_by(aggr) %>%
  summarise_all(funs(sum))


#################
### Welle 1 #####
#################
to_wt <- data.frame(id   = surv_imp1$id,
                    wave = surv_imp1$wave,
                    bula = surv_imp1$q23land,
                    Gen  = surv_imp1$female,
                    Edu  = surv_imp1$edu,
                    Age  = surv_imp1$agegr,
                    fam  = surv_imp1$fam,
                    Emp  = surv_imp1$q03empsts,
                    count = 1)

Cal_input <- aggregate(to_wt$count,
                       list(Age = to_wt$Age,
                            Gen = to_wt$Gen,
                            BL  = to_wt$bula,
                            EDU = to_wt$Edu,
                            fam = to_wt$fam,
                            Emp = to_wt$Emp),
                       sum)



#### Kalibrierung ####
w_0 <- rep(1, times = nrow(Cal_input))
times <- 0

while(times <= 10000) {

  Cal_input$d <- with(Cal_input, x * w_0)

  #### Anpassung nach Alter #######
  Cal_input$d <- with(Cal_input, x*w_0)
  AGE <- tapply(Cal_input$d, Cal_input$Age, function(x) sum(x) / sum(Cal_input$x))
  w_1 <- Age2[, 2] / AGE
  w_1 <- w_1[as.numeric(Cal_input$Age), 1]

  ### Anpassen nach Geschlecht ####
  Cal_input$d2 <- with(Cal_input, x*w_0*w_1)
  gesch_c <- tapply(Cal_input$d2, Cal_input$Gen, function(x) sum(x)/sum(Cal_input$d2))
  w_2 <- Gender[,3]/gesch_c
  w_2 <- w_2[as.numeric(Cal_input$Gen)]

  ### Anpassen nach Education ####
  Cal_input$d3 <- with(Cal_input, x*w_0*w_1*w_2)
  EDUC <- tapply(Cal_input$d3, Cal_input$EDU, function(x) sum(x)/sum(Cal_input$d3))
  w_3 <- Edu2[,2]/EDUC
  w_3 <- w_3[as.numeric(Cal_input$EDU),1]

  ### Anpassen nach Buland ####
  Cal_input$d4 <- with(Cal_input, x*w_0*w_1*w_2*w_3)
  BL <- tapply(Cal_input$d4,Cal_input$BL, function(x) sum(x)/sum(Cal_input$d4))
  w_4 <- BL2[,3]/BL
  w_4 <- as.vector(w_4[as.numeric(Cal_input$BL)])

  ### Familie ####
  Cal_input$d5 <- with(Cal_input, x*w_0*w_1*w_2*w_3*w_4)
  FAM <- tapply(Cal_input$d5,Cal_input$fam, function(x) sum(x)/sum(Cal_input$d5))
  w_5 <- Fam2[,2]/FAM
  w_5 <- w_5[as.numeric(Cal_input$fam), 1]

  ### Employment ###
  Cal_input$d6 <- with(Cal_input, x*w_0*w_1*w_2*w_3*w_4*w_5)
  EMP <- tapply(Cal_input$d6,Cal_input$Emp, function(x) sum(x)/sum(Cal_input$d6))
  w_6 <- Emp2[,2]/EMP
  w_6 <- w_6[as.numeric(Cal_input$Emp), 1]

  ### final ###
  w_7 <- w_0*w_1*w_2*w_3*w_4*w_5*w_6
  w_0 <- w_7

  ###Break
  if(!all(Age2[,2]   == AGE) &
     !all(Gender[,3] == gesch_c) &
     !all(Edu2[,2]   == EDUC) &
     !all(BL2[,3]    == BL) &
     !all(Fam2[,2]   == FAM) &
     !all(Emp2[,2]   == EMP)) {

    times <- times + 1
  }
  else {
    break
  }
  cat("iteration", times - 1, "\n")
}

#  Iterationen
Cal_input$w0 <- w_0

#### Empfehlung -> Da starke Ausreißer -> Gewichte trimmen (auf 0.95-Percentil)
Cal_input$w0_t <- trunc.bounds(Cal_input$w0, c(0, quantile(Cal_input$w0,
                                                           probs = c(.95))))

Cal_input$ID <- do.call(paste0, Cal_input[, 1:6])
Cal_input2 <- Cal_input[, c("ID", "w0", "w0_t")]

to_wt$ID <- do.call(paste0,to_wt[,c("Age", "Gen", "bula", "Edu", "fam", "Emp")])

to_wt1 <- merge(to_wt, Cal_input2, by = "ID") %>%
  select(id, wave, w0, w0_t)


#################
### Welle 2 #####
#################
to_wt <- data.frame(id   = surv_imp2$id,
                    wave = surv_imp2$wave,
                    bula = surv_imp2$q23land,
                    Gen  = surv_imp2$female,
                    Edu  = surv_imp2$edu,
                    Age  = surv_imp2$agegr,
                    fam  = surv_imp2$fam,
                    Emp  = surv_imp2$q03empsts,
                    count = 1)

Cal_input <- aggregate(to_wt$count,list(Age = to_wt$Age,
                                        Gen = to_wt$Gen,
                                        BL  = to_wt$bula,
                                        EDU = to_wt$Edu,
                                        fam = to_wt$fam,
                                        Emp = to_wt$Emp),sum)

#### Kalibrierung ####
w_0 <- rep(1,times = nrow(Cal_input))
times <- 0

while(times <= 10000){
  Cal_input$d <- with(Cal_input, x*w_0)

  #### Anpassung nach Alter #######
  Cal_input$d <- with(Cal_input, x*w_0)
  AGE <- tapply(Cal_input$d,Cal_input$Age,function(x) sum(x)/sum(Cal_input$x))
  w_1 <- Age2[,2]/AGE
  w_1 <- w_1[as.numeric(Cal_input$Age),1]

  ### Anpassen nach Geschlecht ####
  Cal_input$d2 <- with(Cal_input, x*w_0*w_1)
  gesch_c <- tapply(Cal_input$d2,Cal_input$Gen,function(x) sum(x)/sum(Cal_input$d2))
  w_2 <- Gender[,3]/gesch_c
  w_2 <- w_2[as.numeric(Cal_input$Gen)]

  ### Anpassen nach Education ####
  Cal_input$d3 <- with(Cal_input, x*w_0*w_1*w_2)
  EDUC <- tapply(Cal_input$d3,Cal_input$EDU,function(x) sum(x)/sum(Cal_input$d3))
  w_3 <- Edu2[,2]/EDUC
  w_3 <- w_3[as.numeric(Cal_input$EDU),1]

  ### Anpassen nach Buland ####
  Cal_input$d4 <- with(Cal_input, x*w_0*w_1*w_2*w_3)
  BL <- tapply(Cal_input$d4,Cal_input$BL,function(x) sum(x)/sum(Cal_input$d4))
  w_4 <- BL2[,3]/BL
  w_4 <- as.vector(w_4[as.numeric(Cal_input$BL)])

  ### Familie ####
  Cal_input$d5 <- with(Cal_input, x*w_0*w_1*w_2*w_3*w_4)
  FAM <- tapply(Cal_input$d5,Cal_input$fam,function(x) sum(x)/sum(Cal_input$d5))
  w_5 <- Fam2[,2]/FAM
  w_5 <- w_5[as.numeric(Cal_input$fam),1]

  ### Employment ###
  Cal_input$d6 <- with(Cal_input, x*w_0*w_1*w_2*w_3*w_4*w_5)
  EMP <- tapply(Cal_input$d6,Cal_input$Emp,function(x) sum(x)/sum(Cal_input$d6))
  w_6 <- Emp2[,2]/EMP
  w_6 <- w_6[as.numeric(Cal_input$Emp),1]

  ### final ###
  w_7 <- w_0*w_1*w_2*w_3*w_4*w_5*w_6
  w_0 <- w_7

  ###Break
  if(!all(Age2[,2]   == AGE) &
     !all(Gender[,3] == gesch_c) &
     !all(Edu2[,2]   == EDUC) &
     !all(BL2[,3]    == BL) &
     !all(Fam2[,2]   == FAM) &
     !all(Emp2[,2]   == EMP)) {
    times<-times+1
  }
  else {
    break
  }

  cat("iteration",times-1,"\n")
} #  170 Iterationen

Cal_input$w0 <- w_0


#### Empfehlung -> Da starke Ausreißer -> Gewichte trimmen (auf 0.95-Percentil)
Cal_input$w0_t <- trunc.bounds(Cal_input$w0, c(0, quantile(Cal_input$w0,
                                                           probs = c(.95)))) # 34 Iterationan

Cal_input$ID <- do.call(paste0,Cal_input[,1:6])
Cal_input2 <- Cal_input[,c("ID","w0","w0_t")]

to_wt$ID <- do.call(paste0,to_wt[,c("Age","Gen","bula","Edu","fam","Emp")])

to_wt2 <- merge(to_wt,Cal_input2,by = "ID") %>%
  select(id, wave, w0, w0_t)


#################
### Welle 3 #####
#################
to_wt <- data.frame(id =   surv_imp3$id,
                    wave = surv_imp3$wave,
                    bula = surv_imp3$q23land,
                    Gen  = surv_imp3$female,
                    Edu  = surv_imp3$edu,
                    Age  = surv_imp3$agegr,
                    fam  = surv_imp3$fam,
                    Emp  = surv_imp3$q03empsts,
                    count = 1)

Cal_input <- aggregate(to_wt$count,list(Age = to_wt$Age,
                                        Gen = to_wt$Gen,
                                        BL  = to_wt$bula,
                                        EDU = to_wt$Edu,
                                        fam = to_wt$fam,
                                        Emp = to_wt$Emp),sum)

#### Kalibrierung ####

w_0 <- rep(1, times = nrow(Cal_input))
times <- 0

while(times <= 10000) {

  Cal_input$d <- with(Cal_input, x * w_0)

  #### Anpassung nach Alter #######
  Cal_input$d <- with(Cal_input, x*w_0)
  AGE <- tapply(Cal_input$d, Cal_input$Age, function(x) sum(x)/sum(Cal_input$x))
  w_1 <- Age2[, 2]/AGE
  w_1 <- w_1[as.numeric(Cal_input$Age), 1]

  ### Anpassen nach Geschlecht ####
  Cal_input$d2 <- with(Cal_input, x*w_0*w_1)
  gesch_c <- tapply(Cal_input$d2,Cal_input$Gen, function(x) sum(x)/sum(Cal_input$d2))
  w_2 <- Gender[, 3] / gesch_c
  w_2 <- w_2[as.numeric(Cal_input$Gen)]

  ### Anpassen nach Education ####
  Cal_input$d3 <- with(Cal_input, x*w_0*w_1*w_2)
  EDUC <- tapply(Cal_input$d3,Cal_input$EDU, function(x) sum(x)/sum(Cal_input$d3))
  w_3 <- Edu2[,2]/EDUC
  w_3 <- w_3[as.numeric(Cal_input$EDU),1]

  ### Anpassen nach Buland ####
  Cal_input$d4 <- with(Cal_input, x*w_0*w_1*w_2*w_3)
  BL <- tapply(Cal_input$d4,Cal_input$BL, function(x) sum(x)/sum(Cal_input$d4))
  w_4 <- BL2[,3]/BL
  w_4 <- as.vector(w_4[as.numeric(Cal_input$BL)])

  ### Familie ####
  Cal_input$d5 <- with(Cal_input, x*w_0*w_1*w_2*w_3*w_4)
  FAM <- tapply(Cal_input$d5,Cal_input$fam, function(x) sum(x)/sum(Cal_input$d5))
  w_5 <- Fam2[,2]/FAM
  w_5 <- w_5[as.numeric(Cal_input$fam),1]

  ### Employment ###
  Cal_input$d6 <- with(Cal_input, x * w_0 * w_1 * w_2 * w_3 * w_4 * w_5)
  EMP <- tapply(Cal_input$d6,Cal_input$Emp, function(x) sum(x)/sum(Cal_input$d6))
  w_6 <- Emp2[,2]/EMP
  w_6 <- w_6[as.numeric(Cal_input$Emp),1]

  ### final ###
  w_7 <- w_0 * w_1 * w_2 * w_3 * w_4 * w_5 * w_6
  w_0 <- w_7

  ###Break
  if(!all(Age2[, 2]   == AGE) &
     !all(Gender[, 3] == gesch_c) &
     !all(Edu2[, 2]   == EDUC) &
     !all(BL2[, 3]    == BL) &
     !all(Fam2[, 2]   == FAM) &
     !all(Emp2[, 2]   == EMP)) {

    times <- times + 1
  }
  else {
    break
  }

  cat("iteration", times - 1, "\n")
} #  183 Iterationen

Cal_input$w0 <- w_0


#### Empfehlung -> Da starke Ausreißer -> Gewichte trimmen (auf 0.95-Percentil)
Cal_input$w0_t <- trunc.bounds(Cal_input$w0,
                               c(0, quantile(Cal_input$w0,
                                             probs = c(.95)))) # 34 Iterationan

Cal_input$ID <- do.call(paste0, Cal_input[, 1:6])
Cal_input2 <- Cal_input[, c("ID", "w0", "w0_t")]

to_wt$ID <- do.call(paste0, to_wt[, c("Age", "Gen", "bula", "Edu", "fam", "Emp")])

to_wt3 <- merge(to_wt, Cal_input2, by = "ID") %>%
  select(id, wave, w0, w0_t)


#################
### Welle 4 #####
#################
to_wt <- data.frame(id =   surv_imp4$id,
                    wave = surv_imp4$wave,
                    bula = surv_imp4$q23land,
                    Gen  = surv_imp4$female,
                    Edu  = surv_imp4$edu,
                    Age  = surv_imp4$agegr,
                    fam  = surv_imp4$fam,
                    Emp  = surv_imp4$q03empsts,
                    count = 1)

Cal_input <- aggregate(to_wt$count,list(Age = to_wt$Age,
                                        Gen = to_wt$Gen,
                                        BL  = to_wt$bula,
                                        EDU = to_wt$Edu,
                                        fam = to_wt$fam,
                                        Emp = to_wt$Emp),sum)

#### Kalibrierung ####

w_0 <- rep(1, times = nrow(Cal_input))
times <- 0

while(times <= 10000) {

  Cal_input$d <- with(Cal_input, x * w_0)

  #### Anpassung nach Alter #######
  Cal_input$d <- with(Cal_input, x*w_0)
  AGE <- tapply(Cal_input$d, Cal_input$Age, function(x) sum(x)/sum(Cal_input$x))
  w_1 <- Age2[, 2]/AGE
  w_1 <- w_1[as.numeric(Cal_input$Age), 1]

  ### Anpassen nach Geschlecht ####
  Cal_input$d2 <- with(Cal_input, x*w_0*w_1)
  gesch_c <- tapply(Cal_input$d2,Cal_input$Gen, function(x) sum(x)/sum(Cal_input$d2))
  w_2 <- Gender[, 3] / gesch_c
  w_2 <- w_2[as.numeric(Cal_input$Gen)]

  ### Anpassen nach Education ####
  Cal_input$d3 <- with(Cal_input, x*w_0*w_1*w_2)
  EDUC <- tapply(Cal_input$d3,Cal_input$EDU, function(x) sum(x)/sum(Cal_input$d3))
  w_3 <- Edu2[,2]/EDUC
  w_3 <- w_3[as.numeric(Cal_input$EDU),1]

  ### Anpassen nach Buland ####
  Cal_input$d4 <- with(Cal_input, x*w_0*w_1*w_2*w_3)
  BL <- tapply(Cal_input$d4,Cal_input$BL, function(x) sum(x)/sum(Cal_input$d4))
  w_4 <- BL2[,3]/BL
  w_4 <- as.vector(w_4[as.numeric(Cal_input$BL)])

  ### Familie ####
  Cal_input$d5 <- with(Cal_input, x*w_0*w_1*w_2*w_3*w_4)
  FAM <- tapply(Cal_input$d5,Cal_input$fam, function(x) sum(x)/sum(Cal_input$d5))
  w_5 <- Fam2[,2]/FAM
  w_5 <- w_5[as.numeric(Cal_input$fam),1]

  ### Employment ###
  Cal_input$d6 <- with(Cal_input, x * w_0 * w_1 * w_2 * w_3 * w_4 * w_5)
  EMP <- tapply(Cal_input$d6,Cal_input$Emp, function(x) sum(x)/sum(Cal_input$d6))
  w_6 <- Emp2[,2]/EMP
  w_6 <- w_6[as.numeric(Cal_input$Emp),1]

  ### final ###
  w_7 <- w_0 * w_1 * w_2 * w_3 * w_4 * w_5 * w_6
  w_0 <- w_7

  ###Break
  if(!all(Age2[, 2]   == AGE) &
     !all(Gender[, 3] == gesch_c) &
     !all(Edu2[, 2]   == EDUC) &
     !all(BL2[, 3]    == BL) &
     !all(Fam2[, 2]   == FAM) &
     !all(Emp2[, 2]   == EMP)) {

    times <- times + 1
  }
  else {
    break
  }

  cat("iteration", times - 1, "\n")
} #  183 Iterationen

Cal_input$w0 <- w_0


#### Empfehlung -> Da starke Ausreißer -> Gewichte trimmen (auf 0.95-Percentil)
Cal_input$w0_t <- trunc.bounds(Cal_input$w0,
                               c(0, quantile(Cal_input$w0,
                                             probs = c(.95)))) # 34 Iterationan

Cal_input$ID <- do.call(paste0, Cal_input[, 1:6])
Cal_input2 <- Cal_input[, c("ID", "w0", "w0_t")]

to_wt$ID <- do.call(paste0, to_wt[, c("Age", "Gen", "bula", "Edu", "fam", "Emp")])

to_wt4 <- merge(to_wt, Cal_input2, by = "ID") %>%
  select(id, wave, w0, w0_t)


### Gewichte zusammenfügen und abspeichern ###
to_wt_ges <- rbind(to_wt1, to_wt2, to_wt3, to_wt4) %>%
  mutate_if(is.character, as.numeric)

names(to_wt_ges) <- c("id", "wave", "weight", "weight_trim")

write_dta(to_wt_ges, "Daten/Gewichte/weights_allwaves.dta", version = 15)
