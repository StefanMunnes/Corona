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

*Besondere Fälle/Fälle die die Mustererkennung erschweren:
replace q17other = "" if id == 8807 //Allgemeiner Kommentar, keine Antwort auf die Frage
replace q17other = "patchworkfamilie" if strmatch(q17other, "patchworkfamilie mit wechselmodell*")
replace q17other = "mit partner" if strmatch(q17other, "tauschmodell mit partner")
replace q17other = "mein partner betreut sie" if strmatch(q17other, "mein partner betreut sie, während er zu hause arbeite")
replace q17other = "ich und partner" if strmatch(q17other, "mein partner und ich betreuen die kinder gemeinsam und abwechselnd während der andere arbeitet")
replace q17other = "kinder sind alt genug" if strmatch(q17other, "kinder sind alt genug ohne betreuung aber wir arbeiten beide zuhause gerade")
strrec q17other ("meine frau ist noch in elternzeit" = "partner"), sub replace string
strrec q17other ("elternzeit*mutter" = "partner"), sub replace string
strrec q17other ("*heute noch zu hause*" = "betreuung von mir"), sub replace string
strrec q17other ("*4.5. notbetreuung für alleinerziehende*" = "betreuung von mir"), sub replace string
strrec q17other ("*während wir beide von zu hause aus arbeiten*" = "während arbeit + beide partner"), sub replace string
strrec q17other ("bei der arbeit dabei mit geteilter betreuung*" = "während arbeit + beide partner"), sub replace string
strrec q17other ("wir betreuen sie, während wir von zu hause aus arbeiten" = "während arbeit + beide partner"), sub replace string

