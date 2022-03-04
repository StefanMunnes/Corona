/* Kodierung der offenen Antworten Frage
	q32officeparother: Von wo aus arbeitet ihr Partner im Moment?

in 4 Kategorien:
	0. Sonstiges (neu)
	1. Weiterhin (überwiegend) am Arbeitsort
	2. Aufgrund der Corona Pandemie (überwiegend) von zu Hause aus
	3. Wie immer von zu Hause aus
	4. Gar nicht
	5. Etwa gleich oft am Arbeitsort und zu Hause (neu)
*/


* Hilfsvariable erstellen
cap drop q32other
gen q32other = strlower(q32officeparother)

/*falsch zugeordnete Fälle:
aktuelle Zuordnung - q32other - SOLL
1 - kurzarbeit. Aber arbeitet wenn telefonisch mal von zuhause - 

*/

* Offene Eingaben mit problematischer Zuordnung:
strrec q32other ("kurzarbeit 0, d.h.*" = "4"), sub replace string
strrec q32other ("*eine woche arbeit am arbeitsplatz, eine woche bereit*" = "5"), sub replace string
strrec q32other ("hat garnicht gearbeitet*" = "4"), sub replace string


*0. Sonstiges
*Lernen für die Prüfung = Eine im Gesundheitssystem durch die aktuelle Situation weniger Stunden arbeitende Person.
foreach x in "*ausbildung*nicht möglich*" ///
			  {
	strrec q32other ("`x'" = "0"), sub replace string
}

* 1. Weiterhin(überwiegend) am Arbeitsort
// draußen = Baustelle
foreach x in "30 % zu hause" 			///
			 "30/70*büro"				///
			 "*bei den bienen*" 		///
			 "räume des ag*" "*büro*alleine*" ///
			 "*verschiedenen ort*"		///
			 "ausgelagertes büro*" 		///
			 "*am arbeitsort, nachts*"	///
			 "eigenes büro*"			///
			 "*montage*"				///
			 "andere einsatzort*"		///
			 "*ausschließlich am arbeitsort*"	///
			 "*lieferservice*"			///
			 "aufsuchend" 				///
			 "*draußen*"				///
			 "paketbote*"				///
			 "von unterwegs"			///
			 "*notbetreuu*"				///
			 "weniger"					///
			 "*wieder am arbeitsort*"	///
			 "*arbeitet wieder*am arbeitsort*"	///
			 "*schichten am arbeitsort*"	///
			 "arbeitsort"				///
			 "im privaten büro"			///
			 "anderes büro"				///
			 "atelier"					///
			 "*kurzarbeit*" 			///
			 "*seit heute wieder*"		///
			 "*bis gestern am arbeitsort*" ///
			 "*10% home office*"		///
			 "*verschiedene*arbeits*"	///
			 "*landwirt*"				///
			 "*mehr*arbeits*"			///
			 "*therpeut*"				///
			 "am arbeitsort*"			///
			 "arbeitet*in schichten*"	///
			 "auf der straße"			///
			 "*außendienst*"			///
			 "*im arbeitsort"			///
			 "*kundendienst, immer*"	///
			 "*nur 1 an 2 tagen*"		///
			 "*deutschlandweit*"		///
			 "*gerade wieder an zu arb*"	///
			 "arbeitet*sehr wenig*"		///
			 "*ngeschränkt am arbeitsort*"	///
			 "*ständig unterwegs*"		///
			 "geht*zum arbeiten*"		///
			 "*jetzt wieder*"			///
			 "*nicht von unserer woh*"	///
			 "*arbeitet 1-2 tage*"		///
			 "*nur an einzelnen tagen*"	///
			 "*binnenschiff*"			///
			 "*areitet*an einzelnen tagen*" ///
			 "*arbeitet in außenstelle*"	///
			 "*ort ist nicht fest*"		///
			 "*muss zurzeit weniger*"	///
			 "*aufgrund seiner arbeit*in*"	///
			 "*arbeitet und*nur am wochenende zu hause*"	///
			 "*auch vom arbeitsplatz*" 	///
			 "*systemrelevant*"			///
			 "*seit gestern wieder*"	///
			 "*arbeitet diesen monat nur einen tag*" ///
			 "*arbeitet aber weiter angestellt*" ///
			 "*arbeitet*noch*"			///
			 "*selbstständig kameramann*"	///
			 "*muss nun aber wieder*"	///
			 "arbeitet weniger"			///
			 "*3 tage im büro*"			///
			 "arbeitet zu zeit weniger"	///
			 "*zunehmend wieder*arbeitsplatz*"	///
			 "*minijob im einzelhandel*"	///
			 "*wieder normal am arbeitsort*"	///
			 "*aufträge*in beschränktem maße*"	///
			 "*und arbeitet am arbeitsort*"	///
			 "*weniger, ?berstundenabbau*" ///
			 "jeweils vor ort"{
	strrec q32other ("`x'" = "1"), sub replace string
}

