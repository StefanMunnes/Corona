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
// Tippfehler Geburtsjahr
recode q02yrbrn (82 = 1982) (1900 = 1960)


* q03empsts
// zu jung für Erwerbstätigkeit
recode q03empsts (1 = .d) if q02yrbrn > 2013


* q23plz
// Tippfehler in PLZ händisch korrigieren
replace q23plz = "12" if id == 3760
replace q23plz = "89" if id == 4238
replace q23plz = "30" if id == 4633
replace q23plz = "10" if id == 6308
replace q23plz = "72" if id == 6995
replace q23plz = "10" if id == 7655
replace q23plz = "35" if id == 7822
replace q23plz = "10" if id == 9754
replace q23plz = "53" if id == 11277
replace q23plz = "14" if id == 13119
replace q23plz = "86" if id == 14784
replace q23plz = "30" if id == 15456
replace q23plz = "13" if id == 18088

// unmögliche PLZ löschen
replace q23plz = "" if inlist(q23plz, "00", "05", "11", "43", "62")


exit
