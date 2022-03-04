
*** Überflüssige Variablen löschen
drop agreement? startlanguage refurl *intro psychohilfe outro1 outro4? *Time*

********************************************************************************

*** Variablen umbenennen
rename lastpage lastgroup
rename q13support1 q13support

foreach var in distress11 distress12 distress21 distress22 {
	rename q34`var' q35`var'
}

********************************************************************************

*** Variablen rekodieren
// Versionsnummer anpassen
replace version = version + 1

// Dummyvariablen erstellen
recode q03empsts q04bjobloss q14partner q15achildren ///
	q30empstspar outro2 (2 = 0)

// Dummyvariablen aus String-Codierung erstellen
foreach var of varlist link? q17childcare? {
	replace `var' = "1" if `var' == "Y"
	replace `var' = "0" if `var' != "1"

	destring `var', replace
}

// Auswahl offener Angaben (Sonstiges) numerisch kodieren
foreach var of varlist q04status q05ctrtype q11reason q12office q32officepar {

	replace `var' = "0" if `var' == "-oth-"

	destring `var', replace
}

foreach var of varlist 	q27educ q33educpar { // educ hat 0-Kategorie

	replace `var' = "5" if `var' == "-oth-"

	destring `var', replace
}


// q08prof & q31profpar: Kategorie 1-3 zusammenfassen aus Datenschutzgründen
recode *prof* (2/4 = 2) (5 = 3) (6 = 4) (7 = 5) (8 = 6) (9 = 7) (10 = 8)


// Gemeindegröße für Stadtstaaten
replace q24townsize = 2 if inlist(q23land, 3, 5, 6)


// q25hhsize und q26flatsize: hohe Ausprägung aus Datenschutzgründen begrenzen
recode q25hhsize   (5/max = 5)
recode q26flatsize (7/max = 7)


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
// 2. Referrer:
local group2 = `"link?"'
// 3. Person:
local group3 = `"q01gndr q02yrbrn q03empst q04status q04bjobloss"'
// 4. Beruf:
local group4 = `"q05ctrtype q06firmsize q07indust q08prof q09wtime q10currenttime q11reason q12office q13support"'
// 5. Familie:
local group5 = `"q14partner q15* q16* q17childcare? q18divlab* q19currentdiv*"'
// 6. Zufriedenheit:
local group6 = `"q20sat* q21concern*"'
// 7. Sozio-Demographie:
local group7 = `"q23land q24townsize q25hhsize q26flatsize q27educ q28migr"'
// 8. Partner:
local group8 = `"q29gndrpar q30empstspar q31profpar q32officepar q33educpar"'
// 9. Finanzen:
local group9 = `"q34hhinc"'
// 10. Gesundheit:
local group10 = `"q35distress?? q35health?"'
// 11. Abschluss:
local group11 = `"outro?"'


// Letzte Fragegruppe = Letzte Seite (Fragegruppe) ohne Missings
foreach num of numlist 2/11 {
	egen m_`num' = rownonmiss(`group`num'')

	if `num' == 2 {
		replace m_2 = m_2 + 1 if linkother != ""
	}

	replace lastgroup = `num' if m_`num' != 0
}

drop m_*

exit