*q17childcare1 Ich betreue sie zu Hause, ohne zu arbeiten
*& (q17childcare1 == . & q17childcare2 != 1) ist notwendig weil bei personen die 
*childcare2 angekreuzt und zusätzlich weitere angaben gemacht haben, oft 
*fälschlicherweise childcare1 zugeordnet wird
foreach x in "*lternzeit*" "*von uns zu hause*" ///
			 "betreue die kinder vormittags, arbeite danach bis in den abend" ///
			 "*betreue*zuhause*ohne zu arbeiten*"	///
			 "*betreue*zu hause*ohne zu arbeiten*"	///
			 "*tage betreue ich sie*" "*betreuen gemeinsam*" ///
			 "elternzeit in ?eilzeit" "*eilzeit in ?lternzeit" ///
			 "hälfte arbeit, hälfte kinderbetreuung" "mein sohn und ich sind zu hause*" ///
			 "großeltern, ich und bruder" "*ntgegengesetzt*ichtdienst" ///
			 "*betreuung miteinander*" "*ich arbeite*früh*" ///
			 "es gibt keine feste struktur*" "*versetzt*" ///
			 "*während mein*arbeitet*" "*an *freien tagen*" ///
			 "*einer bunten patchwork familie*" "jetzt quarantäne" ///
			 "*50*" "*abwechselnd*" "*wechsel*" "*mein mann und ich*" ///
			 "*geteilte betr*" "*teile mit partner*" "*wöchentl* wechsel*" ///
			 "*halb ich*" "*ich betreue sie*maßnahme*" ///
			 "*1 woche frei*" "*betreuung zuhause*" ///
			 "jetzt quarantäne" "*mein partner und ich*" "*teilen uns*" ///
			 "*schicht*" "*tauschmodel*" "*echslel*" "*teile*betreuung*" ///
			 "*wir teilen*" "*ich betreue zu hause*krank*" ///
			 "*rotierende betreuung*" "*ich betreue vormittags*" ///
			 "getrennt lebender vater betreut auch*" ///
			 "anderer elternteil betreut auch*" ///
			 "teils ist mein sohn bei papa*" "*betreuung durch mich*" ///
			 "*ich betreue*bachelorarbeit*" "*schlagen uns so durch*" ///
			 "tel/ teil.*"  "*betreue sie zu hause*" ///
			 "*mein partner betreut vormittags währ*" ///
			 "*jetzt quarantäne*" "*urlaub genommen*" ///
			 "*homeschooling*bei mir*" "*fahre dann erst auf arbeit*" ///
			 "*mutter übernimmt ebenfalls*" "*abneds*" ///
			 "ich betreue sie*arbeite sehr wenig"  ///
			 "*ich bin an drei vormittagen im büro*" "*als ich 16.30*" ///
			 "*patchworkfamilie*" "*morgens homeschooling*"	///
			 "*wir betreuen sie zu hause*"	///
			 "*mit partner*" "*bleibe ich zu hause*" "*partner*omeoffice wenn*"	///
			 "ex  betreut sie zu gleichen teilen*" "*eine woche bei mir*" ///
			 "*entweder ich arbeite und mein partner*" "*ich betreuen je halbtags*" 	///
			 "*der eine*der andere*" "*meine eltern und ich*"	///
			 "*nehme Urlaub*" "momentan betreue ich die kinder*"	///
			 "*hauptsächlich von mir*" "*während der andere*"	///
			 "*arbeite am wochenende oder nachtdienst*" "potierendes system*" ///
			 "*habe*arbeitszeit auf nachmittag verlegt*" "*daher der rest über*mich"	///
			 "*betreue mit*zu hause*"	"*woche nehme ich*" ///
			 "*mal alleine*" "*momentan betreute ich*"	"ich betreue*großeltern"	///
			 "*nachmittags tauschen wir*" "*vormittags übernehme ich*"	///
			 "*wenn mein partner*arbeit*" "*vor der arbeit*" ///
			 "einer arbeitet früh.*" "*konklomerat aus mehreren antworten*"	///
			 "ich arbeite so gut wie nicht*" "*eltern und ich*"	///
			 "mutter betreut*auch ich" ///
			 "ich und partner" "ich, partner u*" "*dann werden die kinder übergeben*"	///
			 "*von alle? etwas*" "*geteilt*" "*teile*" "*betreuung von mir*" ///
			 "*nachmittags bin ich zu hause*" "*beide betreuen*" 	///
			 "*meistens betreue und beschule ich*" "ich betreue*großeltern*"	///
			 "*1 schulkind zuhause, welches teilweise*"	///
			 "*hälfte der woche hier*" "*nach der arbeit holenuich das kind*"	///
			 "*mein partner*und ich betreuen das kind"	"*betreuung gemeinsam*"	///
			 "*homeschooling mache ich*" "ich wechsle mit*ab*" "betreuung von mir"	///
			 "*kinder gehen stundenweise*in die betreuung*"	///
			 "partnerin arbeitet 3h*" "*betreuen und arbeiten beide zuhause*"	///
			 "kombination aus betreuung durch partnee*"	"wir betreuen wechelseitig" ///
			 "*ich*wenn ich ich nicht arbeite*" "*habe am nachmittag die kinder*"	///
			 "*btreue halbtags ohne zu arbeiten*" "*betreuen zusammen zu hause*" {
	replace test1 = 1 if strmatch(q17other, "`x'") & (q17childcare1 == . & q17childcare2 != 1)
}

*q17childcare2 Ich betreue sie, während ich von zu Hause aus arbeite
foreach x in "elternzeit in ?eilzeit" "*eilzeit in ?lternzeit" ///
			 "*inklusive homeoffice*" "*am arbeitsplatz*" ///
			 "*mit ins büro*" "*mit auf arbeit*" "*mit zur arbeit*" ///
			 "*mit*im büro*" "*wähnred wir*arbeiten*" ///
			 "beide betreuen da home office*" "*abwechselnd homeoffice*" ///
			 "*jederzeit*erreichbar*" "*oder wir arbeiten beide*" ///
			 "*teilen uns die betreuung, beide arbeiten von zu hause*" ///
			 "beide im homeoffice*betreuung gemeinsam*" ///
			 "*übernehme ich während ich arbeite"	///
			 "*und arbeiten wenn kinder da sind*" "*in kurzarbeit zu hause*" ///
			 "wir betreuen abwechselnd und arbeiten beide*"  ///
			 "*an tagen von homeoffice betreue ich*" ///
			 "ein kombination  aus den antworten 2/3 /4 und 9"	///
			 "*während*aufträge abarbeite*" "ich betreue*während*lerne*" ///
			 "*während arbeit*" "*übernehme ich während ich arbeite*" ///
			 "*arbaarbeitsstätte*" "*bei der arbeit dabei*"	///
			 "*office*betreuen zugleich die kinder*" ///
			 "*wir betreuen in der heimarbeit*"	///
			 "*betreue sie parallel zu meiner arbeit*"	///
			 "*betreuen sie, während wir von zuhause*"	///
			 "*arbeiten beide zuhause und betreuen nebenher*"	///
			 "*zusammen während wir von zuhause aus arbeiten*"	///
			 "*betreue sie während ich arbeite*"	///
			 "*von allem etwas*" "*nehme*kind*mit*arbeit*" "von allen etwas" {
	replace test2 = 1 if strmatch(q17other, "`x'")
}

