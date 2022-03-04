
*** Variablen beschriften ***
// lab var startdate "Startzeitpunkt"
// lab var datestamp "Zeitpunkt letzte Aktivität"
// lab var submitdate "Endzeitpunkt (Abgabe)"
lab var id "Personen-ID (automatisch)"
lab var wave "Wellennumber"
lab var version "Fragebogen-Version"
lab var lastgroup  "letzte ausgefüllte Fragegruppe"
lab var surveyday "Tag der Teilnahme"
lab var interviewtime	"Dauer (Minuten)"

lab var link1 "(E-Mail) Familie/Bekannte/r"
lab var link2 "Emailliste/Verteiler"
lab var link3 "Instant Messenger (z.B. WhatsApp)"
lab var link4 "Social-Media-Platformen (z.B. Twitter/Facebook)"
lab var link5 "(Online-)Medien (Radio, Zeitung)"

lab var linkother "Link von: Sonstiges"

lab var q01gndr "Geschlecht"
lab var female "weiblich"
lab var q02yrbrn "Geburtsjahr"
lab var age "Alter"
lab var q03empsts "Erwerbstätig?"
lab var q04status "Warum nicht erwerbstätig?"
lab var q04statusother "Warum nicht erwerbstätig? Sonstiges"
lab var q04bjobloss "Beruf letzte 4 Wochen verloren?"

lab var q05ctrtype "Arbeitsverhältnis"
lab var q05ctrtypeother	"Arbeitsverhältnis Sonstiges"
lab var q06firmsize "Anzahl Beschäftigte"
lab var q07indust "Branche"
lab var q08prof "Beruf systemrelevant"
lab var q09wtime "übliche Wochenstunden"
lab var q10currenttime "tatsächliche Wochenstunden"
lab var q11reason "Warum arbeiten Sie zurzeit nicht?"
lab var q11reasonother "Warum arbeiten Sie zurzeit nicht?: Sonstiges"
lab var q12time11 "akt. Abendarbeit"
lab var q12time12 "akt. Nachtarbeit"
lab var q12time21 "früher Abendarbeit"
lab var q12time22 "früher Nachtarbeit"
lab var q12office "Von wo aus arbeiten Sie im Moment?"
lab var q12officeother "Von wo aus arbeiten Sie im Moment?: Sonstiges"
lab var homeoffice "Homeoffice"
lab var homeoffice_det	"Homeoffice detailliert"
lab var q13support "fühle mich von Arbeitgeber/Auftraggeber unterstützt"

lab var q14partner "feste/r Patner/in?"
lab var q15achildren "Kind/er mit Partner/in?"
lab var q15bchildren "Anzahl minderjährige Kinder"

foreach num of numlist 1/10 {
	lab var q16byrchild`num' "Geburtsjahr `num'. Kind"
	lab var q16childage`num' "Alter `num'. Kind"
}

lab var q17childcare1 "Betreuung: zu Hause, ohne zu arbeiten"
lab var q17childcare2 "Betreuung: zu Hause, während arbeiten"
lab var q17childcare3 "Betreuung: tagsüber, arbeiten wenn sie schlafen"
lab var q17childcare4 "Betreuung: Partner/in betreut"
lab var q17childcare5 "Betreuung: Notfallbetreuung"
lab var q17childcare6 "Betreuung: Großeltern"
lab var q17childcare7 "Betreuung: Verwandte, Freunde, Nachbarn"
lab var q17childcare8 "Betreuung: Tauschmodell mit anderen Eltern"
lab var q17childcare9 "Betreuung: Kinder alleine zu Hause"

lab var q17childcareother	 "Betreuung: Sonstiges"

lab var q17childtvtimea	"Bildschirmzeit Kinder"
lab var q17childtvtimeb "frühere Bildschirmzeit Kinder"

lab var q17childcaresub11 "akt. erschöpft durch Kinder"
lab var q17childcaresub12 "akt. gefangen durch Elternpflichten"
lab var q17childcaresub21 "früher erschöpft durch Kinder"
lab var q17childcaresub22 "früher gefangen durch Elternpflichten"

