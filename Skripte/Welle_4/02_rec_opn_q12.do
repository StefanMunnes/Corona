/* Kodierung der offenen Antworten Frage
	q12officeother: Von wo aus arbeiten Sie im Moment?

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

*list q12other if q12other != ""

* Offene Eingaben mit problematischer Zuordnung:
strrec q12other ("32" = ""), sub replace string

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


foreach x in "*urlaub*" "*ferien*" "Überstundenabbau"	///
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
			 "immer*am arbeitsplatz*"		///
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
			 "*immer im büro*"			///
			 "*wieder im geschäft*"		///
			 "*an meinem neuen arbeitsort*"	///
			 "1 tag im home*vor ort*"	///
			 "*3 tage arbeitsort*"	///
			 "*3 tage am arbeitsort*"	///
			 "*3 tage * büro*"		///
			 "*2/3 arbeitsort*"		///
			 "*3/4arbeitsort*"		///
			 "3/5 Arbeitsort*"	///
			 "*mehr am arbeitsort*"	///
			 "*gastronomie*"		///
			 "*einen tag home office*"	///
			 "*drei tage an der arbeitsstelle*"	///
			 "*bei klienten in*"	///
			 "*an den arbeitsorten*"	///
			 "*aussendienst*"	///
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
			 "*am arbeitsort*"	///
			 "*nur*arbeitsplatz"	///
			 "*firma"	///
 			 "*20% home office"	///
			 "*2 tage home*"	///
			 "*1 tag*zu hause"	///
			 "*nur vor ort*"	///
			 "*immer*praxis*"	///
			 "*impfzentrum*"	///
			 "immer*bei*klient*"	///
			 "*baustelle*"	///
			 "*krche*"	///
			 "*in*praxis*" ///
			 "*kraftfahr*" ///
			 "25% zuhause" ///
			 "*zwei tage*homeoffice*drei*dienststelle" ///
			 "3 tage büro*" ///
			 "kein homeoffice" ///
			 "*40%*homeoffice*" ///
			 "60% homeoffice*" ///
			 "*2 tage home*" ///
			 "*2 tage*homeoffice" ///
			 "3 arbeitsstelle*" ///
			 "*80% arbeitsort*" ///
			 "tagespflege" ///
			 "atelier" ///
			 "jetzt wieder*präsenz*" ///
			 "*gemietet*" ///
			 "*workingspace*" ///
			 "*seit vergangener woche*"	///
			 "wegen corona eigenes b?ro*"	///
			 "am bedarf der klientinnen ausge*"	///
			 "*landwirtschaft*"	///
			 "beim kunden (inhou*"	///
			 "bei kunden vor ort"	///
			 "außendienst"	///
			 "beim kunden*"	///
			 "ambulant*in privaten hausha*"	///
			 "*im büro zwecks einarbei*"	///
			 {
	strrec q12other ("`x'" = "1"), sub replace string
}

* 3. Wie immer von zu Hause
foreach x in "*b?ro im haus" 			///
			 "arbeitsort ist zuhause*"	///
			 "wie meistens von zu hause aus"	///
			 "*aber nicht wegen corona*"	///
			 "*aber nicht wegen der pandemie*"	///
			 {
	strrec q12other ("`x'" = "3"), sub replace string
}

* 2. Aufgrund der Corona Pandemie ?berwiegend zuhause
foreach x in "*ausschließlich*zu hause*" ///
			 "*?berwiegend von zu hause*"	///
			 "*?berwiegend von zuhause*"	///
			 "*haupts?chlich von zu hause*"	///
			 "*nur*zu hause*"			///
			 "*ab*homeoffice*" 			///
			 "*home office und zeitweise*"	///
			 "aufgrund corona überwiegend zu*"	///
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
			 "*seit*homeoffice*"			///
			 "*100%*hause*"			///
			 "immer zu hause"			///
			 "nur*home office"			///
			 "*jeden tag zu hause"			///
			 "*büro*zuhause" ///
			 "von*zu hause*" ///
			 "*drei tage*zu hause*" ///
			 "60% home*" ///
			 "*von zu hause*" ///
			 "*rest zu hause" ///
			 "*in der familie" ///
			 "homeoffice und ausland"	///
			 "aufgrund corona*ausland"	///
			 "wenn möglich*sonst*online" ///
			 {
	strrec q12other ("`x'" = "2"), sub replace string
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
			 "mix*"				///
			 "ambulant*zu hause*" ///
			 "wenn möglich*sonst*hause" ///
			 "*am bedarf * ausgerichtet" 	///
			 "distanz*und*präsenzunt*" 	///
			 "*draußen*home*" 			///
			 "arbeitsort (kunden), büro*"	///
			 "homeoffice, außendienst, büro"	///
			 "*SPFH und zu Hause"	///
			 "*arbeitsort und zu hause"	///
			 {
	strrec q12other ("`x'" = "4"), sub replace string
}

* Fälle richtig zuordnen
foreach num of numlist 1/5 {
	replace q12office = `num' if q12other == "`num'"
}

*	zum Überprüfen der Recodierung
list q12other if !inlist(q12other, "0", "1", "2", "3", "4", "")

/*
*Überprüfungstabelle
preserve
keep id q12office q12other q12officeother
order id q12office q12other q12officeother
keep if q12officeother != ""
sort q12office q12officeother
lab var q12office		   "Von wo aus arbeiten Sie im Moment?"
lab define office_lab ///
  0	"Sonstiges" ///
  1	"Weiterhin (überwiegend) am Arbeitsort" ///
  2	"Aufgrund der Corona Pandemie (überwiegend) von zu Hause aus" ///
  3	"Wie immer von zu Hause aus" ///
  4 "Etwa gleich oft am Arbeitsort und zu Hause"
lab val q12office office_lab
browse
restore 
*/
*Hilfsvariable löschen
drop q12other 

exit
