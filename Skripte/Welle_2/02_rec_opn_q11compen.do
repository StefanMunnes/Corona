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
strrec q11other ("gehalt ist gleich, doch sollen übe*" = "3"), sub replace string
strrec q11other ("*kein kurzarbeit*" = "3"), sub replace string
strrec q11other ("*90% meines gehaltes*kurzarbeit*" = "2"), sub replace string
strrec q11other ("*gleiches gehalt*kurzarbeitsgeld beziehe ich nicht*" = "3"), sub replace string

*2 Ja, Kurzarbeitergeld
*Darunter auch andere Unterstützungen  
foreach x in "*kurzarbeit*" 				///
			 "*schwangerschaftsversich*"	///
			 "*alg*" 						///
			 "*aufstockung*"				///
			 "*s?forthilfe*" 				///	
			 "*sofort hilfe*"				///
			 "*corona?zuschuss*"			///
			 "*beihilfe*"					///
			 "*coronahilfe*"				///
			 "*förderhilfe*"				///
			 "*senat*"						///
			 "*rettungsschirm*"				///
			 "*selbstständigenunterstütz*"	///
			 "*zuschuss*"					///
			 "*entschädigung*"				///
			 {
	strrec q11other ("`x'" = "2"), sub replace string
}

*1 Nein (Einkommen reduziert sich genauso stark wie Arbeitszeit)
foreach x in "*freiwilliger verzicht*" 		///
			 "* ?0%*"						///	
			 "?0%*"							///
			 "*aber keine Einnahmen durch*"	///
			 "*einnahmen aus*entfallen*"	///
			 "*neue*minijob*"				///
			 "kein einkommen"				///
			 "*geringeres einkommen*"		///
			 "*nacharbeitungb*"				///
			 "*nahezu komplett zusammenge*"	///
			 {
	strrec q11other ("`x'" = "1"), sub replace string
}



*3 Ja, ich beziehe weiterhin mein volles Gehalt
foreach x in "*minusstunden*" 				///
			 "*stundenkonto*im minus*"		///
			 "*wird geschoben*"				///
			 "*urlaub*"						///
			 "*gehalt bleibt gleich*"		///
			 "*gleiches gehalt*"			///
			 "*normales gehalt*"			///
			 "*gleiches einkommen*"			///
			 "*weiterhin volles gehalt*"	///
			 "*keine veränderung*gehalt*"	///
			 "*einkommen*in voller höhe*"		///
			 "*gehalt*im gleichen umfang*"		///
			 "*einkommen in voller höhe*"		///
			 "*unveränderte arbeitsbedingung*"	///
			 "*gehalt voll*"				///
			 "*einkommen reduziert sich nicht*"	///
			 "*bezahlte kinderbetreuungstage*"	///
			 "*alle arbeitstage abrechnen*"		///
			 "*lohnfortzwahlung*"			///
			 "*gleiche*gehalt*"				///
			 "*ffentlicher dienst*"			///
			 "*bekomme*gleiche geld*"		///
			 "*geringerer arbeitsanfall*"	///
			 "*lohnfortzahlung*"			///
			 "*promotionsstipendium*"		///
			 "*beamt*"						///
			 "*arbeite im home office einfach wenig*"	///
			 "flexbile arbeit*"				///
			 "*ausbildungsförderung*"		/// 
			 "*gleitzeit*"					///
			 "*baue mehrstunden*" 			///
			 "*berst**"						///
			 "*stundenabbau*"				///
			 "*mehrstundenausgleich*"		///
			 "*plusstunden*"				///
			 "*freiwilliges entgegenkommen des ag*"	///
			 "*genauso viel geld"			///
			 "honorar für stundenaus*"		///
			 {
	strrec q11other ("`x'" = "3"), sub replace string
}

*	Arbeitet eigentlich nicht
*Elterzeit
foreach x in "*schwangerschaft*" {
	strrec q11other ("`x'" = "9"), sub replace string
}

* Unklare Fälle --> Missing
foreach x in "*noch unklar*" {
	replace q11compen = . if strmatch(q11other, "`x'")
	strrec q11other ("`x'" = ""), sub replace string
}

*Nicht arbeitende richtig zuordnen
replace q03empsts = 0 if inlist(q11other, "8", "9", "10", "11")

foreach var of varlist q04newemp q05* q06* q07* q08* q10currenttime ///
	q11compen q11usualwh q11lastwh q12office q12time* q13support ///
	q20sat11 q21concern12 {
	replace `var' = .b if inlist(q11other, "8", "9", "10", "11")
}

replace q12officeother = "" if inlist(q11other, "8", "9", "10", "11")

*Arbeitslos
replace q04status  = 2 if q11other == "8"
*Elternzeit
replace q04status  = 4 if q11other == "9"
*Studierende
replace q04status  = 1 if q11other == "10"
*Rente
replace q04status  = 3 if q11other == "11"

*	zum Überprüfen der Recodierung
list q11other if !inlist(q11other, "0", "1", "2", "3", "")

*	Fälle richtig zuordnen
foreach num of numlist 1/3 {
	replace q11compen = `num' if q11other == "`num'"
}

*	Hilfsvariable löschen
drop q11other

exit