*q17childcare3 Tagsüber, arbeiten wenn sie schlafen
foreach x in "*danach bis in den abend*" "*mittagsschlaf und abends*" ///
			 "*während*schlafen" "*nachtdienst*" ///
			 "ein kombination  aus den antworten 2/3 /4 und 9"	///
			 "*späten nachmittag*" "*teils abend*" ///
			 "*durch partnee, abend- und nachtarbeit*"	///
			 "*kind schläft*"	///
			 "*abends arbeiten wir beide*"	///
			 "*von allem etwas*" "*abneds*" "von allen etwas" {
	replace test3 = 1 if strmatch(q17other, "`x'")
}

*q17childcare4 Mein/e Partner/in betreut sie
*"tauschmodell mit partner" verkompliziert q17childcare8
foreach x in "*wechsel*" "*patchworkfamilie*" "*von uns zu hause*"  ///
			 "*beide betreu*" "*betreuen beide*" "*mutter des kind*" ///
			 "*partner betreut*" "*partner  betreut*" "*beide*" ///
			 "*schicht*partner*" "*partner*schicht*" "*mein parrtner arb*" ///
			 "*partmer*" "*nachmittags*meine partnerin*"	///
			 "*mein mann*" "*mann und ich*" "*partner*und ich*" "*frau und ich*" ///
			 "*entgegengesetztes*" "*entgegengeset*arbeiten*" ///
			 "*beide partner*" "*teile*betreu*" "*wir betreuen*" ///
			 "*wir teilen*" "*gemeinsam*" "*wir als eltern*" ///
			 "*entweder ich arbeite und mein partner*" 	///
			 "*wir*betreuen*" "*schicht*betreu*" "*wechsel*ab*" ///
			 "*geteilte betreuung*" "*passt*partner*auf*" "partner während*" ///
			 "*betreuung ehefrau*"	"*bei meiner partnerin*" "*mit meiner frau*"	///
			 "*schicht*einer*" "*mich mit mein*ab*" "*betreu*papa*" ///
			 "*arbeite*versetzt*" "*partner aktuell krank*" ///
			 "partner homeoffice" "tel/ teil.*" "tauschmodell mit*partner*" ///
			 "*meine frau*wir uns organisieren können*" "*des partners*"	///
			 "*der eine*der andere*" "*partner*omeoffice wenn*"	///
			 "*mit partner*" "*wenn mein partner*arbeit*" "*als paar aufgeteilt*" ///
			 "*wenn meine fr?u nicht kann*"	"*betreue mit, wenn*"	///
			 "*halb mann*" "*von meinem*" "*partner zu hause*" ///
			 "ein kombination  aus den antworten 2/3 /4 und 9"	///
			 "*übernimmt mein partner*"	"*papa zu hause*" "lebensgemeinschaft" ///
			 "*versetzte arbeit*" "*partner*nach*arbeit*" ///
			 "babysitterin, partner*" "*partnerin betreut*" ///
			 "*mit meiner frau*" "*mit meinem mann*"	///
			 "*ehemann im homeoffice*" "*partner im homeoffice*" ///
			 "*partner*von zu hause*" "*während der andere*" ///
			 "*gehen geteilt arbeiten*" "teile*mit meinem partner*" ///
			 "*teilen die zeit*" "*und meiner frau*" "ich, partner u*" ///
			 "*durch partnee, abend- und nachtarbeit*" "*partner am nachm*"	///
			 "*und meine frau*" "*von papa*" "*von allem etwas*" 	///
			 "ich und partner" "*dann werden die kinder übergeben*"	///
			 "*ich zuerst*mann*" "partner" "*stundenweise bei der tagsmutter*" ///
			 "mutter betreut*auch ich" "*und wir schlagen uns so durch*"	///
			 "von allen etwas" {
	replace test4 = 1 if strmatch(q17other, "`x'")
}

