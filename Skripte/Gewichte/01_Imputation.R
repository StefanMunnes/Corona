#### Pakete laden #####
library(readstata13)
library(dplyr)
library(VIM) # aggr
library(mice) #md.pattern
library(magrittr) # set_colnames


#### Pfad ####
try(setwd("../../../Corona"), silent = T)


#### Datensatz laden ####
surv <- read.dta13("Daten/Arbeitsdaten/corona_panel_de_v2.dta",
                   missing.type = T,
                   encoding = "UTF8")


### Datensat für Imputation und Gewichtung reduzieren ###
surv_comp <- surv[,c("id","wave","q23land","agegr","female","fam",
                     "q15achildren","q14partner","q25hhsize",
                     "q03empsts","edu","q28migr","q34hhinc")]

surv_comp <- droplevels(surv_comp)

surv1 <- surv_comp[surv_comp$wave == 1,]
surv2 <- surv_comp[surv_comp$wave == 2,]
surv3 <- surv_comp[surv_comp$wave == 3,]
surv4 <- surv_comp[surv_comp$wave == 4,]

################
### Welle 1 ####
################

#### Missing Patterns und Visualisierung der fehlenden Werte ####
miss.patterns1 <- as.data.frame(md.pattern(surv1))
colnames(miss.patterns1)[14] <- "Anzahl fehlender Werte"
Vorkommen.Kombi <- rownames(miss.patterns1)
Vorkommen.Kombi[nrow(miss.patterns1)] <- "Haeufigkeit Missing"
miss.patterns <- data.frame(Vorkommen.Kombi, miss.patterns1)
write.table(miss.patterns1, "Output/Gewichte/Pattern Missing Respond1.csv",
            sep=";", row.names = F, quote = F)

## Plot
pdf("Output/Gewichte/Missing.plot.Welle1.pdf")
aggr(surv1[,3:13], numbers = T, prop = F, axes = T, gap = 2,  labels = T,
     cex.axis = 0.75, cex.labels = 0.75, cex.numbers = 0.5)
dev.off()

### Missings paarweise Betrachtung #####
miss.pairs1 <- md.pairs(surv1)
write.table(miss.pairs1$mm, "Output/Gewichte/Gemeinsam fehlend1.csv",
            row.names = T, quote = F, sep=";")

### Reidentifikation nach Imputation ####
surv1$Anzahl_missing <- apply(surv1, 1, function(x) sum(as.numeric(is.na(x))))
a1 <- apply(is.na(surv1), 1, which)
surv1$miss <- sapply(a1, function(x) paste(names(x), collapse = ", "))

### Prediktormatrix ###
imp.surv1 <- mice(surv1, m = 1, method = "cart", minibucket = 4, maxit = 0)
pred1 <- imp.surv1$predictorMatrix
meth1 <- imp.surv1$method

pred1[, c("id", "wave", "Anzahl_missing")] <- 0

### Imputation ###
imp.surv12 <- mice(surv1, m = 1, maxit = 30, method = meth1, predictorMatrix = pred1, seed = 1549)
surv_imp1 <- complete(imp.surv12, "repeated")
colnames(surv_imp1) <- colnames(surv1)

# Überprüfung Imputation #
s.test <- which(surv_imp1$Anzahl_missing >= 1)
s1_test <- surv_imp1[s.test,]


################
### Welle 2 ####
################

#### Missing Patterns und Visualisierung der fehlenden Werte ####
miss.patterns2 <- as.data.frame(md.pattern(surv2))

colnames(miss.patterns2)[14] <- "Anzahl fehlender Werte"
Vorkommen.Kombi <- rownames(miss.patterns2)
Vorkommen.Kombi[nrow(miss.patterns2)] <- "Haeufigkeit Missing"
miss.patterns2 <- data.frame(Vorkommen.Kombi, miss.patterns2)

write.table(miss.patterns2,
            "Output/Gewichte/Pattern Missing Respond2.csv",
            sep = ";", row.names = F, quote = F)

## Plot
pdf("Output/Gewichte/Missing.plot.Welle2.pdf")
aggr(surv2[,3:13], numbers = T, prop = F, axes = T, gap = 2, labels = T,
     cex.axis = 0.75, cex.labels = 0.75, cex.numbers = 0.5)
dev.off()

### Missings paarweise Betrachtung #####
miss.pairs2 <- md.pairs(surv2)
write.table(miss.pairs2$mm,
            "Output/Gewichte/Gemeinsam fehlend2.csv",
            row.names = T, quote = F, sep = ";")

### Reidentifikation nach Imputation ####
surv2$Anzahl_missing <- apply(surv2,1,function(x) sum(as.numeric(is.na(x))))
a2 <- apply(is.na(surv2), 1, which)
surv2$miss <- sapply(a2, function(x) paste(names(x), collapse = ", "))

