/* Kodierung der offenen Antworten Frage
	q17childcare*: Kinderbetreuung

	1	Ich betreue sie zu Hause, ohne zu arbeiten
	2	Ich betreue sie, während ich von zu Hause aus arbeite
	3	Tagsüber, arbeiten wenn sie schlafen
	4	Mein/e Partner/in betreut sie
	5	Die Kinder besuchen eine Notfallbetreuung
	6	Die Großeltern übernehmen die Kinderbetreuung
	7	Andere Babysitter_innen, Verwandte, Freunde oder Nachbarn betreuen die Kinder
	8	Wir haben ein Tauschmodell mit anderen Eltern
	9	Die Kinder sind alleine zu Hause/Keine Kinderbetreuung nötig

*/


*Erstellung Hilfsvariable
capture drop q17other test*
gen q17other = strlower(q17childcareother)
foreach num of numlist 1/9 {
	gen test`num' = .
}

*Besondere Fälle/Fälle die die Mustererkennung zu sehr erschweren:
replace q17other = "" if id == 8807 //Allgemeiner Kommentar, keine Antwort auf die Frage
replace q17other = "patchworkfamilie" if strmatch(q17other, "patchworkfamilie mit wechselmodell*")
replace q17other = "mit partner" if strmatch(q17other, "tauschmodell mit partner")
replace q17other = "kinder sind alt genug" if strmatch(q17other, "kinder sind alt genug ohne betreuung aber wir arbeiten beide zuhause gerade")
replace q17other = "ich betreue alleine" if strmatch(q17other, "* da mein mann  lehrer ist und seit dem 27.4.*")
strrec q17other ("mein partner ist in elternzeit*" = "partner betreut"), sub replace string
strrec q17other ("mein mann arbeitet" = ""), sub replace string
strrec q17other ("elternzeit" = ""), sub replace string

*q17childcare1 Ich betreue sie zu Hause, ohne zu arbeiten
foreach x in "*lternzeit*" "*einer betreut die kinder*" "*betreuung gemeinsam mit*" ///
			"*mein mann*und ich*"	///
			 "betreue die kinder vormittags, arbeite danach bis in den abend" ///
			 "*betreue*zuhause*ohne zu arbeiten*" "*mutterschutz*" ///
			 "*betreue*zu hause*ohne zu arbeiten*" "*ich betreue*" ///
			 "hälfte arbeit, hälfte kinderbetreuung" "mein sohn und ich sind zu hause*" ///
			 "großeltern, ich und bruder" "*partner*und ich*" ///
			 "*betreuung miteinander*" "*bin fast immer zuhause*" ///
			 "es gibt keine feste struktur*" "*versetzt*" ///
			 "*während mein*arbeitet*" "*an *freien tagen*" ///
			 "*einer bunten patchwork familie*" ///
			 "*50*" "*abwechselnd*" "*wechsel*" "*mein mann und ich*" ///
			 "*geteilte betr*" "*arbeite am wochenende*" ///
			 "*halb ich*" "*ich betreue sie*maßnahme*" ///
			 "*1 woche frei*" "*betreuung zuhause*" ///
			 "jetzt quarantäne" "*mein partner und ich*" "*teilen uns*" ///
			 "*schicht*" "*tauschmodel*" "*echslel*" "*teile*betreuung*" ///
			 "*beide partner*" "*wir teilen*" "*ich betreue zu hause*krank*" ///
			 "*rotierende betreuung*" "*ich betreue vormittags*" ///
			 "getrennt lebender vater betreut auch*" ///
			 "anderer elternteil betreut auch*" "*wir als eltern*" ///
			 "teils ist mein sohn bei papa*" "*wir tauschen*" ///
			 "*ich betreue*bachelorarbeit*" "*arbeitszeit*verschoben*" ///
			 "tel/ teil.*"  "*betreue sie zu hause*" ///
			 "*mein partner betreut vormittags währ*" ///
			 "*urlaub genommen*" "*danach tauschen wir*" ///
			 "*homeschooling*bei mir*" "*halbtags ich*" ///
			 "*mutter übernimmt ebenfalls*" "ich mache minusstunden*" ///
			 "gemeinsam mit meinem mann*" "*mein partner*und umgekehrt*" ///
			 "*ich bin an drei vormittagen im büro*" ///
			 "*patchworkfamilie*" "*morgens homeschooling*"	///
			 "*mit partner*" "*bleibe ich zu hause*"	///
			 "ex  betreut sie zu gleichen teilen*" ///
			 "*hauptsächlich von mir*" "*während der andere*"	///
			 "*arbeite am wochenende oder nachtdienst*" ///
			 "*betreue mit*zu hause*"	"*woche nehme ich*" ///
			 "*mal alleine*" "*momentan betreute ich*"	///
			 "*nachmittags tauschen wir*" "*vormittags übernehme ich*"	///
			 "*wenn mein partner*arbeit*" "*vor der arbeit*" ///
			 "*ich betreue sie zuhause und gehe noch zur arbeit*"	///
			 "*jetzt quarantäne*" "ich betreue alleine" ///
			 "*schmerzmittel*schwangerschaft*" "*arbeite vorwiegend*kita*" ///
			 "*ich arbeite kaum*" "*ich*den halben tag*"	///
			 "*wenn ich arbeite*" "*betreue ich unser kind minus*"	///
			 "*wenn ich aushäusig arbeiten*" "*betreuung tagsüber*schlafenszeit*"	///
			 "*von allem etwas*" "*geteilt*" "*teile*"  {
	replace test1 = 1 if strmatch(q17other, "`x'") & (q17childcare1 == . & q17childcare2 != 1)
}


