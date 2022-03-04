/* Kodierung der offenen Antworten Frage
	q32officeparother: Von wo aus arbeitet ihr Partner im Moment?

in 4 Kategorien:
	0. Sonstiges (neu)
	1. Weiterhin (überwiegend) am Arbeitsort
	2. Aufgrund der Corona Pandemie (überwiegend) von zu Hause aus
	3. Wie immer von zu Hause aus
	4. Arbeitet zurzeit nicht
	5. Etwa gleich oft am Arbeitsort und zu Hause
*/

*******************************
*
*	Unklare Fälle
*	Wenn angegeben wurde, dass Partner selten/kaum arbeitete aber kein Ort angegeben wurde --> Partner/in arbeitet zurzeit nicht
*	Wenn Arbeitsort nicht zuhause ist (separates Büro, gleiches Grundstück aber nicht zuhause etc.) --> am Arbeitsort
*	Wenn Abhängig von Inzidenz --> Halb/Halb
*******************************

* Hilfsvariable erstellen
cap drop q32other
gen q32other = strlower(q32officeparother)


*	Rekodierung von Personen die zZt nicht arbeiten:
foreach x in "*xy" {
	replace q10currenttime = 4 	if strmatch(q32other, "`x'")
	replace q11reason = 1 		if strmatch(q32other, "`x'")
	replace q32other = "" 		if strmatch(q32other, "`x'")
}


* Kurzarbeit 100% --> arbeitet zZt nicht
foreach x in "*kurzarbeit 0*" ///
			 "*kurzarbeit 100%*" ///
			 "*kurzarbeit gar nicht*"	/// 
			 "*insolvenz des unternehmens*"	/// 
			 "*laden ist zu*" ///	
			 "*gar nicht*kurzarbeit*"	///
			 {
			 strrec q32other ("`x'" = "4"), sub replace string	
}

* Nicht klar einzuordnende Kurzarbeit
foreach x in "kurzarbeit" 			///
			 "kurzarbeit "			///
			 "kurzarbeit*fitness*"	///
			 "kurzarbeit und tageweise*"	///
			 "meist kurzarbeit*"		///
			 "überwiegend in kurzarbeit*"	///
			 "hotelgewerbe*kurzarbeit*"	///
			 "einzelhandel/kurzarbeit"	///
			 {
			  strrec q32other ("`x'" = "kurzarbeit"), sub replace string	 
}
			 
* 1. Weiterhin(überwiegend) am Arbeitsort
foreach x in "*wieder am arbeitsort*"	///
			 "*außendienst*"			///
			 "*eigene*praxis*"			///
			 "*da wo arbeit ist*"		///
			 "*häuslicher pflegedie*"	///
			 "*ausschließlich am arbeitsort*"	///
			 "*wieder im büro*"			///
			 "*nur präsenz*"			///
			 "*im pflegedienst*"		///	
			 "*nachsorge vor ort*"		///
			 "*fahrschulauto*"			///
			 "reisend"					///
			 "reisende"					///
			 "ambulant"					///
			 "an einem ausweicharbeitsort*"	///
			 "*deutschlandweit*"		///
			 "*zuhause im geschäftsbüro*"	///
			 "*an einer botschaft im ausland*"	///
			 "*angemietetes büro*"		///
			 "*eigene räumlichkeiten*"	///
			 "*arbeitswohnung*"	///
			 "*im gleichen haus, aber*"	///
			 "*gleiches grundstück wie zuhause"	///
			 "*gelegentlich*tonstudio*"	///
			 "*landwirtschaft*"	///
			 "*2/5 zu hause*"	///
			 "*baustelle*"	///
 			 "*in der schule*"	///
			 {
	strrec q32other ("`x'" = "1"), sub replace string
}

* 2. Aufgrund der Corona Pandemie überwiegend zuhause
foreach x in "*aufgrund*von zu hause*"	///
			 "*seit 1. lockdown nur*"	///
 			 "50 % kurzarbeit*"			///
			 "nur zu hause"	///
			 {
	strrec q32other ("`x'" = "2"), sub replace string
}

* 3. Wie immer von zu Hause
foreach x in "wie immer über*zu hause*" ///
			 "*firmengründungsphase*"	///
			 {
	strrec q32other ("`x'" = "3"), sub replace string
}

*4. Partner/in arbeitet zurzeit nicht
foreach x in "*100%kurzarbeit*"	///
			 "*krank*" 				///
			 "*mutterschu*"			///
			 "*unfall*"	///
			 "*elternzeit*"			///
			 "*arbeitet gar nicht*"	///
			 "*garnicht*"	///
			 "*gar nicht*"	///
			 "*keine arbeit*"	///
			 "*arbeitslos*"		///
			 "*arbeitsunfähig*"	///
			 "*aktuelle keine jobange*"	///
			 "*frei gestellt*"	///
			 "*berufsverbot*"	///
			 "*arbeitsverbot*"	///
			 "*coronabedingte schließung*"	///
			 "*job ruht*"	///
			 "*freigestellt*"  ///
			 "*arbeitet kaum, betreut die kinder*"	/// 
			 "*selten nach bedarf*"	///
			 "*nicht aufgrund der corona*"	///
			 "*gekündigt*"	///
			{
	strrec q32other ("`x'" = "4"), sub replace string
}

*5. Halb/Halb
foreach x in "*wechsel*" "*je nach*inzidenz*" "*schulsituation*"	///
			 "zu hause und draussen"	///
			 "*kundenkontakt vor ort*"	///
			 {
	strrec q32other ("`x'" = "5"), sub replace string
}

*Fälle richtig zuordnen
foreach num of numlist 1/5 {
	replace q32officepar = `num' if q32other == "`num'"
}

/*
*zum Überprüfen der Recodierung
list q32other if !inlist(q32other, "0", "1", "2", "3", "4", "5", "")

*Überprüfungstabelle
preserve
keep id q32officepar q32other q32officeparother
order id q32officepar q32other q32officeparother
keep if q32officeparother != ""
sort q32officepar q32officeparother
lab var q32officepar	"Partner: aktuelle Arbeitsplatz"
lab define officepar_lab ///
  0	"Sonstiges" ///
  1	"Weiterhin (überwiegend) am Arbeitsort" ///
  2	"Aufgrund der Corona Pandemie (überwiegend) von zu Hause aus" ///
  3	"Wie immer von zu Hause aus" ///
  4 "Arbeitet zurzeit nicht" ///
  5 "Etwa gleich oft am Arbeitsort und zu Hause"
lab val  q32officepar officepar_lab
browse
restore 
*/
*Hilfsvariable löschen
drop q32other


exit
