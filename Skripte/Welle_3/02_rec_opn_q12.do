/* Kodierung der offenen Antworten Frage
	q12status: Von wo aus arbeiten Sie im Moment?

in 4 Kategorien:
	0. Sonstiges
	1. Weiterhin (?berwiegend) am Arbeitsort
	2. Aufgrund der Corona Pandemie (?berwiegend) von zu Hause aus
	3. Wie immer von zu Hause aus
	4. Etwa gleich oft am Arbeitsort und zu Hause
*/

* Hilfsvariable erstellen
cap drop q12other
gen q12other = strlower(q12officeother)

* Offene Eingaben mit problematischer Zuordnung:
strrec q12other ("xyx" = "xyx"), sub replace string

*Rekodierung zu arbeitet zZt nicht und krankgeschrieben (q10, q11, q12 missing)
foreach x in "*krankgeschriebe*" ///
			 {
	replace q10currenttime = 4 if strmatch(q12other, "`x'")
	replace q11reason = 5 if strmatch(q12other, "`x'")
	replace q12office = .b if strmatch(q12other, "`x'")
	replace q12other = "" if strmatch(q12other, "`x'")
}

foreach x in "*gar nicht*"	///
			 {
	replace q10currenttime = 4 if strmatch(q12other, "`x'")
	replace q11reason = 3 if strmatch(q12other, "`x'")
	replace q12office = .b if strmatch(q12other, "`x'")
	replace q12other = "" if strmatch(q12other, "`x'")
}


foreach x in "*urlaub*" "*ferien*"	///
			 {
	replace q10currenttime = 4 if strmatch(q12other, "`x'")
	replace q11reason = 1 if strmatch(q12other, "`x'")
	replace q12office = .b if strmatch(q12other, "`x'")
	replace q12other = "" if strmatch(q12other, "`x'")
}

* 1. Weiterhin(überwiegend) am Arbeitsort + Wieder überwiegend am Arbeitsort
foreach x in "aufsuchend*"				///
			 "eigenes b?ro*"			///
			 "*hausbesuche*"			///
			 "immer*am arbeitsort*"		///
			 "*wieder*am arbeitsort*"	///
			 "*wieder*vom arbeitsort*"	///
			 "*wieder*am arbeitsplatz*"	///
			 "*?berwiegend am arbeitsort*"	///
			 "*?berwiegend auf der arbeit*"	///
			 "*?berwiegend im büro*"	///
			 "*meist am arbeitsort*"	///
			 "*h?ufiger am arbeitsort*"	///
			 "*kinderbetreuung draußen*"	///
			 "*wieder mehr im büro*"	///
			 "*wieder im büro*"			///
			 "*wieder im geschäft*"		///
			 "*3 tage arbeitsort*"	///
			 "*3 tage am arbeitsort*"	///
			 "*3 tage im büro*"		///
			 "*2/3 arbeitsort*"		///
			 "*3/4arbeitsort*"		///
			 "arbeitsort*"			///
			 "*mehr am arbeitsort*"	///
			 "*gastronomie*"		///
			 "*einen tag home office*"	///
			 "*drei tage an der arbeitsstelle*"	///
			 "*bei klienten in*"	///
			 "*an den arbeitsorten*"	///
			 "*aussendienst*"	///
			 "*außendienst*"	///
			 "*nur in der praxis*"	///
			 "2.niederlassung*"		///
			 "2. niederlassung*"	///
			 "neu angemieteter arbeitsplatz*"	///
			 "coworking*"	///
			 "*fast ausschließlich von arbeitsort*"	///
			 "*wieder auf der arbeit*"	///
			 "*unterwegs*"	///
			 "*seminarort*"	///
			 "*(überwiegend) von am arbeitsort*"	///
			 "*kundentermine haben*wieder begonnen*"	///
			 {

	strrec q12other ("`x'" = "1"), sub replace string
}

* 2. Aufgrund der Corona Pandemie ?berwiegend zuhause
foreach x in "*ausschließlich*zu hause*" ///
			 "*?berwiegend von zu hause*"	///
			 "*?berwiegend von zuhause*"	///
			 "*haupts?chlich von zu hause*"	///
			 "*nur*zu hause*"			///
			 "*ab*homeoffice*" 			///
			 "*bei*partner*" 			///
			 "*jetzt 100% home*"		///
			 "*75% homeoffice*"			///
			 "*zwei tage arbeitsort*"	///
			 "*2 tage arbeitsort*"		///
			 "*3/5 homeoffice*"			///
			 "*5 zu hause*"				///
			 "*3 tage zuhause*"			///
			 "*3 tage zu hause*"		///
			 "*3 tage homeoffice*"		///
			 "*2 tage büro*"			///
			 "*wohnort meines partner*"	///
			 "zu hause*auf dem land*"	///
			 "*komplett zu hause*"		///
			 "*ein viertel am arbeits*"	///
			 "*zu hause*ausland*"		///
			 "*3 (ho)*"					///
			 "*1x woche am arbeitsort*"	///
			 "*mehr als sonst von zu hause aus*"	///
			 "*zweitwohnung*"			///
			 "zu hause und im freiland*"	///
			 "*ferienwohnung*"			///
			 "*eigenes büro*"			///
			 {
	strrec q12other ("`x'" = "2"), sub replace string
}

* 3. Wie immer von zu Hause
foreach x in "b?ro im haus" 			///
			 "arbeitsort ist zuhause*"	///
			 "wie meistens von zu hause aus"	///
			 "*aber nicht wegen corona*"	///
			 {
	strrec q12other ("`x'" = "3"), sub replace string
}

*4. Halb/Halb
foreach x in "*wochenweise*" 			///
			 "*50*" 					///
			 "*teil*" 					///
			 "*halb*" 					///
			 "*online? und präsenzunt*"	///
			 "*job 2 (neu corona): klinik*"	///
			 "je nach arbeitsaufgabe*"	///
			 "je nach projekt" ///
			 {
	strrec q12other ("`x'" = "4"), sub replace string
}

* Fälle richtig zuordnen
foreach num of numlist 1/5 {
	replace q12office = `num' if q12other == "`num'"
}



*	zum ?berpr?fen der Recodierung
list q12other if !inlist(q12other, "0", "1", "2", "3", "4", "")

*Hilfsvariable löschen
drop q12other 

exit