*q17childcare2 Ich betreue sie, während ich von zu Hause aus arbeite
*inkl. wenn kinder mit zur arbeit genommen werden
foreach x in "elternzeit in ?eilzeit" "*eilzeit in ?lternzeit" ///
			 "*inklusive homeoffice*" "*am arbeitsplatz*" ///
			 "*mit ins büro*" "*mit auf arbeit*" "*mit zur arbeit*" ///
			 "*mit*im büro*" "*während wir*arbeiten*" "*wähnred wir*arbeiten*" ///
			 "beide betreuen da home office*" "*abwechselnd homeoffice*" ///
			 "*jederzeit*erreichbar*" "*oder wir arbeiten beide*" ///
			 "*teilen uns die betreuung, beide arbeiten von zu hause*" ///
			 "beide im homeoffice*betreuung gemeinsam*" "*werden festgebunden*" ///
			 "*und arbeiten wenn kinder da sind*" "*in kurzarbeit zu hause*" ///
			 "wir betreuen abwechselnd und arbeiten beide*"  ///
			 "*an tagen von homeoffice betreue ich*" "*home office*parallel*" ///
			 "ein kombination  aus den antworten 2/3 /4 und 9"	///
			 "*während*aufträge abarbeite*" "*auf der arbeit*" ///
			 "*während arbeit*" "*homeoffice + homeschooling*" ///
			 "*von allem etwas*" "*nehme sie zur arbeit*" {
	replace test2 = 1 if strmatch(q17other, "`x'")
}


*q17childcare3 Tagsüber, arbeiten wenn sie schlafen
foreach x in "*danach bis in den abend*" "*mittagsschlaf und abends*" ///
			 "*während*schlafen" "*nachtdienst*" ///
			 "ein kombination  aus den antworten 2/3 /4 und 9"	///
			 "*späten nachmittag*" "*teils abend*" ///
			 "*von allem etwas*" ///
			 "*betreuung tagsüber*schlafenszeit*" {
	replace test3 = 1 if strmatch(q17other, "`x'")
}


