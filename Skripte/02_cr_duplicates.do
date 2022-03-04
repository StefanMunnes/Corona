
clear all

cd ..
capture: cd "Corona"

* Rohdaten der Welle 1 laden (Version 1 + 2) für Duplikate von Nummern in linkother
local data "Daten\Rohdaten\Welle_1"

append using "`data'/data_20200405.dta" "`data'/data_20200510.dta", ///
	keep(id linkother q01gndr q02yrbrn)


replace linkother = "340503" if linkother == "34a0503" // Typo korrigieren

destring linkother, force gen(code) // numerisch Umwandel und damit nur Nummern behalten


* Kontaktdaten der Welle 1 laden (Version 1 + 2) für Duplikate (Mail, Phone, Twitter)
preserve

clear

local cntct "C:/Users/munnes/Documents/Corona/data_contact/"

append using "`cntct'/contact_20200405.dta" "`cntct'/contact_20200510.dta"

tempfile data_contact
save `data_contact'

restore


* Kontaktdaten an Rohdaten der Welle 1 anfügen
merge 1:1 id using `data_contact', nogen


* Duplikate markieren (Kontakte und Nummer)
duplicates tag mail 	 if mail    != "", gen(dup_mail)
duplicates tag phone 	 if phone   != "", gen(dup_phone)
duplicates tag twitter if twitter != "", gen(dup_twitter)
duplicates tag code 	 if code 		!= . , gen(dup_code)

egen dup = rowmax(dup_*)


* nur Duplikate behalten
keep if dup > 0 & !mi(dup)

keep id q01* q02* mail phone twitter code dup*


* Duplikat-Information entfernen, wenn mehrer Einträge doppelt vorkommen
// damit die Sortierung funktioniert, um die zugehörigen Duplikate zu makieren
replace code = .  if inlist(dup_code, 0 , .) // Nummer löschen, wenn nicht doppelt
replace mail = "" if inlist(dup_mail, 0, .) // Mail löschen, wenn nicht doppelt


* zusammengehörige Duplikate und Unterschiede markieren
// 1. dupid: gleiche ID für zusammengehörige Fälle
// 2. dupno: Anzahl unterschiedlicher Personen pro Duplikat
// 3. dupcase: wenn unterschiedliche Personen, welche Fälle sind welche Person?
// 4. duptyp: Art des einzelnen Duplikats:
// duptyp = 1 --> erste Beobachtung
// duptyp = 2 --> zweite, differente Beobachtung (andere Person)
// duptyp = 0 --> spätere wiederholte Teilnahme der selben Person(en)

sort code mail phone twitter

gen sexage = (q01gndr * 10000) + q02yrbrn if !mi(q01gndr, q02yrbrn)

bys code mail phone twitter: gen dupid = 1 if _n == 1
replace dupid = sum(dupid)

gen duptyp = .

bysort dupid (sexage id): replace duptyp = 1 if sexage[_n-1] != sexage & !mi(sexage)

bysort dupid: egen dupno = total(duptyp)

bysort dupid (duptyp id): replace duptyp = _n if !mi(duptyp)

replace duptyp = 0 if mi(duptyp)

bysort dupid sexage: egen dupcase = total(duptyp) if dupno > 1
replace dupcase = 1 if dupcase == .



keep id sexage dupid dupno dupcase duptyp

save "Daten/Arbeitsdaten/duplicates.dta", replace

exit
