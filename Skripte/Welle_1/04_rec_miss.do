
/* Missings
.a Abgebrochen (Frage kam nach Abbruch)
.b Trifft nicht zu (rausgefiltert)
.c Keine Antwort - alle Missings, die weder .a noch .b sind
.d Unplausibel - werden in 03_check_cases.do vergeben
.e Sonstiges - Werte der Sonstiges-Kategorie, die nicht zugeordnet werden konnten
*/

********************************************************************************

* a) Keine Antwort -  alles nachdem Befragung abgebrochen wurde mit .a codieren
// Fragegruppen (nur numerische Variablen; siehe 01_rec_vars.do):
local group2 = `"link?"'
local group3 = `"q01gndr q02yrbrn q03empst q04status q04bjobloss"'
local group4 = `"q05ctrtype q06firmsize q07indust q08prof q09wtime q10currenttime q11reason q12time?? q12office q13support"'
local group5 = `"q14partner q15* q16* q17childcare? q17childcaresub* q18divlab* q19currentdiv*"'
local group6 = `"q20sat* q21concern*"'
local group7 = `"q23land q24townsize q25hhsize q26flatsize q27educ q28migr"'
local group8 = `"q29gndrpar q30empstspar q31profpar q32officepar q33educpar"'
local group9 = `"q34hhinc"'
local group10 = `"q35distress?? q35health?"'
local group11 = `"outro?"'

foreach num of numlist 2/11 {
	foreach group of local group`num' {
		recode `group' (. = .a) if lastgroup < `num'
	}
}

********************************************************************************

* b) Trifft nicht zu - ausgefilterte Fälle, mit .b kodieren
recode q05ctrtype q06firmsize q07indust q08prof q09wtime q10currenttime ///
	q11reason q12office q12time?? q13support q20sat11 q20sat21 q21concern12 q21concern22 ///
	(0/. = .b) if q03empsts != 1

recode q04status   				 (0/. = .b) if q03empsts != 0
recode q04bjobloss 				 (0/. = .b) if q04status != 2
recode q06firmsize 			   (0/. = .b) if !inlist(q05ctrtype, 1, 2, 5)
recode q11reason   				 (0/. = .b) if q10currenttime != 4
recode q12office q12time1? (0/. = .b) if !inlist(q10currenttime, 1, 2, 3)

recode q18divlab? q19currentdiv? q20sat12 q20sat14 q20sat22 q20sat24 ///
	q29gndrpar q30empstspar q33educpar ///
	(0/. = .b) if q14partner != 1

recode q15bchildren q16byrchild* q17childcare? q17childtvtime? ///
	q18divlab5 q19currentdiv5 q17childcaresub?? ///
	(0/. = .b) if q15achildren != 1

recode q31profpar q32officepar (0/. = .b) if q30empstspar != 1

********************************************************************************

* c) Keine Antwort - alle Item-Missings, die weder .a noch .b sind
foreach var of varlist * {
	capture: recode `var' (. = .c)
}

********************************************************************************

* e) Sonstiges - Werte der Sonstiges-Kategorie, die nicht zugeordnet werden konnten
recode q04status q05ctrtype q11reason q12office q32officepar (0 = .e)
recode q27educ q33educpar (5 = .e)

exit
