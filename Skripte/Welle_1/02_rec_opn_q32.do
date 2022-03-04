/* Kodierung der offenen Antworten Frage
	q32officeparother: Von wo aus arbeitet ihr Partner im Moment?

in 4 Kategorien:
	0. Sonstiges (neu)
	1. Weiterhin (überwiegend) am Arbeitsort
	2. Aufgrund der Corona Pandemie (überwiegend) von zu Hause aus
	3. Wie immer von zu Hause aus
	4. Arbeitet gar nicht
	5. Etwa gleich oft am Arbeitsort und zu Hause (neu)
*/


* Hilfsvariable erstellen
cap drop q32other
gen q32other = strlower(q32officeparother)

*0. Sonstiges
*Lernen für die Prüfung = Eine im Gesundheitssystem durch die aktuelle Situation weniger Stunden arbeitende Person.
foreach x in 	 "*14-tage schicht*"  {
	strrec q32other ("`x'" = "0"), sub replace string
}

*5. Halb/Halb
foreach x in "*50/50*"					///
			 "*woche zuhause*" 			///
			 "*eine woche*" 			///
			 "beides"					///
			 "*wochenweise*" 			///
			 "*teils*" 					///
			 "*50*" 					///
			 "*im büro*"				///
			 "*halbe*" 					///
			 "*wechsel*" 				///
			 "*hälftig*" 				///
			 "*teil*" 					///
			 "*hälfte*" 				///
			 "*halb*" 					///
			 "*hause und*arbeit*" 	///
			 "*1/2 arbeitso*" ///
			 "*mischung*"				///
			 "*gesplittet*"				///
			 "*sowohl von*" 			///
			 "1 woche haus, 1*"			///
			 "2 wochen büro 2 wochen*"	///
			 "unterwegs und von zu hause"	///
			 {
	strrec q32other ("`x'" = "5"), sub replace string
}

* 1. Weiterhin(überwiegend) am Arbeitsort
// draußen = Baustelle
foreach x in "60% büro*"				///
			 "60 % arbeitsort*"			///
			 "*3 tage büro*"				///
			 "*immer am arbeits*"		///
			 "im privaten büro"			///
			 "*verschiedene*arbeits*"	///
			 "*landwirt*"				///
			 "*mehr*arbeits*"			///
			 "blockarbeitsz*"			///
			 "kundentermine außer haus*"	///
			 "*therpeut*"				///
			 "am arbeitsort*"			///
			 "*außendienst*"			///
			 "*deutschlandweit*"		///
			 "*ständig unterwegs*"		///
			 "*nicht von unserer woh*"	///
			 "*nur an einzelnen tagen*"	///
			 "*binnenschiff*"			///
			 "*anderen zweigstelle*"	///
			 "*überwiegend in der schule*"	///
			 "*ort ist nicht fest*"		///
			 "*muss zurzeit weniger*"	///
			 "*in der betriebsstätte*"	///
			 "*auch vom arbeitsplatz*" 	///
			 "*zustellerin*"			///
			 "*arbeitet diesen monat nur einen tag*" ///
			 "*arbeitet aber weiter angestellt*" ///
			 "*arbeitet*noch*"			///
			 "*selbst. logopäd*"		///
			 "*notbetreuu*"				///
			 "*kurzarbeit*" 			///
			 "zwei-mann büro"			///
			 "weniger stunden"			///
			 "*mehr in der arbeit*"		///
			 "*arbeitet am arbeitsort*"	///
			 "*selbständig handwerker"	///
			 "*als freiberufler brechen a*"	///
			 "*wie bisher am dienstort*"	///
			 "*woche am arbeitsort"	///
			 {
	strrec q32other ("`x'" = "1"), sub replace string
}

* 3. Wie immer von zu Hause
foreach x in "*wie immer von zu hause*"	///
			 "*immer von zuhause*"		///
			 "selbstständig"			///
			 "*hause wie immer*"		///
			 "*in seinem studio*"		///
			 "*selbständiger 1mann betrieb,*"	///
			 "*in meiner firma*"		///
			 "*selbstständig*"			///
			 "forschungsfreisemester"	///
			 "selbständig"				///
			 "selbständige?"			///
			 "selbstständig/home*"		///
			 "*ständig*zu hause*"		///
			 {
	strrec q32other ("`x'" = "3"), sub replace string
}

* 2. Aufgrund der Corona Pandemie überwiegend zuhause
foreach x in "*ausschließlich*zu hause*" ///
			 "*ereitschaft*" 			///
			 "lehrerin"					///
			 "*aktuell*homeoffice*" 	///
			 "*zuhause*aufgrund*corona*" 		///
			 "*nur*zuhause*"			///
			 "*zweitwohnsitz*" 			///
			 "*bei*partner*" 			///
			 "*beschäftigungsverbot*"	///
			 "*auf dem land*"			///
			 "*videosprechstunde*"		///
			 "*von zu hause aus*"		///
			 "*unterricht*video*"		///
			 "*reduziertem umfang*hause*" ///
			 "*stark reduziert zu hause*"	///
			 "*drei tage auf der*"		///
			 "*aufgrund*corona*" 		///
			 "*studio gek?ndigt*"		///
			 "*wegen corona nicht*"		///
			 "*schließung des betrieb*"	///
			 "aufgrund der kinderbetreuung*"	///
			 "*arbeitet im ausland im homeoffice*"	///
			 "*hause*" ///
			 "*homeoffice*" ///
			 "*schulschließung*" ///
			 "auf abruf"	///
			 {
	strrec q32other ("`x'" = "2"), sub replace string
}

*4. Partner/in arbeitet zurzeit nicht
foreach x in "*krank*" 				///
			 "*freistellung*"		///
			 "*betrieb*geschloss*"	///
			 "*studium*"			///
			 "*arbeitsverbot*"		///
			 "*wegen op zu*"		///
			 "*feigestellt*"		///
			 "*zwei tagen online schule*" ///
			 "*minusstunden*"		///
			 "*proben ohne vergütung*" ///
			 "*gelegentlich linienverkehr*"	///
			 "*ausbildung*nicht möglich*" ///
			 "*urlaub*"			 		///
			 "*Überstunden*" ///
			 "*freigestellt*"  	///
			 "*sabbat*"	///
			 "*im sadatical*"	///
			 "*quarantäne*"	///
			 "*arbeitsunfähig.*"	///
			 "hat aufträge verloren"	///
			 "*arbeitet zur zeit nicht*"	///
			 "der arbeitsort ist im ausland*"	/// 
			 "*arbeitet kaum*" ///
			 "*nur ab und zu*" ///
			 "*nicht gearbeitet*" ///
			 {
	strrec q32other ("`x'" = "4"), sub replace string
}


*Fälle richtig zuordnen
foreach num of numlist 0/5 {
	replace q32officepar = `num' if q32other == "`num'"
}

*Rekodierung von Personen die zZt nicht arbeiten:
*q32officepar zu missing
*q30empst
foreach x in "*rent*"	"*elternzeit*"	"*mutterschutz*"		///
	{
	replace q32officepar = .b if strmatch(q32other, "`x'")
	replace q30empstspar = 0 if strmatch(q32other, "`x'")
	replace q32other = "" if strmatch(q32other, "`x'")
}

*zum Überprüfen der Recodierung
list q32other if !inlist(q32other, "0", "1", "2", "3", "4", "5", "")

*Hilfsvariable löschen
drop q32other 


exit