lab var q18divlab1 "früher Arbeitsteilung: Hausarbeit"
lab var q18divlab2 "früher Arbeitsteilung: Einkaufen"
lab var q18divlab3 "früher Arbeitsteilung: Reparaturen"
lab var q18divlab4 "früher Arbeitsteilung: Finanzen, Behördengänge"
lab var q18divlab5 "früher Arbeitsteilung: Kinderbetreuung"
lab var q19currentdiv1 "akt. Arbeitsteilung: Hausarbeit"
lab var q19currentdiv2 "akt. Arbeitsteilung: Einkaufen"
lab var q19currentdiv3 "akt. Arbeitsteilung: Reparaturen"
lab var q19currentdiv4 "akt. Arbeitsteilung: Finanzen, Behördengänge"
lab var q19currentdiv5 "akt. Arbeitsteilung: Kinderbetreuung"

lab var q20sat11 "akt. Zufriedenheit: Arbeit"
lab var q20sat12 "akt. Zufriedenheit: Beziehung"
lab var q20sat13 "akt. Zufriedenheit: Familienleben"
lab var q20sat14 "akt. Zufriedenheit: Arbeitsteilung Haushalt"
lab var q20sat15 "akt. Zufriedenheit: Qualität soz. Kontakte"
lab var q20sat16 "akt. Zufriedenheit: Hilfsbereichtschaft Nachbarschaft"
lab var q20sat17 "akt. Zufriedenheit: Leben insgesamt"
lab var q20sat21 "früher Zufriedenheit: Arbeit"
lab var q20sat22 "früher Zufriedenheit: Beziehung"
lab var q20sat23 "früher Zufriedenheit: Familienleben"
lab var q20sat24 "früher Zufriedenheit: Arbeitsteilung Haushalt"
lab var q20sat25 "früher Zufriedenheit: Qualität soz. Kontakte"
lab var q20sat26 "früher Zufriedenheit: Hilfsbereichtschaft Nachbarn"
lab var q20sat27 "früher Zufriedenheit: Leben insgesamt"

lab var q21concern11 "akt. Sorgen: finanzielle Situation"
lab var q21concern12 "akt. Sorgen: Verlust Arbeitsplatz"
lab var q21concern13 "akt. Sorgen: eigene Gesundheit"
lab var q21concern14 "akt. Sorgen: Gesundheit Angehörige"
lab var q21concern21 "früher Sorgen: finanzielle Situation"
lab var q21concern22 "früher Sorgen: Verlust Arbeitsplatz"
lab var q21concern23 "früher Sorgen: eigene Gesundheit"
lab var q21concern24 "früher Sorgen: Gesundheit Angehörige"

// lab var q22challenge		"akt. größte Herausforderung"

lab var q23land 			"Bundesland"
lab var q24townsize			"Größe Wohnort"
lab var	q25hhsize			"Haushaltsgröße"
lab var	q26flatsize			"Anzahl Räume"
lab var	q27educ				"höchster Abschluss"
lab var	q27educother		"höchster Abschluss: Sonstiges"
lab var q28migr				"Migrationshintergrund"

lab var q29gndrpar			"Geschlecht Partner/in"
lab var q30empstspar		"Partner/in erwerbstätig?"
lab var q31profpar			"Beruf Partner/in systemrelevant?"
lab var q32officepar		"Erwerbssituation Partner/in"
lab var q32officeparother	"Erwerbssituation Partner/in: Sonstiges"
lab var q33educpar			"berufl. Abschluss Partner/in"
lab var q33educparother		"berufl. Abschluss Partner/in: Sonstiges"

lab var q34hhinc			"Beurteilung Haushaltseinkommen"

lab var q35distress11 "akt. ängstlich, nervös, ruhelos"
lab var q35distress12 "akt. niedergeschlagen, hoffnungslos, angestrengt"
lab var q35distress21 "früher ängstlich, nervös, ruhelos"
lab var q35distress22 "früher niedergeschlagen, hoffnungslos, angestrengt"
lab var q35health1 "akt. physischer Gesundheitszustand"
lab var q35health2 "früher physischer Gesundheitszustand"