*q17childcare5 Die Kinder besuchen eine Notfallbetreuung (mittlerweile auch wieder normale Betreuung)
foreach x in "*familienentlast*" "*kita*" "*tagesmutter*" "*notdienst*" ///
			 "*notbet*" "*klinik*" "*pflegeteam*" "*notschule*"	///
			 "*geht wieder*schule*" "*notfallbetreuung*" "wieder schule"	///
			 "*tagespflege*" "*stundenweise*in die betreuung*"	///
			 "*waldkindergarten*" "krippe*wieder geöffnet" "*tagesmama*"	///
			 "ein kind ist wieder in der schule" "not betreuung*"	{
	replace test5 = 1 if strmatch(q17other, "`x'")
}

*q17childcare6 Die Großeltern übernehmen die Kinderbetreuung
foreach x in "*großeltern*" "*opa*" "*oma*" "*von allem etwas*"	///
			 "gr0ßeltern*" "*meine eltern*" "von allen etwas" {
	replace test6 = 1 if strmatch(q17other, "`x'")
}

*q17childcare7 Andere Babysitter_innen, Verwandte, Freunde oder Nachbarn betreuen die Kinder
*Erster Block: Ex-Partner, werden bei childcare4 wieder rauscodiert
*Zweiter Block: Babysitter, Freunde und co
foreach x in "*wechselmodell*" "*getrennt*haushalt*" "*ex?frau*" "*ex?mann*" ///
			 "*ex?partner*" "*exfrau*" "*exmann*" "ex*" ///
			 "*kinder sind etwa die hälfte*" "*in ihrem haushalt*" ///
			 "*vater*" "papa" "*teils ist mein sohn bei papa*" ///
			 "*hälfte bei ihrer mutter" "*eine woche*ihrer mutter*"	///
			 "*andere*elternteil*" "*kindesmutter*" "*kindsmutter*"	///
			 "*leben nur teilzeit bei*" "*konklomerat aus mehreren antworten*" {
	replace test7 = 1 if strmatch(q17other, "`x'")
	replace test4 = . if strmatch(q17other, "`x'")
}

foreach x in "*kinderfrau*" "*nanny*" "*betreuungskraft*" "*sitter*" ///
			 "*bezahlt*betreuung*" "*bruder*" "*schwester*" "*haushalt*hilfe*" ///
			 "patchworkfamilie" "kindersitt*" "*betreuungsperson*" ///
			 "*dienstleister*"	"*au?pair*" "*aupair*" "feste angestellte" ///
			 "*von allem etwas*" "*betreuung eingekauft*" "von allen etwas" ///
			 "* extra angestellt*" "*stundenweise bei der tagsmutter*"	///
			 "*unterstützen uns*nachbarschaft*" "*manchmal*betreuerin organis*"	///
			 {
	replace test7 = 1 if strmatch(q17other, "`x'")

}

*q17childcare8 Wir haben ein Tauschmodell mit anderen Eltern
foreach x in "*wir teilen uns das haus mit*auch die kinderbetreuung*" ///
			 "*rotierende betreuung*" "*von allem etwas*" {
	replace test8 = 1 if strmatch(q17other, "`x'")
}

*q17childcare9 Die Kinder sind alleine zu Hause/Keine Kinderbetreuung nötig
foreach x in "*sind die kinder*allein*" "*alleine zu hause*" ///
			 "ein kombination  aus den antworten 2/3 /4 und 9" ///
			 "*genug*" "*nötig*" "*notwendig*" "*keine*betreu*nötig*" ///
			 "*betreut sich*" "*sich selb*" "*sich allein*" ///
			 "*1? jahre*" "*ist 1?*" "*kaum noch betreuung*" ///
			 "*volljährig*" "*nicht mehr*betreut*" ///
			 "*nicht betreu*" "kind*nicht*betreu*" "*keine betreuung*" ///
			 "*kaum betreu*" "*kind*selbst*ändig*" "*fsj*" ///
			 "*kind*eigenständig*" "*selbstbetreuung*" ///
			 "*kind ist*groß*" "*betreuung erforderlich*" ///
			 "*kind arbeitet*" "*mit 16*" "*sind so alt*" ///
			 "*älteren passen auf*kleine*auf*" "*netflix*" ///
			 "*geschwister*" "*kommt alleine klar*" "*erwachsene*" ///
			 "*passt der große auf*" "*große tochter*" ///
			 "*lassen die kinder*allein*" "*mittlere allein zu hause*"	///
			 "*tochter könnte auch alleine*" "*stundenweise allein*"	///
			 "*von allem etwas*" "*ist azubi*" "*die mittlere allein*" {
	replace test9 = 1 if strmatch(q17other, "`x'")
}

