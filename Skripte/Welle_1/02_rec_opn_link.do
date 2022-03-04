/* Kodierung der offenen Antworten Frage
	link?: Wie haben Sie den Link zur Befragung erhalten?

in 5 Kategorien:
	1. (Email) von Freund/Familie/Bekannten
	2. Emailliste/Verteiler
  3. Instant Messenger (z.B. WhatsApp)
	4. + 5.  Microblog und Social-Media-Plattform (z.B. Twitter, Facebook)
	6. (Online-)Medien (Radio, Zeitung)
*/

* Hilfsvariable erstellen
replace linkother = strlower(linkother)

* Wie haben Sie den Link zur Befragung erhalten?
strrec linkother ///
/// 1. (Email) von Freund/Familie/Bekannten
  ("*ehe*"       = "1") ///
  ("*partner*"   = "1") ///
  ("*frau*"      = "1") ///
  ("*tochter*"   = "1") ///
  ("*sohn*"      = "1") ///
  ("*schwester*" = "1") ///
  ("*familie*"   = "1") ///
  ("*verwand*"   = "1") ///
  ("*freund*"    = "1") ///
  ("*bekannte*"  = "1") ///
  ("*kolleg*"    = "1") ///
/// 2. Emailliste/Verteiler
  ("*newsletter*"  = "2") /// Newsletter
  ("*verteiler*"   = "2") ///
  ("*intranet*"    = "2") ///
  ("*unternehmen*" = "2") ///
  ("*beruf*"       = "2") ///
  ("*arbeit*"      = "2") ///
  ("*firma*"       = "2") ///
  ("*firmen*"      = "2") ///
  ("*dienst*"      = "2") ///
  ("*wzb*"         = "2") ///
  ("*slack*"       = "2") ///
  ("*slak*"        = "2") ///
  ("*db planet*"   = "2") /// Deutsche Bahn
  ("*uni*"         = "2") ///
  ("*leibnitz*"    = "2") ///
///  3. Instant Messenger (z.B. WhatsApp)
  ("*hats*"     = "3") /// WhatsApp
  ("*What*"     = "3") ///
  ("*threema*"  = "3") /// Threema
  ("*threma*"   = "3") ///
  ("*telegram*" = "3") /// Telegram
  ("*signal*"   = "3") /// Signal
  ("*sms*"      = "3") ///
/// 4. + 5.  Microblog und Social-Media-Plattform (z.B. Twitter, Facebook)
  ("*twitter*"     = "5") ///
  ("*instagram*"   = "5") ///
  ("*nebenan*"     = "5") /// nebenan.de
  ("*nachbarn.de*" = "5") ///
  ("*linked*"      = "5") ///
  ("*tumblr*"      = "5") ///
  ("*forum*"       = "5") ///
  ("*netzwerk*"    = "5") ///
  ("*blog*"        = "5") ///
/// 6. (Online-)Medien (Radio, Zeitung)
  ("*zeitung*"      = "6") /// (Tages-) Zeitungen
  ("*tagesspiegel*" = "6") ///
  ("*tagespiegel*"  = "6") ///
  ("*radio*"        = "6") /// Radio
  ("*rundfunk*"     = "6") /// Rundfunk
  ("*artikel*"      = "6") /// Artikel
  ("*Nachrichten*"  = "6") ///
  ("*presse*"       = "6") ///
  ("*print*"        = "6") ///
  ("*news*"         = "6") ///
  ("*pnn*"          = "6") ///
  ("*anzeige*"      = "6") ///
  ("*allgemeine*"   = "6") ///
  ("*SWR2*"         = "6") ///
  ("*msn*"          = "6") ///
  ("*welt.*"        = "6") ///
  ("*blatt*"        = "6") ///
  ("*jugendhilfe*"  = "6") /// Jugendhilfeportal
  ("*homepage*"     = "6") ///
  ("*idw*"          = "6") ///
  , sub replace string


foreach num of numlist 1/6 {
  replace link`num' = 1  if linkother == "`num'"
  replace linkother = "" if linkother == "`num'"
}

* Kategorie 4 und 5 zusammenfügen
replace link4 = 1 if link5 == 1
replace link5 = .
replace link5 = link6

drop link6


exit