lab var outro2				"Folgebefragung"

lab var agegr 		"Altersgruppen"
lab var edu			"berufl. Abschluss"
lab var p_edu		"berufl. Abschluss Partner/in"
lab var tertiary 	"abgeschl. Studium"
lab var status		"Haupttätigkeit"
lab var permempl 	"unbefristet Beschäftigt"
lab var selfempl 	"Selbstständig"

lab var nrchildren 	"Kinderzahl"
lab var childcare "Kinderbetreuung"
lab var sysjob 		"Systemrelevanter Beruf"
lab var p_sysjob 	"Partner: Systemrelevanter Beruf"
lab var youngest	"Alter juengstes Kind met"
lab var youngestcat "Alter juengstes Kind kat"
lab var fam 		"Familiensituation"
lab var raumbedarf 	"Raumbedarf"
lab var wohnsit 	"Verhältnis Räume zu HH-Größe"
lab var hhinc 		"Beurteilung Haushaltseinkommen"


********************************************************************************
*** Value label definieren ***

lab define yesno 0 "Nein" 1 "Ja"

lab define gndr_lab 1 "Männlich" 2 "Weiblich" 3 "Divers"

lab define status_lab ///
  0 "Sonstiges" ///
  1 "Schüler*in/Student*in" ///
  2 "Arbeitslos" ///
  3 "Rente/Pension" ///
  4 "Mutterschutz" ///
  5 "Hausfrau/Hausmann"

lab define ctrtype_lab ///
  0 "Sonstiges" ///
  1 "unbefristetes Anstellungsverhältnis" ///
  2 "befristetes Anstellungsverhältnis" ///
  3 "selbständig ohne Mitarbeiter" ///
  4 "selbständig mit Mitarbeitern" ///
  5 "verbeamtet"

lab define firmsize_lab 1 "<20" 2 "20-200" 3 ">200"

lab define indust_lab ///
  1	"Landwirtschaft, Forstwirtschaft und Fischerei" ///
  2	"Verarbeitendes Gewerbe, Bergbau,  sonstige Industrie" ///
  3	"Baugewerbe" ///
  4	"Handel, Gastgewerbe, Verkehr, Lagerei" ///
  5	"Information und Kommunikation" ///
  6	"Finanz- und Versicherungsdienstleistungen" ///
  7	"Wissenschaftliche, technische, wirtschaftliche Dienstleistungen" ///
  8	"Öffentliche Verwaltung, Verteidigung" ///
  9	"Erziehung und Unterricht, Gesundheits- und Sozialwesen" ///
  10 "Sonstige Dienstleistungen"

lab define prof_lab ///
	1	"Nein" ///
	2	"Ja: Polizei, Feuerwehr und Hilfsorganisationen; Justizvollzug und Krisenstabspersona" ///
	3	"Ja: Öffentlicher Nahverkehr, Ver- und Entsorgung, Energieversorgung" ///
	4	"Ja: Personal im Gesundheits- und Pflegebereich " ///
	5	"Ja: Personal in öffentlichen Einrichtungen und Behörden " ///
	6	"Ja: Personal, das die Notversorgung in Kitas und Schulen sichert " ///
	7	"Ja: Sonst. Personal der kritischen Infrastruktur & Grundversorgung " ///
	8 "Ja: Einzelhandel (Lebensmittel- und Drogeriemärkte)"

lab define wtime_lab ///
  1 "bis zu 15 Wochenstunden" 2	"16 bis 25 Wochenstunden" ///
  3	"26 bis 37 Wochenstunden" 4	"38 Wochenstunden und mehr"

lab define currenttime_lab ///
  1 "So viele Stunden wie sonst" ///
  2	"Weniger Stunden als sonst" ///
  3	"Mehr Stunden als sonst" ///
  4	"Ich arbeite zurzeit gar nicht"

