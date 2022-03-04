/* Kodierung der offenen Antworten Frage
q11reasonother

Antwortkategorien:
	0	Sonstiges
	1	Ich nehme bezahlten Urlaub
	2	Ich nehme unbezahlten Urlaub
	3	Ich bin betriebsbedingt freigestellt
	4	Ich habe keine Aufträge mehr
	5	Ich bin krankgeschrieben
  6 Ich bin in Kurzarbeit (neu)
*/

* Hilfsvariable erstellen
cap drop q11other
gen q11other = strlower(q11reasonother)

* Offene Eingaben mit problematischer Zuordnung:
replace q11other = "3" if strmatch(q11other, "corona*") & !inlist(q05ctrtype, 3, 4)
replace q11other = "4" if strmatch(q11other, "corona*") & inlist(q05ctrtype, 3, 4)


*1	Ich nehme bezahlten Urlaub
foreach x in "*sonderurlaub*lohnfortzahlung*" 	///
			 "*berstunden*"	///
			 "*habe noch urlaub*"	///
			 "*ich bin im frei*"	///
			 "*resturlaub*"	///
			 "*bezahlter sonderurl*" {
	strrec q11other ("`x'" = "1"), sub replace string
}

*2	Ich nehme unbezahlten Urlaub
foreach x in "*freiwillige auszeit*" 	///
			 "*allein erzieh*" 	///
			 "*betreue die kinder*"	///
			 "*betreue mein*kind*"	///
			 "*betreuung meine*kinder*"	///
			 "*beschule meine*kinder"	///
			 "*muss*kind betreuen*"	///
			 "*kinderbetreuung*" ///
			 "*kinder*betreuen*"	///
			 "*homeschooling*kinder*"	///
			 "*keine kita*"	///
			 "kinde?"	///
			 "*kind zuhause*"	///
			 "*muss meine drei kinder versorgen*"	///
			 "*vereinbarte pause*"	{
	strrec q11other ("`x'" = "2"), sub replace string
}

replace q11other = "2" if strmatch(q11other, "*risiko*") & inlist(q05ctrtype, 3, 4)

*3	Ich bin betriebsbedingt freigestellt
cap drop q11other_empl
gen q11other_empl=q11other if inlist(q05ctrtype, 1, 2, 5)

foreach x in "*freistellung*" 	///
			 "*arbeitsverbot*"	///
			 "*ftigungsverbo*"	///
			 "*covid 19*"		///
			 "*betreuungsverb*"	///
			 "*betretungsverb*"	///
			 "*zeitungen werden nicht gedruckt*"	///
			 "betrriebsverbot"	///
			 "*freigest*"		///
			 "*darf nicht*"		///
			 "*geschlossen*" 	///
			 "*schließung*"		///
			 "*eingestellt*"	///
			 "*notstand*"		///
			 "*risikogr*"		///
			 "*risikopat*"		///
			 "*nicht erlaubt*"	///
			 "*nicht möglich*"	///
			 "*aufgrund der epidemie abgesagt"	///
			 "*dürfen nicht arbeiten*"	///
			 "verboten zu arbeiten*"	///
			 "keine anfallende arbeit"	///
			 "*momentan gibt es keine schichten*"	///
			 "*kulturbranche ist alles abgesagt"	///
			 "*theater und das ist zu*"	///
			 "vertrag vom arbeitgeber ruhend*"	///
			 "*weiterbildung ist ausgesetzt*"	///
			 "*corona gerade nicht weiter laufen*"	///
			 "*betrieb*darf*nicht arbeiten*"	///
			 "*bis jetzt in der kita keine kinder*"	///
			 "unterbrochene aufgaben"	///
			 "*geschlossen*" ///
			 "*nicht erlaubt*" ///
			 "*verbot*" ///
			 "abruf"	///
			 "*kein kind in notbetreuung*"	///
			 "*verschoben*" ///
			 "notbetreuung wurde nicht in anspruch genommen"	///
			 {
	strrec q11other_empl ("`x'" = "3"), sub replace string
}

replace q11other = "3" if q11other_empl == "3"
drop q11other_empl

strrec q11other ("*der laden*geschlossen*" = "3"), sub replace string

*4	Ich habe keine Aufträge mehr

cap drop q11other_self
gen q11other_self=q11other if inlist(q05ctrtype, 3, 4)