* Kein Elternteil des Kindes 
foreach x in "*ist der Opa und*" "*unser Enkel*" "*leben in einem Dreigenerati*" ///
			 "*ich*enkelkinder*" {
		foreach y in 1 2 3 4 5 6 7 8 9 {
			replace q17childcare`y' = .b if strmatch(q17other, "`x'")
			replace test`y'= . if strmatch(q17other, "`x'")
		}
}

foreach x in "*ist der Opa und*" "*unser Enkel*" "*leben in einem Dreigenerati*" ///
			 "*ich*enkelkinder*" {
	replace q15achildren = 0 if strmatch(q17other, "`x'")
	replace q17childtvtimea = .b if strmatch(q17other, "`x'")
	replace q17childcaresub11 =.b if strmatch(q17other, "`x'")
	replace q17childcaresub12 =.b if strmatch(q17other, "`x'")
	replace q17childcaresub21 =.b if strmatch(q17other, "`x'")
	replace q17childcaresub22 =.b if strmatch(q17other, "`x'")
	replace q19currentdiv5 = .b if strmatch(q17other, "`x'")
	replace q17other = "" if strmatch(q17other, "`x'")
}

* Recodierung nicht notwendig oder unsinnige Angaben
foreach x in "mischung aus allen drei sachen weil unterschiedliche altersstufen*" ///
			 "ungutes gefühl wenn ich beim arbeiten bin*" "*sie werden festgebunden*"	///
			 "*normalerweise arbeite ich zusätzlich in einer schule*"	///
			 "meine frau ist in mutterschutz und betreut so weit es geht das kind*"	///
			 "coworking mit kinderbetreuung*" "parter arbeitet während er betreut*"	///
			 "ipad*" "ich kann meine kinder morgen t zur arbeit*"	///
			 "ich passe meine arbeitszeiten an, um möglichst da*"	///
			 "ich arbeite am wochenende*" "kinderbetreuung zu hause*"	///
			 "*ist ein mix aus den o.g. möglichkeiten*"	///
			 "großer betreut jüngere*"	"ich habe meine arbeitszeit auf nachmittag*" ///
			 "*betreue sie zu hause während ich vollzeit von zu hause*"	///
			 "*durch mich, arbeitstage werden aktuell am samstag eingebracht*"	///
			 "*arbeite ab nachmittags, dmit ich morgens homeschooling *"	///
			 "ich betreue sie und arbeite sehr wenig*" "betreuung von mir"	///
			 "*betreue meine kinder vormittag und fahre*"	///
			 "*wegen eigenschutz in quarantäne auch von der*"	{
	replace q17other = "" if strmatch(q17other, "`x'")
}

/*
* Kontrolle eigenen Angaben vs. zugeordnete Angaben
list q17other test* q17childcare? if q17other!="" & (test1 != q17childcare1 | ///
													 test2 != q17childcare2 | ///
													 test3 != q17childcare3 | ///
													 test4 != q17childcare4 | ///
													 test5 != q17childcare5 | ///
													 test6 != q17childcare6 | ///
													 test7 != q17childcare7 | ///
													 test8 != q17childcare8 | ///
													 test9 != q17childcare9) & ///
													 (q17childcare1 == 1 |	///
													  q17childcare2 == 1 |	///
													  q17childcare3 == 1 |	///
													  q17childcare4 == 1 |	///
													  q17childcare5 == 1 |	///
													  q17childcare6 == 1 |	///
													  q17childcare7 == 1 |	///
													  q17childcare8 == 1 |	///
													  q17childcare9 == 1 )

*/

*	Fälle richtig zuordnen				 
forvalues num = 1/9 {
	replace q17childcare`num'=1 if test`num'==1
}

/*
* Kontrolle: Übrige Beobachtungen
list  q17other  test* q17childcare?  if childcare1 == . & ///
										childcare2 == . & ///
										childcare3 == . & ///
										childcare4 == . & ///
										childcare5 == . & ///
										childcare6 == . & ///
										childcare7 == . & ///
										childcare8 == . & ///
										childcare9 == . & ///
										q17other != ""
*/				 





*Hilfsvariable löschen
drop q17other test*

exit
