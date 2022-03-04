/* Kodierung der offenen Antworten Frage
	q12status: Von wo aus arbeiten Sie im Moment?

in 4 Kategorien:
	0. Sonstiges
	1. Weiterhin (überwiegend) am Arbeitsort
	2. Aufgrund der Corona Pandemie (überwiegend) von zu Hause aus
	3. Wie immer von zu Hause aus
	4. Etwa gleich oft am Arbeitsort und zu Hause
*/

* Hilfsvariable erstellen
cap drop q12other
gen q12other = strlower(q12officeother)

* Offene Eingaben mit problematischer Zuordnung:
strrec q12other ("ab 11.5. wieder am arbeitsort" = "2"), sub replace string
strrec q12other ("wie immer überwiegend von zu hause*" = "3"), sub replace string

*0. Sonstiges
*Lernen für die Prüfung = Eine im Gesundheitssystem durch die aktuelle Situation weniger Stunden arbeitende Person.
foreach x in "*befindet sich*in der klärung*" "viel freiland" {
	strrec q12other ("`x'" = "0"), sub replace string
}

*Rekodierung zu arbeitet zZt nicht und krankgeschrieben (q10, q11, q12 missing)
foreach x in "*krankgeschriebe*" "*armbruch*" ///
			 {
	replace q10currenttime = 4 if strmatch(q12other, "`x'")
	replace q11reason = 5 if strmatch(q12other, "`x'")
	replace q12office = .b if strmatch(q12other, "`x'")
	replace q12other = "" if strmatch(q12other, "`x'")
}

foreach x in "*Überstunden*"	"*urlaub*"			 ///
			 {
	replace q10currenttime = 4 if strmatch(q12other, "`x'")
	replace q11reason = 1 if strmatch(q12other, "`x'")
	replace q12office = .b if strmatch(q12other, "`x'")
	replace q12other = "" if strmatch(q12other, "`x'")
}

foreach x in "*garnicht wegen corona*" "*freistellung bei*" "die firma hat 4 wochen zugemacht*"	"garnicht" ///
			 {
	replace q10currenttime = 4 if strmatch(q12other, "`x'")
	replace q11reason = 3 if strmatch(q12other, "`x'")
	replace q12office = .b if strmatch(q12other, "`x'")
	replace q12other = "" if strmatch(q12other, "`x'")
}



* 1. Weiterhin(überwiegend) am Arbeitsort
// draußen = Baustelle
foreach x in "30 % zu hause" 			///
			 "*75 % arbeitsort*"		///
			 "am arbeitsort"			///
			 "*3 tage am arbeitsort*"   ///
			 "aufsuchend*"				///
			 "aussendienst"				///
			 "außer haus*"				///
			 "im notfallcenter"			///
			 "*sitz der firma*"			///
			 "*keine dienstreisen mehr*"	///
			 "bei kunden vor ort*"		///
			 "*bei den bienen*" 		///
			 "räume des ag*" ///
			 "*büro*alleine*" ///
			 "ausgelagertes büro*" 		///
			 "*am arbeitsort, nachts*"	///
			 "eigenes büro*"			///
			 "*montage*"				///
			 "kinderheim"				///
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
			 "büro des partners"		///
			 "*standort*"				///
			 "*10% home office*"		///
			 "*hausbesuche*"			///
			 "*eigener praxis*"			///
			 "*zweigstelle*firma*"		///
			 "*im krankenhaus*"			///
			 "*im food truck*"			///
			 "*senioremheim*"			///
			 "*1/3 homeoffice*"			///
			 "immer*am arbeitsort*"		///
			 "*jetzt am arbeitsort*"	///
			 "*jetzt vor ort*"			///
			 "*wieder*am arbeitsort*"	///
			 "*wieder*am arbeitsplatz*"	///
			 "*wieder*nur arbeitsort*"	///
			 "*privat angemieteter büro*"	///
			 "*drei tage büro*"			///
			 "*ständig am arbeitsplatz*"	///
			 "*separaten einzelbüro*"	///
			 "*überwiegend am arbeitsort*"	///
			 "*wieder in der schule*"	///
			 "mehr am arbeitsort als*"	///
			 "jeweils vor ort"	{
	strrec q12other ("`x'" = "1"), sub replace string
}

