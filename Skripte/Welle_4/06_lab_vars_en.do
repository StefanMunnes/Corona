lab drop _all

***label variables
lab var surveyday "Day of participation"
lab var interviewtime"Duration (in minutes)"
lab var lastgroup 	"Last completed group of questions"
lab var id			"Personal ID (automatic)"
lab var wave 		"Number of wave"

lab var q01gndr 	"Gender"
lab var q02yrbrn 	"Year of Birth"
lab var q03empsts	"Employment"
lab var q04newemp	  "New job"
lab var q04status	"Reason for not being employed"
lab var q04statusother"Reason for not being employed: Other"
lab var q04bjobloss	"Job loss during the pandemic"
lab var q05selfempl	"Self-employed/freelancer"
lab var q05cntrct	"Type of contract"
lab var q06firmsize	"Firm size"
lab var q07indust2	"Sector (detailed)"
lab var q07indust	"Sector"
lab var q07indchange	"Sector pre-pandemic"
lab var q07indust2pre	"Sector pre-pandemic (detailed) "
lab var q08prof2	"Key/essential service worker (detailed)"
lab var q08prof		"Key/essential service worker"
lab var q10currenttime"Working hours now relative to before"
lab var q11reason	"Reason for currently not working"
lab var q11reasonother "Reason for currently not working: Other"
lab var	q11lastwh	"Current: working hours"
lab var q11lockdown1 "Working hours during Shutdown light"
lab var q11lockdown2 "Working hours during second lockdown"
lab var q11reduction1_1 "Currently: Operational reasons"
lab var q11reduction1_2 "Currently: Child care"
lab var q11reduction1_3 "Currently: Care of relatives"
lab var q11reduction1_4 "Currently: Other reasons"
lab var q11reduction2_1 "Shutdown light: Operational reasons"
lab var q11reduction2_2 "Shutdown light: Child care"
lab var q11reduction2_3 "Shutdown light: Care of relatives"
lab var q11reduction2_4 "Shutdown light: Other reasons"
lab var q11reduction3_1 "2. Lockdown: Operational reasons"
lab var q11reduction3_2 "2. Lockdown: Child care"
lab var q11reduction3_3 "2. Lockdown: Care of relatives"
lab var q11reduction3_4 "2. Lockdown: Other reasons"
lab var q11realisation1_1 "Currently: Contractual reduction of working hours"
lab var q11realisation1_2 "Currently: Agreement without contract amendment"
lab var q11realisation1_3 "Currently: Use of accrued overtime"
lab var q11realisation1_4 "Currently: Mandatory vacation "
lab var q11realisation1_5 "Currently: Special leave"
lab var q11realisation1_6 "Currently: None of the above"
lab var q11realisation2_1 "Shutdown light: Contractual reduction of working hours"
lab var q11realisation2_2 "Shutdown light: Agreement without contract amendment"
lab var q11realisation2_3 "Shutdown light: Use of accrued overtime"
lab var q11realisation2_4 "Shutdown light: Mandatory vacation "
lab var q11realisation2_5 "Shutdown light: Special leave"
lab var q11realisation2_6 "Shutdown light: None of the above"
lab var q11realisation3_1 "2. Lockdown: Contractual reduction of working hours"
lab var q11realisation3_2 "2. Lockdown: Agreement without contract amendment"
lab var q11realisation3_3 "2. Lockdown: Use of accrued overtime"
lab var q11realisation3_4 "2. Lockdown: Mandatory vacation "
lab var q11realisation3_5 "2. Lockdown: Special leave"
lab var q11realisation3_6 "2. Lockdown: None of the above"
lab var q11compen1 "Currently: Receiving financial support"
lab var q11compen2 "Shutdown light: Receiving financial support"
lab var q11compen3 "2. Lockdown: Receiving financial support"
lab var q12office	"Current place of work"
lab var q12officeother"Current place of work: Other"
lab var homeoffice	"Homeoffice"
lab var homeoffice_det"Homeoffice (detailed)"
lab var q12hopref      "Desired scope of home office"
lab var q12workcond1   "Conditions: Duties require presence"
lab var q12workcond2   "Conditions: Working at home is not allowed"
lab var q12workcond3   "Conditions: Work at the place of work currently prohibited"
lab var q12workcond4   "Conditions: Presence important to superiors"
lab var q12workcond5   "Conditions: Residence unsuitable for work"
lab var q12workcond6   "Conditions: Residence does not meet technical requirements"
lab var q12workcond7   "Conditions: Not sufficiently involved at home"
lab var q12workcond8   "Conditions: difficulties focusing on work at home"
lab var q12workcond9   "Conditions: Easier to reconcile with family"
lab var q12workcond10  "Conditions: Safer at home"
lab var q12workcond11  "Conditions: Save myself long commute"
lab var q13support1		 "feel supported by employer/client"
lab var q13support2		 "prescribed hygiene rules are observed"
lab var q13support3		 "Support for working time arrangements by employer"
lab var q13support4		 "Support coping with private situation by employer"
lab var q14partner		"Relationship status"
lab var q14cohabitpre   "Lived together before pandemic"
lab var q14carehh       "HH members in need of care"
lab var q15achildren	"Children in household"
lab var q17childcare1  "Childcare arrangement: At home, not working"
lab var q17childcare2  "Childcare arrangement: At home, while working"
lab var q17childcare3  "Childcare arrangement: During the day, working when children are sleeping"
lab var q17childcare12	"Childcare arrangement: Partner is looking after them at home, not working"
lab var q17childcare13	"Childcare arrangement: Partner looks after them at home, while working"
lab var q17childcare5  "Childcare arrangement: Emergency care"
lab var q17childcare6  "Childcare arrangement: Grandparents"
lab var q17childcare7  "Childcare arrangement: Relatives, friends, neighbors"
lab var q17childcare8  "Childcare arrangement: Swapping with other parents"
lab var q17childcare9  "Childcare arrangement: Children are home alone"
lab var q17childcare10 "Childcare arrangement: At school/nursery (reduced hours)"
lab var q17childcare11 "Childcare arrangement: At school/nursery (usual hours)"
lab var q17childcareother	"Childcare arrangement: Other"
lab var q18schoolage   "School grade of youngest schoolchild"
lab var q18schoolform  "School form of youngest child"
lab var q18schoolsat   "Satisfaction with school"
lab var q18schoolsit1  "Teaching of the subject matter was difficult"
lab var q18schoolsit2  "Concerned about permanent disadvantages due to school closure"
lab var q18schoolsit3  "Child worked on tasks mostly independently"
lab var q18schoolsit4  "Coped well with the learning material"
lab var q18schoolsit5  "Established a well-functioning daily structure "
lab var q18schoolsit6  "Home schooling was stressful"
lab var q18schoolsit7  "Conflicts with partner because of learning supervision"
lab var q18schoolsit8  "Frequent conflicts with child over home schooling"
lab var q18schoolsit9  "The teacher(s) supported us well"
lab var q18schoolsit10 "Felt left alone by the school"
lab var q17childcaresub11 "Current: exhausted because of childcare"
lab var q17childcaresub12 "Current: trapped by parental responsibilities"
lab var q17gendernorm1 "Working mother's relationship with own child can be just as warm"
lab var q17gendernorm2 "More important for wife to support husband's career than her own"
lab var q17gendernorm3 "Small child suffers if his/her mother works"
lab var q17gendernorm4 "Breadwinner husband/housewife model better for everyone concerned"
lab var q17gendernorm5 "Child benefits from his/her mother having a job"
lab var q17gendernorm6 "Married woman shouldn't work if not necessary/not enough jobs"
lab var q17gendernorm7 "Both spouses should contribute to household income"
lab var q17gendernorm8 "Fathers and mothers equally well-suited for childrearing"
lab var q19currentdiv1 "Current division of household work: Housework"
lab var q19currentdiv2 "Current division of household work: Grocery shopping"
lab var q19currentdiv3 "Current division of household work: Repairs"
lab var q19currentdiv4 "Current division of household work: Financial/administrative errands"
lab var q19currentdiv5 "Current division of household work: Childcare"
lab var q20sat11	"Current satisfaction: Work"
lab var q20sat12	"Current satisfaction: Relationship"
lab var q20sat13	"Current satisfaction: Family life"
lab var q20sat14	"Current satisfaction: Distribution of tasks within the household"
lab var q20sat15	"Current satisfaction: Quality of social contacts"
lab var q20sat16	"Current satisfaction: Mutual helpfulness within your neighborhood"
lab var q20sat17	"Current satisfaction: Life in general"
lab var q20sat18 "Current satisfaction: Reconciliation of work and child care"
lab var q20crisis1 "Satisfaction crisis management Federal government (Bundesregierung)"
lab var q20crisis2 "Satisfaction crisis management State government (Landesregierung)"
lab var q20crisis3 "Satisfaction crisis management School"
lab var q20crisisland1 "State government: Measures effective"
lab var q20crisisland2 "State government: Measures comprehensible"
lab var q20crisisland3 "State government: Satisfied with communication"
lab var q20crisisland4 "State government: Violation of basic rights"
lab var q20crisisland5 "State government: Burden due to planning uncertainty"
lab var q20famsup1 "Known state offers: Child bonus"
lab var q20famsup2 "Known state offers: Children sick days/special leave"
lab var q20famsup3 "Known state offers: Emergency child supplement"
lab var q20famsup4 "Known state offers: Compensation for lost earnings"
lab var q20famsup5 "Known state offers: Continued wage payments by employer"
lab var q20famsup6 "Known state offers: Reimbursement of parental contributions"
lab var q20famsup7 "Known state offers: Acute help for family caregivers"
lab var q20famsup8 "Known state offers: Simplified access to ALG II"
lab var q20famsupother "Known programs: Others"
lab var q20famsupsat11 "Own family: Child bonus"
lab var q20famsupsat12 "Own family: Children sick days/special leave"
lab var q20famsupsat13 "Own family: Emergency child supplement"
lab var q20famsupsat14 "Own family: Compensation for lost earnings"
lab var q20famsupsat15 "Own family: Continued wage payments by employer"
lab var q20famsupsat16 "Own family: Reimbursement of parental contributions"
lab var q20famsupsat17 "Own family: Acute help for family caregivers"
lab var q20famsupsat18 "Own family: Simplified access to ALG II"
lab var q20famsupsat19 "Own family: Others"
lab var q20famsupsat21 "Families in general: Child bonus"
lab var q20famsupsat22 "Families in general: Children sick days/special leave"
lab var q20famsupsat23 "Families in general: Emergency child supplement"
lab var q20famsupsat24 "Families in general: Compensation for lost earnings"
lab var q20famsupsat25 "Families in general: Continued wage payments by employer"
lab var q20famsupsat26 "Families in general: Reimbursement of parental contributions"
lab var q20famsupsat27 "Families in general: Acute help for family caregivers"
lab var q20famsupsat28 "Families in general: Simplified access to ALG II"
lab var q20famsupsat29 "Families in general: Others"
lab var q21concern11 "Current concerns: Financial situation"
lab var q21concern12 "Current concerns: Loss of job"
lab var q21concern13 "Current concerns: Own health"
lab var q21concern14 "Current concerns: Health of relatives"
lab var q21concern15 "Current concerns: Career advancement"
lab var q29gndrpar			"Partner: gender"
lab var q33educpar			"Partner: highest prof. degree"
lab var q30empstspar		"Partner: employment"
lab var q30currenttimepar	"Partner: working hours now relative to before"
lab var q31usualwhpar "Partner: usual working hours"
lab var q31lastwhpar  "Partner: current working hours"
lab var q31profpar		"Partner: Key/essential service worker"
lab var q32officepar "Partner: current place of work"
lab var q32officeparother	"Partner: current place of work: Other"
lab var q34hhinc	"Rating household income"
lab var q34prevhhinc"Before: rating household income"
lab var q35distress11 "Current: anxious, nervous, restless"
lab var q35distress12 "Current: depressed, hopeless, strained"
lab var q35health1    "Current: physical health"

