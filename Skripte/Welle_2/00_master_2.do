********************************************************************************
*
* Master-File zur Aubereitung der LimeSurvey-Daten der Studie corona-alltag.de
*
* Verantwortlich Lena Hipp, Mareike Bünning, Stefan Munnes
*
* Version: Welle 2 20.04.2020 - ...
*
********************************************************************************

version 16
set more off
clear all

cd ".."
capture cd "Corona"
cd ".."
capture cd "Corona"


*** Datensatz laden (Welle 2, 20.04.2020 bis 14.06.2020)
use "Daten/Rohdaten/Welle_2/data_20200615.dta", clear


*** Fälle löschen (Sample restrictions)
* Datenschutzerklärung (nicht) zugestimmt
keep if agreement2 == 1

* nur Volljährige
drop if (2020 - q02yrbrn)  < 18

// Fälle die nicht bis zur ersten inhaltlichen Fragegruppe gekommen sind
drop if lastpage < 2

// Fälle ausschließen, die zu schnell waren (weniger als 1,5 Minuten)
drop if real(interviewtime)/ 60 < 1.5


*** Datensatz aufbereiten
* Bestehende Variablen rekodieren (Dummys, Sonstiges, Datumsangaben)
do "Skripte/Welle_2/01_rec_vars.do"

* Offene Antworten kodieren: q11reason q11compen
foreach var in q04 q11compen q11reason q12 q17 q32 {
	do "Skripte/Welle_2/02_rec_opn_`var'.do"
}

* Unplausible Fälle rekodieren/löschen
do "Skripte/Welle_2/03_valid_cases.do"

* Fehlende Werte rekodieren (Abbrecher, Filter)
do "Skripte/Welle_2/04_rec_miss.do"

* Neue Variablen erstellen
do "Skripte/Welle_2/05_gen_vars.do"

* Variablen beschriften
do "Skripte/Welle_2/06_lab_vars.do"


* Offene Fragen löschen (für Veröffentlichung)
drop q22challenge

foreach var of varlist *other {
	replace `var' = "Ja" if `var' != ""
}


compress
save "Daten/Arbeitsdaten/corona_2_de.dta", replace


* Englisch beschrifteten Datensatz erstellen
do "Skripte/Welle_2/06_lab_vars_en.do"

foreach var of varlist *other {
	replace `var' = "Yes" if `var' == "Ja"
}

save "Daten/Arbeitsdaten/corona_2_en.dta", replace

exit