aaa <- merge(surv2, surv_imp1, by = "id", all.x = T)

aa <- list()
for(i in 1:15) {
  y <- i + 14
  aa[[i]] <- ifelse(is.na(aaa[, i]), yes = as.character(aaa[, y]), as.character(aaa[, i]))
}

surv_imp2 <- as.data.frame(do.call(cbind, aa)) %>%
  set_colnames(colnames(surv2)) %>%
  dplyr::mutate_if(., is.character, as.factor) %>%
  data.frame


################
### Welle 3 ####
################

#### Missing Patterns und Visualisierung der fehlenden Werte ####
miss.patterns3 <- as.data.frame(md.pattern(surv3))

colnames(miss.patterns3)[14] <- "Anzahl fehlender Werte"
Vorkommen.Kombi <- rownames(miss.patterns3)
Vorkommen.Kombi[nrow(miss.patterns3)] <- "Haeufigkeit Missing"
miss.patterns3 <- data.frame(Vorkommen.Kombi, miss.patterns3)

write.table(miss.patterns3,
            "Output/Gewichte/Pattern Missing Respond3.csv",
            sep=";", row.names = F, quote = F)

## Plot
pdf("Output/Gewichte/Missing.plot.Welle3.pdf")
aggr(surv3[,3:13], numbers = T, prop = F, axes = T, gap = 2, labels = T,
     cex.axis = 0.75, cex.labels = 0.75, cex.numbers = 0.5)
dev.off()

### Missings paarweise Betrachtung #####
miss.pairs3 <- md.pairs(surv3)
write.table(miss.pairs3$mm,
            "Output/Gewichte/Gemeinsam fehlend3.csv",
            row.names = T, quote = F, sep=";")

### Reidentifikation nach Imputation ####
surv3$Anzahl_missing <- apply(surv3, 1, function(x) sum(as.numeric(is.na(x))))
a3 <- apply(is.na(surv3), 1, which)
surv3$miss <- sapply(a3, function(x) paste(names(x), collapse = ", "))

aaa <- merge(surv3, surv_imp1, by = "id", all.x = T)

aa <- list()
for(i in 1:15) {
  y <- i + 14
  aa[[i]] <- ifelse(is.na(aaa[, i]), yes = as.character(aaa[, y]), as.character(aaa[, i]))
}

surv_imp3 <- as.data.frame(do.call(cbind,aa)) %>%
  set_colnames(colnames(surv3)) %>%
  dplyr::mutate_if(., is.character, as.factor) %>%
  data.frame

################
### Welle 4 ####
################

#### Missing Patterns und Visualisierung der fehlenden Werte ####
miss.patterns4 <- as.data.frame(md.pattern(surv4))

colnames(miss.patterns4)[14] <- "Anzahl fehlender Werte"
Vorkommen.Kombi <- rownames(miss.patterns4)
Vorkommen.Kombi[nrow(miss.patterns4)] <- "Haeufigkeit Missing"
miss.patterns4 <- data.frame(Vorkommen.Kombi, miss.patterns4)

write.table(miss.patterns4,
            "Output/Gewichte/Pattern Missing Respond4.csv",
            sep=";", row.names = F, quote = F)

## Plot
pdf("Output/Gewichte/Missing.plot.Welle4.pdf")
aggr(surv4[,3:13], numbers = T, prop = F, axes = T, gap = 2, labels = T,
     cex.axis = 0.75, cex.labels = 0.75, cex.numbers = 0.5)
dev.off()

### Missings paarweise Betrachtung #####
miss.pairs4 <- md.pairs(surv4)
write.table(miss.pairs4$mm,
            "Output/Gewichte/Gemeinsam fehlend4.csv",
            row.names = T, quote = F, sep=";")

### Reidentifikation nach Imputation ####
surv4$Anzahl_missing <- apply(surv4, 1, function(x) sum(as.numeric(is.na(x))))
a4 <- apply(is.na(surv4), 1, which)
surv4$miss <- sapply(a4, function(x) paste(names(x), collapse = ", "))

aaa <- merge(surv4, surv_imp1, by = "id", all.x = T)

aa <- list()
for(i in 1:15) {
  y <- i + 14
  aa[[i]] <- ifelse(is.na(aaa[, i]), yes = as.character(aaa[, y]), as.character(aaa[, i]))
}

surv_imp4 <- as.data.frame(do.call(cbind,aa)) %>%
  set_colnames(colnames(surv4)) %>%
  dplyr::mutate_if(., is.character, as.factor) %>%
  data.frame


######################
## Daten speichern ###
######################

save(surv, surv_imp1, surv_imp2, surv_imp3, surv_imp4,
     file = "Daten/Gewichte/Daten.imputiert.R")