*q17childcare4 Mein/e Partner/in betreut sie
*"*patchworkfamilie*" wird zzt bei q17childcare7 wieder rauscodiert.
*"tauschmodell mit partner" verkompliziert q17childcare8
foreach x in "*wechsel*" "*patchworkfamilie*"  "*einer betreut die kinder*" ///
			 "*beide betreu*" "*betreuen beide*" "*mutter des kind*" ///
			 "*partner betreut*" "*partner  betreut*" "*beide*" ///
			 "*schicht*partner*" "*partner*schicht*" "*mein parrtner arb*" ///
			 "*partmer*" "*nachmittags*meine partnerin*"	///
			 "*mein mann*" "*partner*und ich*" "*frau und ich*" ///
			 "*entgegengeset*arbeiten*" "*partner*betreut*" ///
			 "*teile*betreu*" "*wir betreuen*" ///
			 "*wir teilen*" "*gemeinsam*" "*wir als eltern*" ///
			 "*wir*betreuen*" "*schicht*betreu*" ///
			 "*geteilte betreuung*" "*passt*partner*auf*" ///
			 "*schicht*einer*" "*mich mit mein*ab*" "*betreu*papa*" ///
			 "*arbeite*versetzt*" "*partner aktuell krank*" ///
			 "partner homeoffice" "tel/ teil.*" "tauschmodell mit*partner*" ///
			 "*mit partner*" "*wenn mein partner*arbeit*"  ///
			 "*wenn meine fr?u nicht kann*"	"*betreue mit, wenn*"	///
			 "*halb mann*" "*von meinem*" "*partner zu hause*" ///
			 "ein kombination  aus den antworten 2/3 /4 und 9"	///
			 "*übernimmt mein partner*"	"*papa zu hause*" ///
			 "*versetzte arbeit*" "*partner*nach*arbeit*" ///
			 "*ehemann im homeoffice*" "*partner im homeoffice*" ///
			 "*partner*von zu hause*" "*während der andere*" ///
			 "*gehen geteilt arbeiten*" "partner" ///
			 "*wir wegsel uns ab*"	///
			 "*teilen die zeit*" "*halbtags mutter*" ///
			 "*teilen uns den tag mit meinem mann*"	///
			 "* und umgekehrt*" "*gehen versetzt zur arbeit*"	///
			 "*schichtarbeit*familie*" "*teile*partner rein*"	///
			 "*betreuung tagsüber*schlafenszeit*"	///
			 "*und meine frau*" "*von allem etwas*" {
	replace test4 = 1 if strmatch(q17other, "`x'")
}


*q17childcare5 Die Kinder besuchen eine Notfallbetreuung
foreach x in "*familienentlast*" "*kita*" "*tagesmutter*" "*notdienst*" ///
			 "*notbet*" "*klinik*" "*pflegeteam*" "*kindergarten*" {
	replace test5 = 1 if strmatch(q17other, "`x'")
}


*q17childcare6 Die Großeltern übernehmen die Kinderbetreuung
foreach x in "*großeltern*" "*opa*" "*oma*" "*von allem etwas*" {
	replace test6 = 1 if strmatch(q17other, "`x'")
}


*q17childcare7 Andere Babysitter_innen, Verwandte, Freunde oder Nachbarn betreuen die Kinder
*Erster Block: Ex-Partner, werden bei childcare4 wieder rauscodiert
*Zweiter Block: Babysitter, Freunde und co
foreach x in "*wechselmodell*" "*getrennt lebenden partner*" ///
			 "*ex?partner*" "*exfrau*" "ex*" "*arbeite vorwiegend*kita*" ///
			 "*kinder sind etwa die hälfte*" "*in ihrem haushalt*" ///
			 "*vater*" "papa" "*teils ist mein sohn bei papa*" ///
			 "*andere*elternteil*" "*kindesmutter*" "*kindsmutt*" {
	replace test7 = 1 if strmatch(q17other, "`x'")
	replace test4 = . if strmatch(q17other, "`x'")
}