lab var female "female"
lab var age			"age"
lab var agegr  "age cohort"
lab var status "Main activity"
lab var permempl "permanent employment"
lab var selfempl "Self-employed/freelance"
lab var sysjob "Key/essential worker"
lab var fam 	 "Family situation"
lab var hhinc  "Rating household income"


********************************************************************************
*** define value labels ********************************************************

lab define yesno 0 "no" 1 "yes"

lab define scale_trifft_lab ///
  0 "does not apply to me" ///
  1 "does not apply at all" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" ///
  7 "applies completely"
lab define scale_stimme_lab ///
  1 "strongly disagree" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" ///
  7 "strongly agree"
lab define scale_zufrieden_lab 1 "very dissatisfied" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "very satisfied"
lab define scale_hilfreich_lab 1 "not at all helpful" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "very helpful"
lab define concern_lab 1 "very concerened" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "not concered at all"
lab define schoolsit_lab ///
  0 "does not apply" ///
  1 "strongly disagree" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" ///
  7 "strongly agree"

lab define gndr_lab 1 "male" 2 "female" 3 "diverse"
lab define status_lab ///
  0 "Other" ///
  1 "Pupil/Student" ///
  2 "Unemployed" ///
  3 "Retirement/Pension" ///
  4 "Maternity protection" ///
  5 "Homemaker"