* 2. Aufgrund der Corona Pandemie überwiegend zuhause
foreach x in "100% mobile*"  			///
			 "*ausschließlich*zu hause*" ///
			 "*ereitschaft*" 			///
			 "lehrerin"					///
			 "*aktuell*homeoffice*" 	///
			 "*aufgrund*corona*" 		///
			 "nur zu hause*"			///
			 "arbeitet nur zu hause*"	///
			 "wohnung elternteil*" 		///
			 "*aufgrund*pandemie*homeoffice*"	///
			 "*arbeitet als lehrerin*"	///
			 "*2x pro woche vor ort*"	///
			 "*überwiegend zuhause*" 	///
			 "*überwiegend zu hause*" 	///
			 "selbstständig"			///
			 "ist selbstständig"		///
			 "*nur noch zu?hause*" 		///
			 "*vorwiegend zuhause*" 	///
			 "von zu hause" 			///
			 "*nur*zuhause*"			///
			 "z.t. home-office*" 		///
			 "*nicht mehr*kunden*"		///
			 "*von der wohnung*" 		///
			 "*ausschließlich*zuhause*" ///
			 "ist im home office*"		///
			 "home?office statt*" 		///
			 "*ab*homeoffice*" 			///
			 "*wenn*dann von*hause*"	///
			 "*zweitwohnsitz*" 			///
			 "home?office" "homeoffice" ///
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
			 "*eingeschränkt von zu*"	///
			 "*haus der eltern*" 		///
			 "in der wohnung meiner*" 	///
			 "*komplett von zu hause*" 	///
			 "*elternhaus*" "datsche*" 	///
			 "von zu hause (*" 			///
			 "zu hause" 				///
			 "zuhause" 					///
			 "einen tag in der beratungsstelle*" ///
			 "selbstständige tätigkeit von zu hause*" ///
			 "noch zu hause*" 			///
			 "büro des partners"		///
			 "exklusiv*homeoffice*"		///
			 "*lernen*prüfung*"			///
			 "*seit*im homeoffice*"		///
			 "*seit*im home office*"	///
			 "*ohne*externe Termine*"	///
			 "*unterricht*video*"		///
			 "*zweitwohnung*"			///
			 "*reduziertem umfang*hause*" ///
			 "*studio gek?ndigt*"		///
			 "*drei tage auf der*"		///
			 "*zurzeit von zu hause*"	///
			 "*zustellerin*"			///
			 "anstatt am arbeitsort bei meinen eltern*" ///
			 "*fast ganz von*"			/// 
			 "*zur zeit*nur von zu hause*"	///
			 "*arbeitet nur von zu hause*"	///
			 "*nur zu hause*"	///
			 "*online schule bei bekannten*"	///
			 {
	strrec q32other ("`x'" = "2"), sub replace string
}

* 3. Wie immer von zu Hause
foreach x in "*aufgrund*semesterferien*" ///
			 "weiterhin überwiegend von zuhause*" ///
			 "büro im haus" 			///
			 "*privates büro*" 			///
			 "*immer von zuhause*"		///
			 "*selbstständig*"			///
			 "forschungsfreisemester"	///
			 "selbständig"				///
			 "ist selbständig"			///
			 "*hause wie immer*"		///
			 "*in seinem studio*"		///
			 "*unabhängig von corona überwiegend von zu hause*"	///
			 "*studio in unserem haus*"	///
			 "*in meiner firma*"		///
			 "*nur von zu hause"		///
			 "*nur zu hause"			///
			 "*wie ueblich meistens zu hause*" {
	strrec q32other ("`x'" = "3"), sub replace string
}

