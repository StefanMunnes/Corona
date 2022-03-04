
/* Missings
.a Abgebrochen (Frage kam nach Abbruch)
.b Trifft nicht zu (rausgefiltert)
.c Keine Antwort - alle Missings, die weder .a noch .b sind
.d Unplausibel - werden in 03_valid_cases.do vergeben
.e Sonstiges - Werte der Sonstiges-Kategorie, die nicht zugeordnet werden konnten
.f Panelrestriktion - Frage wurde bei wiederholter Teilnahme nicht gezeigt
*/

********************************************************************************

* a) Keine Antwort -  alles nachdem Befragung abgebrochen wurde mit .a codieren
// Fragegruppen (nur numerische Variablen; siehe 01_rec_vars.do):
local group3 = `"q01gndr q02yrbrn q03empst q04newemp q04status q04bjobloss"'
local group4 = `"q05selfempl q05cntrct q06firmsize q07indust2 q07indchange q07indust2pre q08prof2 q10currenttime q11reason q11lastwh q11lockdown? q11reduction* q11realisation* q11compen? q12office q12hopref q12workcond* q13support?"'
local group5 = `"q14partner q14cohabitpre q14carehh q15achildren q17childcare? q17childcare?? q18schoolage q18schoolform q18schoolsat q18schoolsit* q17childcaresub1? q17gendernorm? q19currentdiv?"'
local group6 = `"q20sat1? q20crisis? q20crisisland? q20famsup? q20famsupsat?? q21concern1?"'

local group8 = `"q29gndrpar q33educpar q30empstspar q30currenttimepar q31* q32officepar"'
local group9 = `"q34hhinc q34prevhhinc"'
local group10 = `"q35distress1? q35health1"'

foreach num of numlist 3/6 8/10 {
	foreach group of local group`num' {
		recode `group' (0/. = .a) if lastgroup < `num'
	}
}

********************************************************************************

* b) Trifft nicht zu - ausgefilterte Fälle, mit .b kodieren
recode q04newemp q05selfempl q05cntrct q06firmsize q07indust2 q07indchange ///
	q07indust2pre q08prof2 q10currenttime q11reason q11lastwh q11lockdown? ///
	q11reduction* q11realisation* q11compen? q12office q12hopref ///
	q12workcond* q13support? ///
	q20sat11 q20sat18 q21concern12 ///
	(0/. = .b) if q03empsts != 1

recode q04status   (0/. = .b) if q03empsts != 0
recode q04bjobloss (0/. = .b) if q04status != 2

recode q05cntrct q06firmsize q08prof2 (0/. = .b) if q04newemp != 1
recode q05cntrct q06firmsize q13support3 q13support4 (0/. = .b) if q05selfempl != 0

recode q07indchange  (0/. = .b) if q07indust2 == .
recode q07indust2pre (0/. = .b) if q07indchange != 0

recode q11reason (0/. = .b) if q10currenttime != 4

recode q11lastwh q12office q12hopref q12workcond* (0/. = .b) if q10currenttime == 4

recode q11reduction1* (0/. = .b) if !inlist(q10currenttime, 2, 4)
recode q11reduction2* (0/. = .b) if !inlist(q11lockdown1, 2, 4)
recode q11reduction3* (0/. = .b) if !inlist(q11lockdown2, 2, 4)

recode q11realisation1* (0/. = .b) if q05selfempl == 1 | !inlist(q10currenttime, 2, 4)
recode q11realisation2* (0/. = .b) if q05selfempl == 1 | !inlist(q11lockdown1, 2, 4)
recode q11realisation3* (0/. = .b) if q05selfempl == 1 | !inlist(q11lockdown2, 2, 4)
recode q11compen1 (0/. = .b) if !inlist(q10currenttime, 2, 4)
recode q11compen2 (0/. = .b) if !inlist(q11lockdown1, 2, 4)
recode q11compen3 (0/. = .b) if !inlist(q11lockdown2, 2, 4)

recode q13support2 (0/. = .b) if q12office == 3

recode q14cohabitpre q19currentdiv? q20sat12 q20sat14 q30empstspar ///
	(0/. = .b) if q14partner != 1

recode q17childcare? q17childcare?? q18schoolage q18schoolform q18schoolsat ///
	q18schoolsit* q19currentdiv5 q17childcaresub1? ///
	(0/. = .b) if q15achildren != 1

recode q18schoolform q18schoolsit* q20crisis3 (0/. = .b) if q18schoolage == 0

recode q18schoolsat  (0/. = .b) if q18schoolform == . | q18schoolform == .b

recode q20sat18 q20famsup? (0/. = .b) if q15achildren != 1 & q14carehh != 1

forval x = 1/8 {
  recode q20famsupsat1`x' (0/. = .b) if q20famsup`x' != 1
	recode q20famsupsat2`x' (0/. = .b) if q20famsup`x' != 1
}
recode q20famsupsat?9 (0/. = .b) if q20famsupother != ""

recode q21concern15 (0/. = .b) if q03empsts != 1 & q04status == 3

recode q29gndrpar q33educpar q30currenttimepar q31usualwhpar ///
	(0/. = .b) if q14cohabitpre != 0

recode q30currenttimepar q31lastwhpar q31profpar q32officepar ///
	(0/. = .b) if q30empstspar != 1

recode q31lastwhpar (0/. = .b) if q30currenttimepar == 4


********************************************************************************

* c) Keine Antwort - alle Item-Missings, die weder .a noch .b sind
foreach var of varlist * {
	capture: recode `var' (. = .c)
}

********************************************************************************

* e) Sonstiges - Werte der Sonstiges-Kategorie, die nicht zugeordnet werden konnten
recode q04status q11reason q12office q32officepar (0 = .e)

********************************************************************************

exit
