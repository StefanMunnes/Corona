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
*	"zuhause und öffentl. bibliothek"
		*halbe/halbe
*	"famileien"
		*keine Ahnung --> missing
*	"kann erst seit dieser woche wieder arbeiten"
		*keine Ahnung --> missing
*
*******************************



* Hilfsvariable erstellen
cap drop q32other
gen q32other = strlower(q32officeparother)


*	Rekodierung von Personen die zZt nicht arbeiten:
foreach x in "*urlaub*" "*ferien*" {
	replace q10currenttime = 4 	if strmatch(q32other, "`x'")
	replace q11reason = 1 		if strmatch(q32other, "`x'")
	replace q32other = "" 		if strmatch(q32other, "`x'")
}

* 1. Weiterhin(überwiegend) am Arbeitsort
foreach x in "*verschiedenen ort*"		///
			 "*montage*"				///
			 "*wieder am arbeitsort*"	///
			 "*kurzarbeit*" 			///
			 "am arbeitsort*"			///
			 "*außendienst*"			///
			 "*überwiegend am arbeitsort*"	///
			 "*überwiegend am arbeitsplatz*"	///
			 "*immer am arbeitsort*"	///
			 "*im fahrschulauto*"		///
			 "*nur noch am arbeitsplatz*"	///
			 "*aussenstelle*"			///
			 "auswärts*"				///
			 "*ist immer unterwegs*"	///
			 "geschäft"					///
			 "auf dem schiff*"			///
			 "*wieder vom arbeitsort*"	///
			 "*proberaum, studio*"		///
			 "*im sehr eingescvhränktem rahmen*"	///
			 "*ausweichbüro*"			///
			 "wieder (leider) am arbeitsort*"	///
			 "*augenarztpraxis*"		///
			 "*nächste woche wieder homeoffice*"	///
			 "i'm auto*"				///
			 "*strassenmusiker*"		///
			 {
	strrec q32other ("`x'" = "1"), sub replace string
}

* 2. Aufgrund der Corona Pandemie überwiegend zuhause
foreach x in "*ereitschaft*" 			///
			 "*aufgrund*corona*" 		///
			 "*?berwiegend zu hause*" 	///
			 "*?berwiegend von zu hause*"	///
			 "*nicht mehr*kunden*"		///
			 "*ab und zu mal*zu  hause*"	///
			 "von zu hause*"			///
			 "*viel im homeoffice*"		///
			 "in seiner wohnung*"		///
			 "*mehr homeoffice*"		///
			 "*ab nächster woche*arb*"	///
			 "zweitwohnung"				///
			 "*büro und *m grundstück*"	///
			 {
	strrec q32other ("`x'" = "2"), sub replace string
}

* 3. Wie immer von zu Hause
foreach x in "büro im haus" "arbeitsort ist zuhause*"	{
	strrec q32other ("`x'" = "3"), sub replace string
}

*4. Partner/in arbeitet zurzeit nicht
foreach x in "*krank*" 				///
			 "*sabbat*"				///
			 "*elternzeit*"			///
			 "*kann nicht arbeiten*"	///
			 "*online schule*"		///
			 "*arbeitet momentan nicht*"	///
			 "*arbeitet gar nicht*"	///
			 "*arbeitet nicht*"		///
			 "*arbeitet er nicht*"	///
			 "nicht"		///
			 "*garnicht*"	///
			 "*gar nicht*"	///
			 "nirgends*"	///
			 "*derzeit überhaupt nicht*"	///
			 "*alle auftriite fallen aus*"	///
			 "*sommerferien (lehrer)*"		///
			 "*freigestellt*"  {
	strrec q32other ("`x'" = "4"), sub replace string
}


*5. Halb/Halb
foreach x in "*teils*" 					///
			 "*halbe*" 					///
			 "*wechsel*" 				///
			 "*teil*" 					///
			 "*halb*" 					///
			 "*unterwegs und von zu hause*"	///
			 "*mal so mal so*"			///
			 "*zuhause und öff*"		///
			 "*zuhause und öffentl. bibliothek*"	///
			 {
	strrec q32other ("`x'" = "5"), sub replace string
}

*Fälle richtig zuordnen
foreach num of numlist 1/5 {
	replace q32officepar = `num' if q32other == "`num'"
}


*zum Überprüfen der Recodierung
list q32other if !inlist(q32other, "0", "1", "2", "3", "4", "5", "")


*Hilfsvariable löschen
drop q32other


exit
