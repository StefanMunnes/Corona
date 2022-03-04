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

* Recodierung: Eigentlich nicht Erwerbstätig
*9	Elternzeit
foreach x in "*xy*"	///
			 {
	strrec q11other ("`x'" = "9"), sub replace string
}

*10 Studium/Schule
foreach x in "*studium*"	///
			 {
	strrec q11other ("`x'" = "10"), sub replace string
}

*11 Rentner
foreach x in "*ruhestan*"	///
			 {
	strrec q11other ("`x'" = "11"), sub replace string
}

* Recodierung

*1	Ich nehme bezahlten Urlaub
foreach x in "*sommerferien*" 	///
			 "*br?ckentag*"		{
	strrec q11other ("`x'" = "1"), sub replace string
}

*2	Ich nehme unbezahlten Urlaub
foreach x in "*sabbat*"	///
			 "*semesterferien*"	///
			 "*sonderurlaub*"	///
			 {
	strrec q11other ("`x'" = "2"), sub replace string
}

*3	Ich bin betriebsbedingt freigestellt
foreach x in "*ngsverbot*"		///
			 "*freigest*"		///
			 "*bekomme trotzdem mein gehalt*"	///
			 "*aushilfe im kindergarten*"	///
			 "*und das ist zu*"		///
			 "*schulunterricht*nicht mögl*"	///
			 "geschlossen*"	///
			 "ruhen*"	///
			 "*coronainfektion*"	///
			 "*Überstunden*"	///
			 "*lockdown"	///
			 {
	strrec q11other ("`x'" = "3"), sub replace string
}

*4	Ich habe keine Aufträge mehr (Selbstständige)
foreach x in "*darf meine kneipe nicht öffnen*"	///
			 {
	strrec q11other ("`x'" = "4"), sub replace string
}

*5	Ich bin krankgeschrieben
foreach x in "*arbeitsunfähig*" "*hochrisikogruppe*" 	///
			 "krankheit" ///
			 {
	strrec q11other ("`x'" = "5"), sub replace string
}

*0	Sonstiges
foreach x in"*kinderbetreuung*" ///
			 "kinder" ///
			 "*kind*" ///
			 "*minijob*" ///
			 "*betreuung*" ///
			 "*studium*" ///
			 {
	strrec q11other ("`x'" = "0"), sub replace string
}

***	Neue Kategorien zum Filtern von "Arbeitet nicht", "Elternzeit", "In Ausbildung", "Rente"
*8	Arbeitet eigentlich nicht
foreach x in "*entlassen*" ///
			 "vertrag ist ausgelaufen*"	///
			 "*kündig*" ///
			  {
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

foreach var of varlist q05* q06firmsize q07indust2 q08prof q05selfempl ///
				   q10currenttime q11reason q11compen* q11lastwh q12office ///
				   q20sat11 q21concern12 {
	replace `var' = .b if inlist(q11other, "8", "9", "10", "11")
}

*Arbeitslos
replace q04status  = 2 if q11other == "8"
*Elternzeit
replace q04status  = 4 if q11other == "9"
*Studierende
replace q04status  = 1 if q11other == "10"
*Rente
replace q04status  = 3 if q11other == "11"

/*
*Überprüfungstabelle
preserve
keep id q11reason q11other q11reasonother
order id q11reason q11other q11reasonother
keep if q11reasonother != ""
sort q11reason q11reasonother
lab var q11reason		   "Warum arbeiten Sie zurzeit nicht?"
lab define reason_lab ///
  0	"Sonstiges" ///
  1	"Ich nehme bezahlten Urlaub" ///
  2	"Ich nehme unbezahlten Urlaub " ///
  3	"Ich bin betriebsbedingt freigestellt" ///
  4	"Ich habe keine Aufträge mehr" ///
  5	"Ich bin krankgeschrieben" ///
  6 "Ich bin in Kurzarbeit"
lab val q11reason reason_lab
browse
restore 
*/

*Hilfsvariable löschen
drop q11other 


exit
