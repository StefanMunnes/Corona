*** Unplausible Fälle rekodieren oder löschen ***

*** Duplikate

* Duplikate entfernen --> Fragebogen mit meisten Antworten behalten
gsort + id - lastgroup submitdate

duplicates drop id, force


** Liste der Duplikate ranspielen um lediglich einen Fall zu behalten
// OHNE using only (_merge == 2)
// --> Fälle die vorher ausgeschlossen wurden (z.B. agreement), nicht matchen
merge m:1 id using "Daten/Arbeitsdaten/duplicates.dta", keep(1 3) nogen

// neue ID aus Duplikat-ID und eindeutigem Geschlecht+Alter
// um später auch mit vertauschten und später weitergeführten Duplikat-IDs zu matchen
gen id_old = id if !mi(dupid)
replace id = (dupid * 100000) + sexage if !mi(dupid)

gsort + id - lastgroup submitdate

// eindeutige Duplikate löschen (längste erste Beobachtung behalten)
duplicates drop id, force


drop dup* sexage

********************************************************************************

* q02yrbrn
// Tippfehler Geburtsjahr (geprüft nach ID in ersten Wellen)
recode q02yrbrn (1900 = 1960)


* q03empsts
// zu jung für Erwerbstätigkeit
recode q03empsts (1 = .d) if q02yrbrn > 2013 & !mi(q02yrbrn)


exit
