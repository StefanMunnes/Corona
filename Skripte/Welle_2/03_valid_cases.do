*** Unplausible Fälle rekodieren oder löschen ***

*** Duplikate
// (Doppelungen, wenn Fragebogen das erste mal nicht abgeschlossen wurde)
duplicates tag id, gen(dupl)

* doppelte IDs auf ursprüngliche ID aus Welle 1.1 ändern
// wenn zwei (mehr) Personen selber Kontaktdaten angegeben haben
// (neuer Link (mit selber ID) wurde nach Anfrage nochmal separat zugeschickt)
replace id = 2117 if id == 1986 & q01gndr == 2

// neue ID zuweisen, wenn Link an neue Person vergeben wurde
replace id = 1 if id == 226 & q01gndr == 2

// duplicates-tag bei bearbeiteten Fällen entfernen
replace dupl = . if inlist(id, 1986, 2117, 226, 3)


* Duplikate entfernen --> Fragebogen mit meisten Antworten behalten
gsort + id - lastgroup submitdate

duplicates drop id, force


*** Liste der Duplikate ranspielen um lediglich einen Fall zu behalten
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
replace q23plz = "10" if id == 70
replace q23plz = "50" if id == 3152
replace q23plz = "59" if id == 4258
replace q23plz = "40" if id == 4688
replace q23plz = "12" if id == 5313
replace q23plz = "38" if id == 6675
replace q23plz = "22" if id == 10114
replace q23plz = "79" if id == 11244
replace q23plz = "34" if id == 13200
replace q23plz = "34" if id == 13783
replace q23plz = "50" if id == 15163
replace q23plz = "32" if id == 15418

// unmögliche PLZ löschen
replace q23plz = "" if inlist(q23plz, "00", "05", "11", "43", "62")


exit
