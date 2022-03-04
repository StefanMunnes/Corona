*** doppelte und unplausible Fälle rekodieren oder löschen ***

*** Liste der Duplikate ranspielen um lediglich einen Fall zu behalten
// OHNE using only (_merge == 2)
// --> Fälle die bereits vorher ausgeschlossen wurden (agreement), nicht matchen
merge 1:1 id using "Daten/Arbeitsdaten/duplicates.dta", keep(1 3) nogen

// doppelten Fall/Fälle löschen (späteren)
drop if !mi(dupid) & duptyp == 0

// neue ID aus Duplikat-ID und eindeutigem Geschlecht+Alter
// um später auch mit vertauschten und später weitergeführten Duplikat-IDs zu matchen
gen id_old = id if !mi(dupid)
replace id = (dupid * 100000) + (q01gndr * 10000) + q02yrbrn if !mi(dupid)

drop duptyp dupno dupcase

********************************************************************************

* q02yrbrn
// Tippfehler Geburtsjahr
recode q02yrbrn (1070 = 1970)

// nur Alter zwischen 10 und 100 als plausibel
replace q02yrbrn = .d if !inrange(q02yrbrn, 1920, 2010)

* q03empsts
// zu jung/alt für Erwerbstätigkeit
recode q03empsts (1 = .d) if q02yrbrn > 2013

* q15bchildren
// Tippfehler korrigieren (1 statt 10 etc.)
egen children_nr = rownonmiss(q16byrchild*)
recode q15bchildren (10/19 = 1) if children_nr == 1
recode q15bchildren (20/29 = 2) if children_nr == 2

// Kinderzahl über 10 unplausibel, wenn nicht genug Geburtsdaten
recode q15bchildren (10/max = .d) if children_nr < q15bchildren

drop children_nr

* q16byrchild
// Kind nicht mehr minderjährig
recode q16byrchild* (min/2001 = -1)

// nicht mehr minderjährige Kinder abziehen von angegebener Anzahl
egen wrong_children = anycount(q16byrchild*), value(-1)
replace q15bchildren = q15bchildren - wrong_children if q15bchildren > 0 & !mi(q15bchildren)

recode q16byrchild* (-1 = .d) // Behelfsmäßige -1 zum richtigen Missing .d
recode q15bchildren (0  = .d) // wenn doch keine minderjährigen Kinder, .d

drop wrong_children


exit
