
/* Missings
.a Abgebrochen (Frage kam nach Abbruch)
.b Trifft nicht zu (rausgefiltert)
.c Keine Antwort - alle Missings, die weder .a noch .b sind
.d Unplausibel - werden in 03_valid_cases.do vergeben
.e Sonstiges - Werte der Sonstiges-Kategorie, die nicht zugeordnet werden konnten
*/


********************************************************************************

* a) Keine Antwort -  alles nachdem Befragung abgebrochen wurde mit .a codieren
// Fragegruppen (nur numerische Variablen; siehe 01_rec_vars.do):
local group3  = `"q01gndr q02yrbrn q03empst q04newemp q04status q04bjobloss"'
local group4  = `"q05selfempl q05cntrct q06firmsize q07indust q08prof q10currenttime q11reason q11compen q11lastwh q11usualwh q12office q12time?? q13support"'
local group5  = `"q14partner q15* q17childcare? q19currentdiv* q17childcaresub??"'
local group6  = `"q20sat1? q21concern1?"'
local group7  = `"q25otherplace q25otherhhmem"'
local group8  = `"q30empstspar q32officepar"'
local group9  = `"q34hhinc q34prevhhinc"'
local group10 = `"q35distress?? q35health?"'

foreach num of numlist 3/10 {
	foreach group of local group`num' {
		recode `group' (. = .a) if lastgroup < `num'
	}
}

********************************************************************************

* b) Trifft nicht zu - ausgefilterte Fälle, mit .b kodieren
recode q04newemp q05selfempl q05cntrct q06firmsize q07indust q08prof q10currenttime ///
	q11reason q11compen q11lastwh q11usualwh q12office q12time?? q13support ///
	q20sat11 q21concern12 ///
	(0/. = .b) if q03empsts != 1

recode q04status   (0/. = .b) if q03empsts != 0
recode q04bjobloss (0/. = .b) if q04status != 2

recode q05cntrct q06firmsize q07indust q08prof (0/. = .b) if q04newemp != 1
recode q05cntrct q06firmsize (0/. = .b) if q05selfempl != 0

recode q11compen (0/. = .b) if q10currenttime != 2
recode q11reason (0/. = .b) if q10currenttime != 4
recode q11lastwh q12office q12time1? (0/. = .b) if q10currenttime == 4

recode q19currentdiv? q20sat12 q20sat14 q30empstspar ///
	(0/. = .b) if q14partner != 1

recode q17childcare? q17childtvtime? q19currentdiv5 q17childcaresub?? ///
	(0/. = .b) if q15achildren != 1

recode q32officepar (0/. = .b) if q30empstspar != 1

********************************************************************************

* c) Keine Antwort - alle Item-Missings, die weder .a noch .b sind
foreach var of varlist * {
	capture: recode `var' (. = .c)
}

********************************************************************************

* e) Sonstiges - Werte der Sonstiges-Kategorie, die nicht zugeordnet werden konnten
recode q04status q11reason q11compen q12office q32officepar (0 = .e)

exit