lab define cntrct_lab ///
  1 "permanent employment" ///
  2 "temporary employment"
lab define firmsize_lab 1 "<20" 2 "20-200" 3 ">200"
lab define indust_lab ///
  1	"Agriculture, forestry and fisheries" ///
  2	"Manufacturing, mining, other industry" ///
  3	"Construction" ///
  4	"Trade, hospitality, transport, warehousing" ///
  5	"Information and communication" ///
  6	"Financial and insurance services" ///
  7	"Scientific, technical, economic services" ///
  8	"Public administration, defense" ///
  9	"Education, health and social services" ///
  10 "Other services"
lab define indust2_lab ///
  1	 "Agriculture, forestry and fisheries" ///
  2	 "Manufacturing, mining, other industry" ///
  3	 "Construction" ///
  41 "Trade" ///
  42 "Hospitality" ///
  43 "transport and warehousing" ///
  5	 "Information and communication" ///
  6	 "Financial and insurance services" ///
  71 "Scientific and technical services" ///
  72 "Economic services" ///
  8	 "Public administration, defense" ///
  91 "Education and teaching" ///
  92 "Health and social services" ///
  10 "Other services" ///
  11 "Art, culture and recreation"
lab define prof_lab ///
  1	"No" ///
  2	"Yes: Police, fire and relief organizations; correctional and crisis management personnel" ///
  3	"Yes: Public transport, supply and disposal, energy supply" ///
  4	"Yes: Health care and nursing staff" ///
  5	"Yes: Personnel in public institutions and authorities" ///
  6	"Yes: Personnel providing emergency care in daycare centers and schools" ///
  7	"Yes: Other Critical Infrastructure & Basic Services Personnel" ///
  8 "Yes: Retail (grocery and drug stores)"