foreach x in "*laden schließen*" 	///
			 "*schließung*" ///
			 "*musste schließen*"	///
			 "*aufnahmen sind abgesagt*"	///
			 "*filmprojekt*verschoben*"	///
			 "*honrarkräfte an ersatzschulen*"	///
			 "*gelegenheiten*" ///
			 "*kontakt mit meinen klienten*"	///
			 "keine perspektive"	/// selbstständige person ohne perspektive..
			 "*musste mein cafe schließen*"	///
			 "mein laden hat zu"	///
			 "*darf aufgrund der beschränkung nicht arbeiten*"	///
			 "zwanhssxhliessung"	///
			 "*physiotherapeut*angst vor ansteckung*"	///
			 "*keine mittelaltermärkte mehr*"	///
			 "* alle konzerte abgesagt"	///
			 "*sicherheitsbestimmungen verbieten arbeit"	///
			 "*darf als makler keine besichtigungen*"	///
			 "bankrott"	///
			 "bin selbständig"	///
			 "*geschlossen*" ///
			 "*nicht erlaubt*" ///
			 "*darf nicht*" ///
			 "*verbot*" ///
			 "*covid 19*" ///
			 "*meine tätigkeit*untersagt*"	///
			 "*hat zu*" ///
			 "kaum gelegenheiten" {
	strrec q11other_self ("`x'" = "4") if inlist(q05ctrtype, 3, 4), sub replace string
}

replace q11other = "4" if q11other_self == "4"
drop q11other_self

*5	Ich bin krankgeschrieben
foreach x in "*krank*" 	///
			 "*quarantäne*"	///
			 "*corona infiziert"	///
			 "klinik"	{
	strrec q11other ("`x'" = "5"), sub replace string
}

*6	Ich bin in Kurzarbeit
foreach x in "*kurzarbeit*"	{
	strrec q11other ("`x'" = "6"), sub replace string
}


*	Neue Kategorien zum Filtern von "Arbeitet nicht" und "Elternzeit"
*8	Arbeitet eigentlich nicht
foreach x in "*konnte*arbeit nicht antreten*" 	///
			 "*wurde gekündigt*"	///
			 "*mein job ist ausgefal*"	///
			 "*entlassen*" ///
			 "*gekündigt*"	///
			 "*beendet*" ///
			 "*kündigung*"	///
			 "*vertrag wurde nicht verlängert"	///
			 "*vertrag fehlt*" ///
			 "keine gelder für mich als aushilfe*" ///
			 {
	strrec q11other ("`x'" = "8"), sub replace string
}

*9	Elternzeit
foreach x in "*elternzeit*"	///
			 "*muttersch*"	///
			 "*schwanger*"	///
			 "*geburt*" ///
			 {
	strrec q11other ("`x'" = "9"), sub replace string
}

*10	Studierende etc
foreach x in "*student*"  "*studium*" "*schüler*"	///
			 {
	strrec q11other ("`x'" = "10"), sub replace string
}

*11 verrentet
foreach x in "*rente*"  ///
			 {
	strrec q11other ("`x'" = "11"), sub replace string
}

*12	Homeoffice

foreach x in "*homeoffice*" "*heim*" {
	strrec q11other ("`x'" = "12"), sub replace string
}


*	Fälle richtig zuordnen
foreach num of numlist 1/5 {
	replace q11reason = `num' if q11other == "`num'"
}

*Homeoffice korrigieren
replace q10currenttime = 2 if q11other=="12" //arbeite weniger (erscheint plausibel, da "arbeite gar nicht" gewählt wurde)
replace q11reason = .b if q11other=="12"
replace q11reasonother = "" if q11other=="12"
replace q12office = 2 if q11other=="12"


*Nicht arbeitende richtig zuordnen
replace q03empsts = 0 if inlist(q11other, "8", "9", "10", "11")

foreach var of varlist q05ctrtype q06 q07 q08 q08 q10 q11reason q12office ///
					   q13 q20sat11 q20sat21 q21concern12 q21concern22 {
	replace `var' = .b if inlist(q11other, "8", "9", "10", "11")
}

foreach var of varlist q05ctrtypeother q12officeother q11reasonother  {
	replace `var' = "" if inlist(q11other, "8", "9", "10", "11")
}

*Arbeitslos
replace q04status  = 2 if q11other == "8"
replace q04bjobloss = 1 if q11other == "8"
*Elternzeit
replace q04status  = 4 if q11other == "9"
*Studierende
replace q04status  = 1 if q11other == "10"
*Rentner
replace q04status  = 3 if q11other == "11"

*Arbeitslos aufgrund Corona
cap drop q11other2
gen q11other2 = strlower(q11reasonother)
foreach x in "*gekündigt*corona*"	///
			 "*ündigung*corona*"		{
	replace q04bjobloss = 1 if strmatch(q11other2, "`x'")
}

*Hilfsvariable löschen
drop q11other q11other2


exit