*4. Partner/in arbeitet zurzeit nicht
foreach x in "*krank*" 				///
			 "garnicht wegen corona" ///
			 "*freistellung*"		///
			 "keine engagements"		///
			 "*durfte sie bis heute*eigenen kinder*"	///
			 "berufsverbot*"		///
			 "*betrieb*geschloss*"	///
			 "*probt noch*"			///
			 "*keine aufträge*"		///
			 "wegen corona verdachts befreit"	///
			 "*studium*"			///
			 "*alle aufträge*zurück gezogen*"	///
			 "*arbeitsverbot*"		///
			 "hh-modell, ausgesetzt"	///
			 "*kann nicht arbeiten*"	///
			 "*online schule*"		///
			 "*bisher frei*"		///
			 "*wegen op zu*"		///
			 "*feigestellt*"		///
			 "*zwei tagen online schule*" ///
			 "*minusstunden*"		///
			 "*proben ohne vergütung*" ///
			 "*gelegentlich linienverkehr*"	///
			 "kug mit nullstunden*"	///
			 "*Überstunden*"			///
			 "*urlaub*"			 		///
			 "die firma hat 4 wochen zugemacht*" ///
			 "*freigestellt*"  {
	strrec q32other ("`x'" = "4"), sub replace string
}


*5. Halb/Halb
foreach x in "*woche büro*" 			///
			 "*woche zuhause*" 			///
			 "zwei wochen*"				///
			 "*eine woche*" 			///
			 "*wochenweise*" 			///
			 "*chentlich wechsel*"		///
			 "*teils*" 					///
			 "*homeoffice und am arbeitsort*"	///
			 "*50*" 					///
			 "*im büro*"				///
			 "*halbe*" 					///
			 "*wechsel*" 				///
			 "2 tage vor ort 2 tage zu hause" ///
			 "*gleichmäßig verteilt*" 	///
			 "*hälftig*" 				///
			 "*gleich viel am*"			///
			 "*arbeitsort und home office*" ///
			 "*teil*" 					///
			 "*gemischt*" 				///
			 "*hälfte*" 				///
			 "*halb*" 					///
			 "2 bis 3 tage von zu hause" ///
			 "büro und homeoffice*" 	///
			 "arbeitsort und von zu hause" ///
			 "2 tage vor ort 2 tage zu hause*" ///
			 "von zu hause und*" 		///
			 "auf abruf maximal dreimal in der woche" ///
			 "*2-3 tagen in der schule*"	///
			 "*hause und*arbeit*" 	///
			 "*wechselnden arbeitsorten*" ///
			 "*1/2 arbeitso*" ///
			 "*1/2 zuhause*" ///
			 "*mischung*"				///
			 "*gesplittet*"				///
			 "*sowohl von*" 			///
			 "*sowohl zu hause als auch*"	///
			 "*14-tage schicht*" ///
			 "*und zu hause*" ///
			 "je nachdem*" 				///
			 "*arbeitsort oder zu hause*" {
	strrec q32other ("`x'" = "5"), sub replace string
}

*Fälle richtig zuordnen
foreach num of numlist 1/5 {
	replace q32officepar = `num' if q32other == "`num'"
}

*	Rekodierung von Personen die zZt nicht arbeiten:
* Rente, Elternzeit
foreach x in "*rent*" "*pension*" "*mutterschutz*"	"*elternzeit*"	"*sabbat*"			///
	{
	replace q32officepar = .b if strmatch(q32other, "`x'")
	replace q32other 	= "" if strmatch(q32other, "`x'")
	replace q30empstspar= 0	 if strmatch(q32other, "`x'")
	}

*zum Überprüfen der Recodierung
list q32other if !inlist(q32other, "0", "1", "2", "3", "4", "5", "")


*Hilfsvariable löschen
drop q32other 


exit
