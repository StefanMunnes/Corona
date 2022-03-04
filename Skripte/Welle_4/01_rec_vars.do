
*** Überflüssige Variablen löschen
drop seed startlanguage agreement? *intro psychohilfe q20famsupopen ///
	incentive* *Time*

********************************************************************************

*** Variablen umbenennen
rename lastpage lastgroup
rename q08prof q08prof2
rename q18schoolsat1 q18schoolsat
rename q34distress11 q35distress11
rename q34distress12 q35distress12

********************************************************************************

// Dummyvariablen erstellen
recode q03empsts q04newemp q04bjobloss q05selfempl q30empstspar (2 = 0)

// Auswahl offener Angaben (Sonstiges) als numerisch kodieren
foreach var of varlist q04status q11reason q12office q32officepar {

	replace `var' = "0" if `var' == "-oth-"

	destring `var', replace
}

// (einfache) offene Antworten als Zahlenwerte übertragen
replace q18schoolageother = regexr(q18schoolageother, "\.", "")
replace q18schoolage = q18schoolageother if q18schoolage == "-oth-"

destring q18schoolage, replace

drop q18schoolageother

********************************************************************************

*** letzte Fragegruppe richtig kodieren (durch LimeSurvey nicht ganz korrekt)
// Fragegruppen (nur numerische Variablen):
// 1. Einverständniserklärung: agreement, ist schon rausgeflogen

// 3. Person:
local group3 = `"q01gndr q02yrbrn q03empst q04newemp q04status q04bjobloss"'
// 4. Beruf:
local group4 = `"q05selfempl q05cntrct q06firmsize q07indust2 q07indchange q07indust2pre q08prof2 q10currenttime q11reason q11lastwh q11lockdown? q11reduction* q11realisation* q11compen? q12office q12hopref q12workcond* q13support?"'
// 5. Familie + Geschlechternormen:
local group5 = `"q14partner q14cohabitpre q14carehh q15achildren q17childcare? q17childcare?? q18schoolage q18schoolform q18schoolsat q18schoolsit* q17childcaresub1? q17gendernorm? q19currentdiv?"'
// 6. Zufriedenheit:
local group6 = `"q20sat1? q20crisis? q20crisisland? q20famsup? q20famsupsat?? q21concern1?"'

// 8. Partner:
local group8 = `"q29gndrpar q33educpar q30empstspar q30currenttimepar q31* q32officepar"'
// 9. Finanzen:
local group9 = `"q34hhinc q34prevhhinc"'
// 10. Gesundheit:
local group10 = `"q35distress1? q35health1"'

// Letzte Fragegruppe = Letzte Seite (Fragegruppe) ohne Missings
foreach num of numlist 3/6 8/10 {
	egen m_`num' = rownonmiss(`group`num''), strok

	replace lastgroup = `num' if m_`num' != 0
}

drop m_*

********************************************************************************

// Dummyvariablen aus String-Codierung erstellen
foreach var of varlist q17childcare? q17childcare?? q20famsup? {
	replace `var' = "1" if `var' == "Y"
	replace `var' = "0" if `var' != "1"

	destring `var', replace
}


// neue Kategorie der Variable q32officepar rekodieren
recode q32officepar (4 = 5)


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


exit