lab define reason_lab ///
  0	"Sonstiges" ///
  1	"Ich nehme bezahlten Urlaub" ///
  2	"Ich nehme unbezahlten Urlaub " ///
  3	"Ich bin betriebsbedingt freigestellt" ///
  4	"Ich habe keine Aufträge mehr" ///
  5	"Ich bin krankgeschrieben" ///
  6 "Ich bin in Kurzarbeit"

lab define worktime_time ///
  1 "Nie" ///
  2 "Täglich" ///
  3 "Mehrmals in der Woche" ///
  4 "Wochenweise (Wechselschicht) " ///
  5 "Seltener (nur bei Bedarf)"

lab define office_lab ///
  0	"Sonstiges" ///
  1	"Weiterhin (überwiegend) am Arbeitsort" ///
  2	"Aufgrund der Corona Pandemie (überwiegend) von zu Hause aus" ///
  3	"Wie immer von zu Hause aus" ///
  4 "Arbeitet zurzeit nicht" ///
  5 "Etwa gleich oft am Arbeitsort und zu Hause"

lab define officepar_lab ///
  0	"Sonstiges" ///
  1	"Weiterhin (überwiegend) am Arbeitsort" ///
  2	"Aufgrund der Corona Pandemie (überwiegend) von zu Hause aus" ///
  3	"Wie immer von zu Hause aus" ///
  4 "Etwa gleich oft am Arbeitsort und zu Hause"

lab define homeoffice_det_lab ///
  0 "nein" 	///
  1 "ja, neu" ///
  2 "ja, schon immer" ///
  3 "arbeite zurzeit nicht"

lab define scale_stimme_lab 1 "stimme überhaupt nicht zu" 7 "stimme voll und ganz zu"

lab define childtvtimea_lab ///
  1	"0-1 Stunden" ///
  2	"1-2 Stunden" ///
  3	"2-4 Stunden" ///
  4	"4-6 Stunden" ///
  5	"6 und mehr Stunden"

lab define childtvtimeb_lab ///
  1	"deutlich weniger" ///
  2	"weniger" ///
  3	"in etwa gleich" ///
  4	"mehr" ///
  5	"deutlich mehr"

lab define divlab_lab ///
  1	"(fast) vollständig mein/e Partner/in" ///
  2	"überwiegend mein/e Partner/in" ///
  3	"etwa halbe/halbe" ///
  4	"überwiegend ich" ///
  5	"(fast) vollständig ich" ///
  6	"nur eine andere Person" ///
  7	"das trifft für uns nicht zu"

lab define sat_lab 1 "sehr unzufrieden" 7 "sehr zufrieden"
lab define concern_lab 1 "sehr große Sorgen" 7 "keine Sorgen"

lab define land_lab ///
  1  "Baden-Württemberg" ///
  2  "Bayern" ///
  3  "Berlin" ///
  4  "Brandenburg" ///
  5  "Bremen" ///
  6  "Hamburg" ///
  7  "Hessen" ///
  8  "Mecklenburg-Vorpommern" ///
  9  "Niedersachsen" ///
  10 "Nordrhein-Westfalen" ///
  11 "Rheinland-Pfalz" ///
  12 "Saarland" ///
  13 "Sachsen" ///
  14 "Sachsen-Anhalt" ///
  15 "Schleswig-Holstein" ///
  16 "Thüringen" ///
  17 "im Ausland"

lab define townsize_lab ///
  1	"weniger als 50.000 Einwohner" ///
  2	"50.000 und mehr Einwohner"

lab define educ_lab ///
  0	"in Schule/Ausbildung/Studium" ///
  1	"kein Ausbildungs- oder Hochschulabschluss " ///
  2	"Anlernausbildung" ///
  3	"Lehre oder Berufsausbildung" ///
  4	"Abgeschlossenes Studium" ///
  5	"Sonstiges"

lab define migr_lab ///
  1	"ich als auch Eltern in Deutschland geboren" ///
  2	"Ich in Deutschland geboren, mindestens ein Elternteil im Ausland" ///
  3	"Ich wurde im Ausland geboren"

lab define hhinc_lab ///
  1	"Bequem leben" ///
  2	"Zurechtkommen" ///
  3	"Nur schwer zurechtkommen" ///
  4	"Nur sehr schwer zurechtkommen"

