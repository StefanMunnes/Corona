********************************************************************************
*
* Master-File zur Aubereitung der LimeSurvey-Daten der Studie corona-alltag.de
*
* Verantwortlich Lena Hipp, Mareike Bünning, Stefan Munnes
*
* Version: Welle 1 23.03.2020 - ...
*
********************************************************************************

version 16
set more off
clear all

cd ".."
capture cd "Corona"
cd ".."
capture cd "Corona"

*** Datensatz laden (Welle 1, Version 1, 23.03.2020 - 05.04.2020)
use "Daten/Rohdaten/Welle_1/data_20200405.dta", clear

*** Datensatz anfügen (Welle1, Version 2, 06.04.2020 - 10.05.2020)
append using "Daten/Rohdaten/Welle_1/data_20200510", generate(version)


*** Fälle löschen (Sample restrictions)
* Datenschutzerklärung (nicht) zugestimmt
keep if agreement2 == 1

* Ausland ausschließen
drop if q23land == 17

* nur Volljährige
drop if (2020 - q02yrbrn)  < 18

// Fälle die nicht bis zur ersten inhaltlichen Fragegruppe gekommen sind
drop if lastpage < 2

// Fälle ausschließen, die zu schnell waren (weniger als 1,5 Minuten)
drop if real(interviewtime)/ 60 < 1.5


*** Datensatz aufbereiten
* Bestehende Variablen rekodieren (Dummys, Sonstiges, Datumsangaben)
do "Skripte/Welle_1/01_rec_vars.do"

* Offene Antworten kodieren
foreach var in link q04 q05 q12 q17 q27 q32 q33 {
	do "Skripte/Welle_1/02_rec_opn_`var'.do"
}

* Unplausible Fälle rekodieren/löschen
do "Skripte/Welle_1/03_valid_cases.do"

* Fehlende Werte rekodieren (Abbrecher, Filter)
do "Skripte/Welle_1/04_rec_miss.do"

* Neue Variablen erstellen
do "Skripte/Welle_1/05_gen_vars.do"

* Variablen beschriften
do "Skripte/Welle_1/06_lab_vars.do"


* Offene Fragen löschen (für Veröffentlichung)
drop q22challenge

foreach var of varlist *other {
	replace `var' = "Ja" if `var' != ""
}


compress
save "Daten/Arbeitsdaten/corona_1_de.dta", replace


* Englisch beschrifteten Datensatz erstellen
do "Skripte/Welle_1/06_lab_vars_en.do"

foreach var of varlist *other {
	replace `var' = "Yes" if `var' == "Ja"
}

save "Daten/Arbeitsdaten/corona_1_en.dta", replace

exit
