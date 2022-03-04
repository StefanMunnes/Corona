/* Kodierung der offenen Antworten Frage
	q11compenother: Beziehen Sie Kurzarbeitergeld oder bekommen einen anderen finanziellen Ausgleich für Ihre reduzierte Arbeitszeit?

in 6 Kategorien:
	0. Sonstiges (neu)
	1. Nein (Einkommen reduziert sich genauso stark wie Arbeitszeit)
	2. Ja, Kurzarbeitergeld
	3. Ja, ich beziehe weiterhin mein volles Gehalt
*/

* Hilfsvariable erstellen
cap drop q11other
gen q11other = strlower(q11compenother)

* Offene Eingaben mit problematischer Zuordnung:
strrec q11other ("*kein kurzarbeit*" = "3"), sub replace string
strrec q11other ("wird montag mit dem chef diskutiert" = ""), sub replace string

*1 Nein (Einkommen reduziert sich genauso stark wie Arbeitszeit)
foreach x in "* ?0%*"						///
			 "*einbußen im nebene*"			///
			 "*weggefallen*"				///
			 "*gehaltsverzicht*"			///
			 "*nebentätigkeit weiger*"		///
			 "*weniger verdienst das*"		///
			 "*minijob fällt weg*"			///
			 "*grundsicherung*"				///
			 {
	strrec q11other ("`x'" = "1"), sub replace string
}

*2 Ja, Kurzarbeitergeld
*Darunter auch andere Unterstützungen
foreach x in "*kurzarbeit*" 				///
			 "*alg*" 						///
			 "*aufstockung*"				///
			 "*s?forthilfe*" 				///
			 "*corona?zuschuss*"			///
			 "*beihilfe*"					///
			 "*rettungsschirm*"				///
			 "*zuschuss*"					///
			 "*einen ausgleich*"			///
			 "*freiwillige leistung arbeitg*"	///
			 "ibb corona hilfe*"			///
			 "freelancer unterst*"			///
			 "*60 % ausfallhono*"			///
			 "*corona hilfe*"				///
			 "*künstlerinnenhilfe*"			///
			 {
	strrec q11other ("`x'" = "2"), sub replace string
}

*3 Ja, ich beziehe weiterhin mein volles Gehalt
foreach x in "*urlaub*"						///
			 "*gleiches gehalt*"			///
			 "*normales gehalt*"			///
			 "*gleiches einkommen*"			///
			 "*einkommen reduziert sich nicht*"	///
			 "*gleiche*gehalt*"				///
			 "*beamt*"						///
			 "*gleitzeit*"					///
			 "*berst**"						///
			 "*mehrstundenausgleich*"		///
			 "*stunden nicht aufschreiben*"	///
			 "*keine einbußen*"				///
			 "*gleiche das später aus*"		///
			 "*stipendium*"					///
			 "*keine einnahmeausfälle*"		///
			 "*gehalt*unverändert*"			///
			 "*einkommen*nicht reduziert*"	///
			 "*einkommen*wie vor corona*"	///
			 "*trotzdem volles gehalt*"		///
			 "*volles gehalt*"				///
			 "*war leider eh schon gep*"	///
			 "*vertrauensarbeitszeit*"		///
			 "*keine gehaltskürzung*"		///
			 "*stunden müssen nachg*"		///
			 "geförderte ausbildung ohne gehalt*"	///
			 "*kulanz des arbeitg*"			///
			 "keine einiommemsreduzierung*"	///
			 "*unabhängig von pandemie*"	///
			 "*minus-stunden*"				///
			 "*tageweise freistellung nach*"	///
			 "*kein einkommensverl*"		///
			 {
	strrec q11other ("`x'" = "3"), sub replace string
}

*	Arbeitet eigentlich nicht
*Elterzeit
foreach x in "*beschäftigungsverb*" {
	strrec q11other ("`x'" = "9"), sub replace string
}

*Rente
foreach x in "*rente*" {
	strrec q11other ("`x'" = "11"), sub replace string
}

* Unklare Fälle --> Missing
foreach x in "*xyx*" {
	replace q11compen = . if strmatch(q11other, "`x'")
	strrec q11other ("`x'" = ""), sub replace string
}

*Nicht arbeitende richtig zuordnen
replace q03empsts = 0 if inlist(q11other, "8", "9", "10", "11")

foreach var of varlist q05* q06firmsize q07indust q08prof q05selfempl ///
				   q10currenttime q11reason q11compen q11lastwh q12office ///
				   q12time* q11usualwh q13support q20sat11 q21concern12 {
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

***** LÖSCHEN )


*	zum Überprüfen der Recodierung
list q11other if !inlist(q11other, "0", "1", "2", "3", "")

*	Fälle richtig zuordnen
foreach num of numlist 1/3 {
	replace q11compen = `num' if q11other == "`num'"
}

*	Hilfsvariable löschen
drop q11other


exit
