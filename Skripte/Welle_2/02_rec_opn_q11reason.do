/* Kodierung der offenen Antworten Frage
q11reasonother: Warum arbeiten Sie zurzeit nicht?

Antwortkategorien:
	0	Sonstiges
	1	Ich nehme bezahlten Urlaub
	2	Ich nehme unbezahlten Urlaub
	3	Ich bin betriebsbedingt freigestellt
	4	Ich habe keine Aufträge mehr
	5	Ich bin krankgeschrieben
*/


* Hilfsvariable erstellen
cap drop q11other
gen q11other = strlower(q11reasonother)

* Offene Eingaben mit problematischer Zuordnung:
strrec q11other ("tagesmutter hat betretungsverbot*" = "0"), sub replace string
strrec q11other ("*mein geschäft ist*" = "4"), sub replace string
strrec q11other ("*mir ist das arbeiten*untersagt" = "4"), sub replace string
strrec q11other ("*kurse sind nicht erlaubt*" = "4"), sub replace string
strrec q11other ("mein betrieb ist zu" = "4"), sub replace string
strrec q11other ("*kurse, schule nicht mög*" = "4"), sub replace string
strrec q11other ("*kiosk geschlossen*" = "4"), sub replace string
strrec q11other ("bin vom betretungsverbot betroffenen." = "4"), sub replace string
replace q11other = "4" if strmatch(q11other, "*berufsverbot*") & q05selfempl == 1
replace q11other = "4" if strmatch(q11other, "*arbeitsverbot*") & q05selfempl == 1


* Recodierung: Eigentlich nicht Erwerbstätig
*9	Elternzeit
foreach x in "*elternzeit*"	///
			 "*muttersch*"	///
			 {
	strrec q11other ("`x'" = "9"), sub replace string
}

*10	Studierende etc
foreach x in "*student*" "*studium*" "*schüler*"	///
			 {
	strrec q11other ("`x'" = "10"), sub replace string
}

*11 Rentner
foreach x in "*pension*" "*rent*" "*ruhestan*"	///
			 {
	strrec q11other ("`x'" = "11"), sub replace string
}

* Recodierung

*1	Ich nehme bezahlten Urlaub
foreach x in "*xy*" 	///
			 "*xy*"		{
	strrec q11other ("`x'" = "1"), sub replace string
}

*2	Ich nehme unbezahlten Urlaub
foreach x in "*freiwillige auszeit*" 	///
			 "*in eigenregie*"	///
			 "*sabbat*"	{
	strrec q11other ("`x'" = "2"), sub replace string
}

*3	Ich bin betriebsbedingt freigestellt
foreach x in "*freistellung*" 	///
			 "*arbeitsverbot*"	///
			 "*ngsverbot*"		///
			 "*covid 19*"		///
			 "*betreuungsverb*"	///
			 "*betretungsverb*"	///
			 "*betriebsverb*"	///
			 "betrriebsverbot"	///
			 "*freigest*"		///
			 "*darf nicht*"		///	
			 "*geschlossen*" 	///
			 "*schließung*"		///
			 "*eingestellt*"	///
			 "*?berstunden*"	///
			 "*notstand*"		///
			 "*berufsverbot*"	///
			 "*verboten zu arbeiten*"	///
			 "*betrieb eingestel*"	///
			 "*betrieb ist zu*"	///
			 "betrieb*nicht geöffnet*"	///
			 "*arbeit*untersagt*"	///
			 "die ogs hat zu*"	///
			 "*nicht erlaubt*"	///
			 "*kann ich nicht mehr*"	///
			 "*nicht möglich*"	///
			 "*schließen musste*"	///
			 "*derzeit nicht benötigt*"	///
			 "*gastronomie*"	///
			 "wegen corona"	///
			 {
	strrec q11other ("`x'" = "3"), sub replace string
}

*4	Ich habe keine Aufträge mehr (Selbstständige)
foreach x in "*laden schließen*" 	///
			 "*musste schließen*"	///
			 "*körperarbeit*nicht erlaubt*"	///
			 "*ich bin mit mein*nicht systemrelevant*"	///
			 "*filmprojekt*verschoben*"	///
			 "*neuer auftrage beginnt*"	///
			 "*selbstständig*"	///
			 "*alle aufträge*abgesagt*"	///
			 "*meine tätigkeit*untersagt*"	///
			 {
	strrec q11other ("`x'" = "4"), sub replace string
}

*5	Ich bin krankgeschrieben
foreach x in "*krank*" 	///
			 {
	strrec q11other ("`x'" = "5"), sub replace string
}

*0	Sonstiges
foreach x in "*allein erzieh*" 	///
			 "*geburt*"	///
			 "*betreue die kinder*"	///
			 "*kinderbetreuung*" ///
			 "*kinder*betreuen*"	/// 
			 "*kein kind in notbetreuung*"	///
			 "*keine kita*"	///
			 "kinde?"	///
			 "*betreue kinder*"	///
			 "*altersteilzeit*"	///
			 "*rufbereitschaft*"	///
			 "*auf abruf*"	///
			 "*klient*ängstlich und pausieren*"	///
			 "risikoperson*"	///
			 {
	strrec q11other ("`x'" = "0"), sub replace string
}

***	Neue Kategorien zum Filtern von "Arbeitet nicht", "Elternzeit", "In Ausbildung", "Rente"
*8	Arbeitet eigentlich nicht
foreach x in "*konnte*arbeit nicht antreten*" 	///
			 "*wurde gekündigt*"	///
			 "kündigung aufgrund von corona"	///
			 "*mein job ist ausgefal*"	///
			 "*entlassen*" ///
			 "*gekündigt*"	///
			 "*ausbildung*nicht möglich*"	///
			 "*arbeitslos*"	///
			 "*ehrenamtlich*"	///
			 "*um schulung*"	///
			 "*keine arbeit*"	///
			 "*eintritt ins unternehmen*verschoben*"	///
			 "keine gelder für mich als aushilfe*" {
	strrec q11other ("`x'" = "8"), sub replace string
}


*	zum Überprüfen der Recodierung
list q11other if !inlist(q11other, "0", "1", "2", "3", "4") & ///
				 !inlist(q11other, "5", "8", "9", "10", "11", "")

				 
*	Fälle richtig zuordnen
foreach num of numlist 1/5 {
	replace q11reason = `num' if q11other == "`num'"
}

*Nicht arbeitende richtig zuordnen
replace q03empsts = 0 if inlist(q11other, "8", "9", "10", "11")

foreach var of varlist q05* q06firmsize q07indust q08prof q05selfempl ///
				   q10currenttime q11reason q11compen q11lastwh q12office ///
				   q12time* q11usualwh q13support q20sat11 q21concern12 {
	replace `var' = .b if inlist(q11other, "8", "9", "10")
}

*Arbeitslos
replace q04status  = 2 if q11other == "8"
*Elternzeit
replace q04status  = 4 if q11other == "9"
*Studierende
replace q04status  = 1 if q11other == "10"
*Rente
replace q04status  = 3 if q11other == "11"

*Hilfsvariable löschen
drop q11other 


exit