lab define agegr_lab ///
  1  "18-24" ///
  2  "25-29" ///
  3  "30-34" ///
  4  "35-39" ///
  5  "40-44" ///
  6  "45-49" ///
  7  "50-54" ///
  8  "55-59" ///
  9  "60-64" ///
	10 "65-69" ///
	11 "70-74" ///
	12 "75-79" ///
	13 "80+", replace

lab define status2_lab ///
  0 "Erwerbstätig" ///
  1 "Schüler*in/Student*in" ///
  2 "Arbeitslos" ///
  3 "Rente/Pension" ///
  4 "Mutterschutz/Elternzeit" ///
  5 "Hausfrau/Hausmann"

lab define edu_lab ///
  0 "in Schule/Ausbildung/Studium" ///
  1 "keine oder Anlernausbildung" ///
	2 "Ausbildung" ///
  3 "Hochschulabschluss"

lab define hhsize_lab   5 "5+"

lab define flatsize_lab 7 "7+"

lab define nrchildren_lab 3 "3+"

lab define youngestcat_lab 1 "U3" 2 "3-5" 3 "6-10" 4 "11-18"

lab define fam_lab ///
  1 "Single, keine Kinder" ///
  2 "Partner, keine Kinder" ///
  3 "Partner u Kind(er)" ///
  4 "Alleinerziehend"

label define childcare_lab ///
  1 "Ich selbst" ///
  2 "Gemeinsam mit Partner oder anderen Person" ///
  3 "Partner" ///
  4 "Andere/Mischung"

lab define inc_lab  ///
  1	"Bequem leben" ///
  2	"Zurechtkommen" ///
  3	"Nur (sehr) schwer zurechtkommen"

lab define distress_lab ///
  1	"nie" ///
  2	"sehr selten" ///
  3	"ab und zu(manchmal)" ///
  4	"die meiste Zeit" ///
  5	"die ganze Zeit"

lab define health_lab ///
  1	"Sehr gut" ///
  2	"Gut" ///
  3	"Zufriedenstellend" ///
  4	"Weniger gut" ///
  5	"Schlecht"

lab define wohnsit_lab 1 "überbelegt" 2 "adäquat" 3 "unterbelegt"


********************************************************************************
*** Value label zuweisen ***

lab val link? female q03empsts q04bjoblos homeoffice q14partner ///
	q15achildren q17childcare? q30empstspar ///
	outro2 permempl selfempl sysjob p_sysjob tertiary ///
	yesno

lab val q13support q17childcaresub* scale_stimme_lab

lab val q01gndr q29gndrpar gndr_lab
lab val q04status status_lab
lab val q05ctrtype ctrtype_lab
lab val q06firmsize firmsize_lab
lab val q07indust indust_lab
lab val q08prof q31profpar prof_lab
lab val q09wtime wtime_lab
lab val q10currenttime currenttime_lab
lab val q11reason reason_lab
lab val q12time* worktime_lab
lab val q12office office_lab
lab val homeoffice_det homeoffice_det_lab
lab val q17childtvtimea childtvtimea_lab
lab val q17childtvtimeb childtvtimeb_lab
lab val q18divlab* q19currentdiv* divlab_lab
lab val q20sat* sat_lab
lab val q21concern* concern_lab
lab val q23land land_lab
lab val q24townsize townsize_lab
lab val q25hhsize hhsize_lab
lab val q26flatsize flatsize_lab
lab val q27educ q33educpar educ_lab
lab val q28migr migr_lab
lab val q32officepar officepar_lab
lab val q34hhinc hhinc_lab
lab val q35distress* distress_lab
lab val q35health? health_lab

lab val agegr agegr_lab
lab val status status2_lab
lab val nrchildren nrchildren_lab
lab val youngestcat youngestcat_lab
lab val fam fam_lab
lab val wohnsit wohnsit_lab
lab val edu p_edu edu_lab
lab val childcare  childcare_lab
lab val hhinc inc_lab

exit