* 2. Aufgrund der Corona Pandemie überwiegend zuhause
foreach x in "100% mobile*"  			///
			 "*100%*zu*hause*"			///
			 "*100 %*zu*hause*"			///
			 "*80% zuhause*"			///
			 "mobiles arbeiten und klien*"	///
			 "komplett zuhause*"		///
			 "*immer von zu hause*"		///
			 "*immer von zuhause*"		///
			 "*ausschließlich*zu hause*" ///
			 "*aktuell*homeoffice*" 	///
			 "*aufgrund*corona*" 		///
			 "wohnung elternteil*" 		///
			 "*?berwiegend zuhause*" 	///
			 "*?berwiegend von zu hause*"	///
			 "*?berwiegend zu hause*"	///
			 "*nur noch zu?hause*" 		///
			 "*vorwiegend zuhause*" 	///
			 "von zu hause" 			///
			 "zu hause.*"				///
			 "*häufiger von zu hause*"	///
			 "*nur*zuhause*"			///
			 "*nur*zu hause*"			///
			 "nur homeoffice"			///
			 "z.t. home-office*" 		///
			 "*von der wohnung*" 		///
			 "*ausschließlich*zuhause*" ///
			 "*hause*jetzt ausschließlich*"	///
			 "home?office statt*" 		///
			 "*ab*homeoffice*" 			///
			 "*zweitwohnsitz*" 			///
			 "home?office" "homeoffice" ///
			 "*home-office*ganze firma*" ///
			 "*arbeite im homeoffice*"	///
			 "komplett von zu hause"	///
			 "familienhaus im ausland"  ///
			 "*eltern aufs land*"		///
			 "*bei*partner*" 			///
			 "zuhause und in einem gemieteten büro in einem kreativhaus" ///
			 "*wochenendhaus*" 			///
			 "online unterricht"		///
			 "*jetzt neu*" 				///
			 "*auf dem land*"			///
			 "zunächst von zu hause aus" ///
			 "*bei der mutter im haus*" ///
			 "*haus der eltern*" 		///
			 "in der wohnung meiner*" 	///
			 "*komplett von zu hause*" 	///
			 "*elternhaus*" ///
			 "datsche*" 	///
			 "von zu hause (*" 			///
			 "zu hause" 				///
			 "zuhause" 					///
			 "einen tag in der beratungsstelle*" ///
			 "4 von 5 tagen im homeoffice"	///
			 "4 von 5 zu hause"			///
			 "selbstständige tätigkeit von zu hause*" ///
			 "noch zu hause*" 			///
			 "exklusiv*homeoffice*"		///
			 "*lernen*prüfung*"			///
			 "*seit*im homeoffice*"		///
			 "*seit*im home office*"	///
			 "*ohne*externe Termine*"	///
			 "*3/4 zu hause"			///
			 "*2/3 zuhause"				///
			 "*1-2 tage am arbeitsort*"	///
			 "*zu hause bei*"			///
			 "*keine aussendiensttermine*" ///
			 "*keine veranstaltungen*"	///
			 "*im ferienhaus*"			///
			 "*jetzt 100% home*"		///
			 "*haus meiner eltern*"		///
			 "*angemietete ferienwonung*"	///
			 "ich habe vorher schon viel*"	///
			 "nur 2 tage im kindergarten"	///
			 "anstatt am arbeitsort bei meinen eltern*" {
	strrec q12other ("`x'" = "2"), sub replace string
}

* 3. Wie immer von zu Hause
foreach x in "*aufgrund*semesterferien*" ///
			 "weiterhin überwiegend von zuhause*" ///
			 "büro im haus" 			///
			 "*privates büro*" 			///
			 "*privates zimmer*"		///
			 "büro am wohnort*"			///
			 "*wie ueblich meistens zu hause*" {
	strrec q12other ("`x'" = "3"), sub replace string
}

*4. Halb/Halb
foreach x in "*woche büro*" 			///
			 "*woche zuhause*" 			///
			 "*eine woche*" 			///
			 "*wochenweise*" 			///
			 "*teils*" 					///
			 "*50*" 					///
			 "2 tage zu hause 2*"		///
			 "*im büro*"				///
			 "*halbe*" 					///
			 "*wechsel*" 				///
			 "2 tage vor ort 2 tage zu hause" ///
			 "*gleichmäßig verteilt*" 	///
			 "*hälftig*" 				///
			 "*arbeitsort und home office*" ///
			 "*teil*" 					///
			 "*gemischt*" 				///
			 "*hälfte*" 				///
			 "*halb*" 					///
			 "büro und homeoffice*" 	///
			 "arbeitsort und von zu hause" ///
			 "*und ambulant*"			///
			 "2 tage vor ort 2 tage zu hause*" ///
			 "von zu hause und*" 		///
			 "auf abruf maximal dreimal in der woche" ///
			 "*hause und*arbeit*" 	///
			 "*wechselnden arbeitsorten*" ///
			 "2 bis 3 tage von zu hause" ///
			 "*arbeitsort oder zu hause*" ///
			 "je nachdem*" 				///
			 "*14-tage schicht*"{
	strrec q12other ("`x'" = "4"), sub replace string
}

* Fälle richtig zuordnen
foreach num of numlist 1/5 {
	replace q12office = `num' if q12other == "`num'"
}

*Unsinnige Eingaben in Missings
replace q12office = . if q12other == "-klosett69ttesrok-"



*	zum Überprüfen der Recodierung
list q12other if !inlist(q12other, "0", "1", "2", "3", "4", "")

*Hilfsvariable löschen
drop q12other 

exit
