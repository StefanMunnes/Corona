/* Kodierung der offenen Antworten Frage
	q12status: Von wo aus arbeiten Sie im Moment?

in 4 Kategorien:
	0. Sonstiges (neu)
	1. Weiterhin (überwiegend) am Arbeitsort
	2. Aufgrund der Corona Pandemie (überwiegend) von zu Hause aus
	3. Wie immer von zu Hause aus
	4. Etwa gleich oft am Arbeitsort und zu Hause
*/

* Hilfsvariable erstellen
cap drop q12other
gen q12other = strlower(q12officeother)

*0. Sonstiges
foreach x in "*befindet sich*in der klärung*" ///
			 "1x die woche"				///
			 "systemrelevante alternative"	///
			 "ausbildung- fällt weg" ///
			 {
	strrec q12other ("`x'" = "0"), sub replace string
}

* 1. Weiterhin(überwiegend) am Arbeitsort
// draußen = Baustelle
foreach x in "30 % zu hause" 			///
			 "*bei den bienen*" 		///
			 "extern"					///
			 "räume des ag*" "*büro*alleine*" ///
			 "ausgelagertes büro*" 		///
			 "*am arbeitsort, nachts*"	///
			 "*praxis*"					///
			 "eigenes büro*"			///
			 "*montage*"				///
			 "andere einsatzort*"		///
			 "*lieferservice*"			///
			 "aufsuchend" 				///
			 "*draußen*"				///
			 "arbeitsort"				///
			 "im privaten büro"			///
			 "anderes büro"				///
			 "atelier"					///
			 "*kurzarbeit*" 			///
			 "*bis gestern am arbeitsort*" ///
			 "*standort*"				///
			 "*10% home office*"		///
			 "*hausbesuche*"			///
			 "*eigener praxis*"			///
			 "*zweigstelle*firma*"		///
			 "*im krankenhaus*"			///
			 "*im food truck*"			///
			 "*senioremheim*"			///
			 "wie zuvor am arbeitsort*"	///
			 "büro des partners"		///
			 "jeweils vor ort"{
	strrec q12other ("`x'" = "1"), sub replace string
}

* 2. Aufgrund der Corona Pandemie überwiegend zuhause
*Lernen für die Prüfung = Eine im Gesundheitssystem durch die aktuelle Situation weniger Stunden arbeitende Person.
foreach x in "100% mobile*"  			///
			 "*100%*zu*hause*"			///
			 "*immer von zu hause*"		///
			 "*ausschließlich*zu hause*" ///
			 "*ereitschaft*" 			///
			 "*aktuell*homeoffice*" 	///
			 "*aufgrund*corona*" 		///
			 "wohnung elternteil*" 		///
			 "*?berwiegend von zu hause*"	///
			 "*?berwiegend zu hause*"	///
			 "*nur noch zu?hause*" 		///
			 "*nur hause*"				///
			 "*vorwiegend zuhause*" 	///
			 "von zu hause" 			///
			 "*nur*zuhause*"			///
			 "*nur*zu hause*"			///
			 "z.t. home-office*" 		///
			 "*von der wohnung*" 		///
			 "*ausschließlich*zuhause*" ///
			 "*hause*jetzt ausschließlich*"	///
			 "home?office statt*" 		///
			 "*zweitwohnsitz*" 			///
			 "home?office" "homeoffice" ///
			 "*home-office*ganze firma*" ///
			 "familienhaus im ausland"  ///
			 "*eltern aufs land*"		///
			 "zuhause und in einem gemieteten büro in einem kreativhaus" ///
			 "*wochenendhaus*" 			///
			 "online unterricht"		///
			 "*jetzt neu*" 				///
			 "*auf dem land*"			///
			 "zunächst von zu hause aus" ///
			 "*haus der eltern*" 		///
			 "in der wohnung meiner*" 	///
			 "*komplett von zu hause*" 	///
			 "*elternhaus*" "datsche*" 	///
			 "von zu hause (*" 			///
			 "zu hause" 				///
			 "einen tag in der beratungsstelle*" ///
			 "4 von 5 tagen im homeoffice"	///
			 "selbstständige tätigkeit von zu hause*" ///
			 "noch zu hause*" 			///
			 "exklusiv*homeoffice*"		///
			 "*lernen*prüfung*"			///
			 "*seit*im home office*"	///
			 "*ohne*externe Termine*"	///
			 "*3/4 zu hause"			///
			 "*zu hause bei*"			///
			 "*keine aussendiensttermine*" ///
			 "*⅓*" 						///
			 "*keine veranstaltungen*"	///
			 "*nur noch 1 tag*im büro*"	///
			 "*eigens angemietete wohnung*"	///
			 "*bei meinem partner*" ///
			 "anstatt am arbeitsort bei meinen eltern*" {
	strrec q12other ("`x'" = "2"), sub replace string
}