lab define prof2_lab ///
  1	 "Nein" ///
  2	 "Yes: Police, fire and relief organizations" ///
  3  "Yes: Correctional personnel" ///
  4  "Yes: Crisis management personnel" ///
  5	 "Yes: Public transport, supply and disposal, energy supply" ///
  6	 "Yes: Health care and nursing staff " ///
  7	 "Yes: Personnel in public institutions and authorities " ///
  8	 "Yes: Personnel providing emergency care in daycare centers and schools" ///
  9	 "Yes: Other Critical Infrastructure & Basic Services Personnel " ///
  10 "Yes: Retail (grocery and drug stores)"
lab define currenttime_lab ///
  1 "As many hours as usual" ///
  2	"Fewer hours than usual" ///
  3	"More hours than usual" ///
  4	"Did not work at all"
lab define lockdown_lab ///
  1 "As many hours as usual" ///
  2	"Fewer hours than usual" ///
  3	"More hours than usual" ///
  4	"Did not work at all"
lab define reason_lab ///
  0	"Other" ///
  1	"On paid leave" ///
  2	"On unpaid leave " ///
  3	"Released from duty for operational reasons" ///
  4	"I no longer have any assignments" ///
  5	"On sick leave" ///
  6 "I am on short-time work"
lab define compen_lab2 ///
  1 "No (my income is reduced proportionally to my working time)" ///
  2 "Yes, short-time working scheme" ///
  3 "Yes, I'm still earning the same amount" ///
  4 "Yes, Compensation payments" ///
  5 "Yes, Other financial compensation"
lab define office_lab ///
  0	"Other" ///
  1	"Still (mainly) at my workplace" ///
  2	"Due to the Coronavirus pandemic (mainly) from home" ///
  3	"Working from home, as always" ///
  4 "An even balance between usual workplace and working from home"
lab define officepar_lab ///
  0	"Other" ///
  1	"Still (mainly) at my workplace" ///
  2	"Due to the Coronavirus pandemic (mainly) from home" ///
  3	"Working from home, as always" ///
  4 "Currently not working" ///
  5 "An even balance between usual workplace and working from home"
lab define hopref_lab ///
  1 "Desired amount of time at home" ///
  2 "Would like to work at home (more often)" ///
  3 "Would like to work at home less often"
lab define homeoffice_det_lab ///
  0 "No" 	///
  1 "Yes, new" ///
  2 "Yes, always" ///
  3 "Currently not working"
lab define schoolage_lab 0 "No school child"
lab define schoolform_lab ///
  1 "Classroom teaching" ///
  2 "Hybrid schedule" ///
  3 "Digital teaching" ///
  4 "Home Schooling with teacher" ///
  5 "Home Schooling without teacher" ///
  6 "Emergency supervision"