foreach x in "*kinderfrau*" "*nanny*" "*betreuungskraft*" "*babysitt*" ///
			 "*bezahlt*betreuung*" "*bruder*" "*schwester*" "*haushalt*hilfe*" ///
			 "patchworkfamilie" "kindersitt*" "*betreuungsperson*" ///
			 "*dienstleister*"	"*au?pair*" "*aupair*" "feste angestellte" ///
			 "*schule und hort*" "*von allem etwas*" "*wohnprojekt*" ///
			 "geschwister" "*älteren passen auf*kleine*auf*" "*tochter betreut*"	///
			 "*passt der große auf*" 			 {
	replace test7 = 1 if strmatch(q17other, "`x'")
}


*q17childcare8 Wir haben ein Tauschmodell mit anderen Eltern
foreach x in "*wir teilen uns das haus mit*auch die kinderbetreuung*" ///
			 "*rotierende betreuung*" "*von allem etwas*"  {
	replace test8 = 1 if strmatch(q17other, "`x'")
}


*q17childcare9 Die Kinder sind alleine zu Hause/Keine Kinderbetreuung nötig
foreach x in "*sind die kinder*allein*" "*alleine zu hause*" ///
			 "*allein zu hause*" "*der große betreut die kleine*"	///
			 "ein kombination  aus den antworten 2/3 /4 und 9" ///
			 "*genug*" "*benötigen*" "*notwendig*" ///
			 "*betreut sich*" "*sich selb*" ///
			 "*1? jahre*" "*ist 1?*" "*kaum noch betreuung*" ///
			 "*volljährig*" "*nicht mehr*betreut*" ///
			 "*nicht betreu*" "*keine betreuung*" ///
			 "*kaum betreu*" "*kind*selbst*ändig*" "*fsj*" ///
			 "*kind*eigenständig*" "*selbstbetreuung*" ///
			 "*kind ist*groß*" "*betreuung erforderlich*" ///
			 "*kind arbeitet*" "*mit 16*" "*sind so alt*" ///
			 "*netflix*" "*benötigt keine betreung*" ///
			 "*erwachsene*" ///
			  "*nicht auf betreuung*angewiesen*" ///
			 "*von allem etwas*"  "*teilweise alleine*" {
	replace test9 = 1 if strmatch(q17other, "`x'")
}

* Kein Elternteil des Kindes
foreach x in "*unser enkel*" "*meine enkelin*"	"*unser enkel*" ///
			 "*mitbewohner, deren kind es ist*" "*partner ist der opa*" {
		foreach y in 1 2 3 4 5 6 7 8 9 {
			replace q17childcare`y' = .b if strmatch(q17other, "`x'")
			replace test`y' = . if strmatch(q17other, "`x'")
		}

		replace q15achildren = 0 if strmatch(q17other, "`x'")
		replace q15bchildren = .b if strmatch(q17other, "`x'")
		recode q16byrchild* (min/max = .b) if strmatch(q17other, "`x'")
		replace q17childcaresub11 =.b if strmatch(q17other, "`x'")
		replace q17childcaresub12 =.b if strmatch(q17other, "`x'")
		replace q17childcaresub21 =.b if strmatch(q17other, "`x'")
		replace q17childcaresub22 =.b if strmatch(q17other, "`x'")
		replace q18divlab5     = .b if strmatch(q17other, "`x'")
		replace q19currentdiv5 = .b if strmatch(q17other, "`x'")
		replace q17other = "" if strmatch(q17other, "`x'")
}

* Keine Änderung Notwendig
foreach x in "per skype schule" "*hörbücher auf cd helfen stundenweise*" ///
			 "tag ist durchorganisiert"	///
			 {
	replace q17other = "" if strmatch(q17other, "`x'")
}


*	Fälle richtig zuordnen
forvalues num = 1/9 {
	replace q17childcare`num' = 1 if test`num' == 1
}

*Hilfsvariable löschen
drop q17other test*

exit