* 3. Wie immer von zu Hause
foreach x in "*aufgrund*semesterferien*" ///
			 "weiterhin überwiegend von zuhause*" ///
			 "büro im haus" 			///
			 "*privates büro*" 			///
			 {
	strrec q12other ("`x'" = "3"), sub replace string
}

*4. Halb/Halb
foreach x in "*woche büro*" 			///
			 "*woche zuhause*" 			///
			 "*eine woche*" 			///
			 "*wochenweise*" 			///
			 "*teils*" 					///
			 "*50*" 					///
			 "*im büro*"				///
			 "*wechsel*" 				///
			 "*gleichmäßig verteilt*" 	///
			 "*hälftig*" 				///
			 "*arbeitsort und home office*" ///
			 "*teil*" 					///
			 "*gemischt*" 				///
			 "*hälfte*" 				///
			 "*halb*" 					///
			 "büro und homeoffice*" 	///
			 "arbeitsort und von zu hause" ///
			 "2 tage vor ort 2 tage zu hause*" ///
			 "von zu hause und*" 		///
			 "auf abruf maximal dreimal in der woche" ///
			 "*hause und*arbeit*" 	///
			 "je nachdem*" 				///
			 "14-tage schicht" ///
			 "*arbeitsort oder zu hause*" {
	strrec q12other ("`x'" = "4"), sub replace string
}



* Fälle richtig zuordnen
foreach num of numlist 0/4 {
	replace q12office = `num' if q12other == "`num'"
}


*Unsinnige Eingaben in Missings
replace q12office = . if q12other == "-klosett69ttesrok-"
replace q12other = "" if q12other == "-klosett69ttesrok-"

*Rekodierung zu arbeitet zZt nicht und krankgeschrieben (q10, q11, q12 missing)
replace q10currenttime = 4 if strmatch(q12other, "*krankgeschrieben*")
replace q11reason = 5 if strmatch(q12other, "*krankgeschrieben*")
replace q12office = .b if strmatch(q12other, "*krankgeschrieben*")
replace q12other = "" if strmatch(q12other, "*krankgeschrieben*")

replace q10currenttime = 4 if strmatch(q12other, "garnicht wegen corona")
replace q11reason = 3 if strmatch(q12other, "garnicht wegen corona")
replace q12office = .b if strmatch(q12other, "garnicht wegen corona")
replace q12other = "" if strmatch(q12other, "garnicht wegen corona")

replace q10currenttime = 4 if strmatch(q12other, "die firma hat 4 wochen zugemacht*")
replace q11reason = 3 if strmatch(q12other, "die firma hat 4 wochen zugemacht*")
replace q12office = .b if strmatch(q12other, "die firma hat 4 wochen zugemacht*")
replace q12other = "" if strmatch(q12other, "die firma hat 4 wochen zugemacht*")

foreach x in "*Überstunden*"	"*urlaub*"			 ///
			 {
	replace q10currenttime = 4 if strmatch(q12other, "`x'")
	replace q11reason = 1 if strmatch(q12other, "`x'")
	replace q12office = .b if strmatch(q12other, "`x'")
	replace q12other = "" if strmatch(q12other, "`x'")
	}

*	zum Überprüfen der Recodierung
list q12other if !inlist(q12other, "0", "1", "2", "3", "4", "")	
	
*Hilfsvariable löschen
drop q12other 


exit