lab define divlab_lab ///
  1	"(Almost) exclusively my partner" ///
  2	"Mostly my partner" ///
  3	"About fifty-fifty" ///
  4	"Mostly me" ///
  5	"(Almost) exclusively me" ///
  6	"Exclusively someone else" ///
  7	"Does not apply to us"
lab define educ_lab ///
  0 "in school/voc. training/university" ///
  1 "No voc. training or university degree" ///
  2 "Learnership" ///
  3 "Apprenticeship or vocational training" ///
  4 "Completed university degree"

lab define other_lab 0 "No" 1 "Yes, namely:"

lab define hhinc_lab ///
  1 "Living comfortably" ///
  2 "Getting by" ///
  3 "Difficulties getting by" ///
  4 "Barely coping"

lab define agegr_lab ///
  1 "18-24" ///
  2 "25-29" ///
  3 "30-34" ///
  4 "35-39" ///
  5 "40-44" ///
  6 "45-49" ///
  7 "50-54" ///
  8 "55-59" ///
  9 "60-64" ///
  10 "65-69" ///
  11 "70-74" ///
  12 "75-79" ///
  13 "80+"

lab define status2_lab ///
  0 "Employed" ///
  1 "School/university student" ///
  2 "Unemployed" ///
  3 "Retired" ///
  4 "Maternity protection/parental leave" ///
  5 "Homemaker"

lab define edu_lab ///
  0 "Still in school/apprenticeship/university" ///
  1 "None or Semi-skilled training" ///
  2 "Apprenticeship/vocational education" ///
  3 "University degree"

lab define size_lab 5 "5+"

lab define nrchildren_lab 3 "3+"

lab define youngestcat_lab 1 "U3" 2 "3-5" 3 "6-10" 4 "11-17"

lab define fam_lab ///
  1 "Single, no children" ///
  2 "Living with partner, no children" ///
  3 "Living with partner and children" ///
  4 "Single parent"

label define childcare_lab ///
  1 "By myself" ///
  2 "Jointly with partner or a different person" ///
  3 "Done by partner" ///
  4 "Other/mix"

lab define currenttimepar_lab ///
  1 "As many hours as before" ///
  2 "Fewer hours than before"  ///
  3 "More hours than before"  ///
  4 "Currently not working"

lab define inc_lab  ///
  1	"Bequem leben" ///
  2	"Zurechtkommen" ///
  3	"Nur (sehr) schwer zurechtkommen"

lab define distress_lab ///
  1 "Never" ///
  2 "Rarely" ///
  3 "Sometimes" ///
  4 "Most of the time" ///
  5 "All the time"

lab define health_lab ///
  1 "Very good" ///
  2 "Good" ///
  3 "Satisfactory" ///
  4 "Poor" ///
  5 "Bad"


********************************************************************************
*** attach value labels ***

lab val female q03empsts q04newemp q04bjoblos q05selfempl permempl selfempl ///
  q07indchange sysjob homeoffice q11reduction* q11realisation* ///
  q14* q15achildren q17childcare? q17childcare?? q20famsup? ///
  q30empstspar ///
	yesno

lab val q12workcond* scale_trifft_lab
lab val q13support? q17childcaresub1? q17gendernorm? q20crisisland? scale_stimme_lab
lab val q20sat1? q20crisis? scale_zufrieden_lab
lab val q20famsupsat?? scale_hilfreich_lab

lab val q01gndr q29gndrpar gndr_lab
lab val q04status status_lab
lab val q05cntrct cntrct_lab
lab val q06firmsize firmsize_lab
lab val q07indust2 q07indust2pre indust2_lab
lab val q07indust indust_lab
lab val q08prof2 prof2_lab
lab val q08prof prof_lab
lab val q10currenttime currenttime_lab
lab val q11lockdown? lockdown_lab
lab val q11reason reason_lab
lab val q11compen? compen_lab2
lab val q12office office_lab
lab val q32officepar officepar_lab
lab val q12hopref hopref_lab
lab val homeoffice_det homeoffice_det_lab
lab val q18schoolage  schoolage_lab
lab val q18schoolform schoolform_lab
lab val q18schoolsat  scale_zufrieden_lab
lab val q18schoolsit* schoolsit_lab
lab val q19currentdiv* divlab_lab
lab val q21concern* concern_lab
lab val q33educpar educ_lab
lab val q30currenttimepar currenttimepar_lab
lab val q31profpar prof_lab
lab val q34hhinc q34prevhhinc hhinc_lab
lab val q35distress* distress_lab
lab val q35health? health_lab

lab val agegr agegr_lab
lab val status status2_lab
lab val fam fam_lab
lab val hhinc inc_lab

exit
