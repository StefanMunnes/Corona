
*** Überflüssige Variablen löschen
drop agreement? startlanguage *intro psychohilfe *Time*

********************************************************************************

*** Variablen umbenennen
rename lastpage lastgroup
rename q13support1 q13support

foreach var in distress?? {
	rename q34`var' q35`var'
}

********************************************************************************

// Dummyvariablen erstellen
recode q03empsts q04bjobloss q04newemp q05selfempl ///
	q14partner q15achildren q30empstspar (2 = 0)

// Dummyvariablen aus String-Codierung erstellen
foreach var of varlist q17childcare? {
	replace `var' = "1" if `var' == "Y"
	replace `var' = "0" if `var' != "1"

	destring `var', replace
}

// Auswahl offener Angaben (Sonstiges) numerisch kodieren
foreach var of varlist q04status q11reason q11compen q12office ///
	q32officepar {

	replace `var' = "0" if `var' == "-oth-"

	destring `var', replace
}

foreach var of varlist q25otherplace q25otherhhmem {

	replace `var' = "1" if `var' == "-oth-"

	destring `var', replace
}


// q08prof: Kategorie 1-3 zusammenfassen aus Datenschutzgründen
recode q08prof (2/4 = 2) (5 = 3) (6 = 4) (7 = 5) (8 = 6) (9 = 7) (10 = 8)


// PLZ: 2-Steller und führende Null ergänzen (Sachsen, Brandenburg, Thüringen)
replace q23plz = real(substr(string(q23plz, "%05.0f"), 1, 2))
tostring q23plz, replace
replace q23plz = "" if q23plz == "."
replace q23plz = "0" + q23plz if length(q23plz) == 1


// Datumsangaben: String zu Date/Clock rekodieren und formatieren
gen startdate2  = clock(startdate, "YMDhms")
gen datestamp2  = clock(datestamp, "YMDhms")
gen submitdate2 = clock(submitdate, "YMDhms")

drop startdate datestamp submitdate
rename startdate2 startdate
rename datestamp2 datestamp
rename submitdate2 submitdate

format startdate datestamp submitdate %tCDD.NN.CCYY_HH:MM:SS


// Interviewdauer in Minuten
destring interviewtime, replace
replace  interviewtime = interviewtime / 60
replace  interviewtime = round(interviewtime, 0.01)


// letzte Fragegruppe richtig kodieren (durch LimeSurvey nicht ganz korrekt)
// Fragegruppen (nur numerische Variablen):
// 1. Einverständniserklärung: agreement, ist schon rausgeflogen
// 2. Person:
local group3 = `"q01gndr q02yrbrn q03empst q04newemp q04status q04bjobloss"'
// 3. Beruf:
local group4 = `"q05selfempl q05cntrct q06firmsize q07indust q08prof q10currenttime q11reason q11compen q11lastwh q11usualwh q12office q12time?? q13support"'
// 4. Familie:
local group5 = `"q14partner q15* q17childcare? q19currentdiv* q17childcaresub??"'
// 5. Zufriedenheit:
local group6 = `"q20sat* q21concern*"'
// 6. Sozio-Demographie:
local group7 = `"q23plz q25otherplace q25otherhhmem"'
// 7. Partner:
local group8 = `"q30empstspar q32officepar"'
// 8. Finanzen:
local group9 = `"q34hhinc q34prevhhinc"'
// 9. Gesundheit:
local group10 = `"q35distress?? q35health?"'


// Letzte Fragegruppe = Letzte Seite (Fragegruppe) ohne Missings
foreach num of numlist 3/10 {
	egen m_`num' = rownonmiss(`group`num''), strok

	replace lastgroup = `num' if m_`num' != 0
}

drop m_*

exit
