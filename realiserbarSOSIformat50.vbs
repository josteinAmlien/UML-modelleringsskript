option explicit 
 
 !INC Local Scripts.EAConstants-VBScript 
 
'  
' Script Name: realiserbarSOSIformat50 
' Author: Kent Jonsrud - Section for standardization and technology development - Norwegian Mapping Authority
' Version: 0.5 Date: 2021-11-17 SOSI_navn på egenskap skal samsvare med eventuellt SOSI_navn på typen
' Version: alfa0.4 Date: 2021-07-16 geometriegenskaper kan mangle tag SOSI_navn, men alle roller blir testet
' Version: alfa0.3
' Date: 2018-03-28

' Purpose: Validere om pakke er realiserbar etter SOSI Realisering i SOSIformat v.5.0 
' Purpose: Validate model elements according to rules defined in the standard SOSI Realisering i SOSIformat v.5.0 
' *Implemented rules: 
' KRAV
' /krav/konteiner	Datafiler som skal brukes til å utveksle geografisk informasjon på SOSI-format skal inneholde et standard filhode og et standard filsluttmerke. Det skal ikke være datainnhold etter filsluttmerket. Filhodet skal inneholde angivelse av tegnsett, formatversjon, koordinatsystem, horisontal datautstrekning og angivelse av datasettets beskrivelse.  I tillegg kan filhodet inneholde datasettets produsent, eier, prosesshistorie og lenke til andre datasettmetadata.	20
' --/krav/formatversjon	 UML modeller som realiseres i SOSI syntaks i henhold til denne versjonen av standarden skal ha SOSI-VERSJON 5.0.	24
' /krav/tegnsett	 Ved all utveksling av informasjon mellom statlige virksomheter og med innbyggere/ næringsliv skal tegnsettstandarden ISO/IEC representert ved UTF8 benyttes. Det aksepteres inntil videre en begrenset støtte av tegn. Tegnene som skal støttes er de som finnes i ISO 8859-1 supplert med ytterligere 6 nordsamiske tegn i store og små representasjoner (Č, č, Đ, đ, Ŋ, ŋ, Š, š, Ŧ, ŧ,  Ž, ž ). Kravene gjelder et begrenset tegnsett ved utveksling av informasjon. Det er en overgangsordning, som avventer en helhetlig innføring av ISO/IEC 10646, for å støtte alle tegn det er behov for å representere i offentlige virksomheter og utveksling mellom dem. (Forskrift om IT-standarder i offentlig sektor)	24
' /krav/koordinatsystem	 Koordinatsystemkoden skal være lik en av de nasjonale kodene i Tabell 6.19 Standardiserte koordinatsystemkoder.  Noen av disse har direkte mapping til internasjonalt kjente koder (EPSG-koder). Dersom koordinatene er i andre koordinatsystemer skal datasettet transformeres til et kjent system før utveksling.	29
' /krav/geokoord	For geografiske koordinater benyttes sekunder (buesekunder). For kartprojeksjonene benyttes meter.	30
' /krav/akserekkefølge	Rekkefølgen på aksene skal alltid være NØ, NØH (Nord-Øst-Høyde) eller NØD (Nord-Øst-Dybde) uansett hva akserekkefølgen i koordinatsystembeskrivelsen angir.	30
' /krav/høyderef	 Informasjon om høydereferansen skal alltid spesifiseres i SOSI-filen.	33
' *--/krav/produktnavn	Tagged value SOSI_kortnavn skal realiseres som første verdi under SOSI-elementnavnet ..OBJEKTKATALOG	43
' *--/krav/produktversjon	Tagged value version skal realiseres som andre verdi under SOSI-elementnavnet ..OBJEKTKATALOG	43
' ----/krav/stereotyper	Klasser uten stereotype og klasser med andre stereotyper enn de som er beskrevet i regler for UML-modellering skal ignoreres ved realisering i SOSI-format.	43
' --/krav/objekttype	Navn på objekttyper med stereotype «FeatureType» i UML-modellen er modellelementnavn som skal realiseres direkte som verdi på SOSI-elementnavn ..OBJTYPE	43
' *--/krav/objektegenskap	Navn på egenskaper i klasser med stereotype «FeatureType» er modellelementnavn som skal realiseres via verdien i en tagged value SOSI_navn som inneholder det SOSI-elementnavnet som skal benyttes. Applikasjonsskjema der objekttyper har egenskapene uten SOSI_navn skal ikke realiseres.	44
' *----/krav/objektegenskapstype	 Egenskaper der datatypen er en brukerdefinert klasse skal realiseres som SOSI-gruppeelement med innhold fra denne klassen. Egenskaper der typen er basistype skal realiseres som angitt SOSI basistype. Det er tillatt å angi lengde på elementverdien i SOSI-format, men man må likevel styre oppløsningen i mottagersystemet. Lengde på mantisse og eksponent for tall, og lengde på tekster er implementasjonsavhengige, men slike begrensninger skal ikke styre modellering eller begrense interoperabilitet. Se Tabell 8.1 Realisering av datatyper.	44
' Integer	realiseres som H, det anbefales å ta høyde for store heltall (H16)
' Real	realiseres som D, det anbefales å ta høyde for dobbel presisjon (D16.11)
' CharacterString	realiseres som T, det anbefales å ta høyde for variabel lengde på tekster
' DateTime	realiseres som DATOTID, som heltall med tilstrekkelig antall siffer for å ivareta de aktuelle krav til oppløsning, 14 siffer gir nærmeste sekund, 17 siffer gir mulighet for millisekund, etc.
' Date	realiseres som DATO, som heltall med 8 siffer til nærmeste dag
' Boolean	realiseres som BOOLSK, med verdi JA/NEI
' 
' /krav/tekst	 Egenskaper av type CharacterString der teksten inneholder skilletegn eller punktum eller utropstegn skal omsluttes av anførselstegn. Ellers vil disse delene kunne oppfattes som separate tekster eller SOSI-elementnavn eller kommentarer.	45
' --8.5/krav/geometriegenskap	 Egenskaper med datatype som er en av de angitte geometrityper skal realiseres som SOSI-format-toppobjekter via en fast definert mapping til geometrisentrerte SOSI-format-objekter der dette er mulig. Dersom det er flere påkrevde geometriegenskaper i en objekttype, eller en geometritype ikke kan mappes, skal applikasjonsskjemaet ikke realiseres i SOSI-format. Dersom objekttypen ikke inneholder noen egenskap med geometritype skal SOSI-format-toppobjektet settes til .OBJEKT.	46
' Punkt	.PUNKT	
' GM_Point	.PUNKT	
' Sverm	.SVERM	
' GM_MultiPoint	.SVERM	
' Kurve	.KURVE	alltid kun en kurve på samme sted
' GM_Curve	.KURVE 	alltid kun en kurve på samme sted
' GM_CompositeCurve	.KURVE 	alltid kun en kurve på samme sted
' Flate	.FLATE 	tilstøtende flater peker til samme kurve
' GM_Surface	.FLATE 	tilstøtende flater peker til samme kurve
' GM_CompositeSurface	.FLATE 	tilstøtende flater peker til samme kurve
' 
' *--8.5/krav/SOSIGeometri	 Geometri i SOSI format skal kun benytte realiseringer angitt i Tabell 8.2 Geometrityper.	46
' Punkt GM_Point Sverm GM_MultiPoint Kurve GM_Curve GM_CompositeCurve Flate GM_Surface	 GM_CompositeSurface
' 
' 8.5/krav/koordinatsystem	Alle koordinater i datafila skal være i samme koordinatsystem som det som er beskrevet i filhodet.	46
' 8.5/krav/akseenhetsfaktor	Koordinaters måleenhet for hver akse skal være den enheten som er beskrevet i koordinatsystembeskrivelsen multiplisert med konteinerens enhetsfaktor ..ENHET. Dersom enhet for høyde er ulik enhet for grunnriss skal ..ENHET-D eller ..ENHET-H benyttes på disse. Enhetsfaktoren skal ikke brukes på områdebeskrivelsen i filhodet.	46
' --8.5/krav/flateavgrensning	Objektyper med geometriegenskaper av type Flate eller GM_Surface skal enten benytte standardmekanisme for avgrensning ved å peke til et eget SOSI-format-objekt med objekttype Flateavgrensning, eller til et objekt av en type som er angitt i navnet til en restriksjon som starter med kanAvgrensesAv....	47
' *--/krav/objektrolle	Navn på assosiasjonsroller til objekttyper med stereotype «FeatureType» er modellelementnavn som skal realiseres via en tagged value SOSI_navn som inneholder det SOSI-elementnavnet som skal benyttes. Assosiasjonsroller til objekttyper der rollen er uten denne tagged value skal ignoreres ved realisering i SOSI-format.	47
' *--/krav/objektrolletype	Dersom klassen som rollen peker på er en objekttype skal SOSI-formattypen til assosiasjonsroller alltid være REF.	47
' /krav/objektrollemål	 Verdien til SOSI-elementer med SOSI-formattype REF skal være referanse til et serienummer for et reelt objekt som finnes i samme datafila og er av samme klasse som den rollen står til i modellen.	47
' --/krav/datatyperolle	Navn på assosiasjonsroller til klasser med stereotype «Union» eller «dataType» er modellelementnavn som skal realiseres direkte som SOSI gruppeelement, navn fra en tagged value SOSI_navn på rollen inneholder det SOSI-elementnavnet som skal benyttes.	48
' ---/krav/datatype	Modellelementet skal realiseres direkte via en tagged value SOSI_navn på egenskapen eller komposisjonsassisiasjonerollen som peker til datatypeklassen.  Egenskaper i datatypen skal realiseres på samme måte som objektegenskaper. Assosiasjonsroller i datatypen skal realiseres på samme måte som vanlige roller. Dersom egenskaper eller assosiasjonsroller i datatyper mangler en tagged value SOSI_navn skal applikasjonsskjemaet ikke realisering i SOSI-format.	49
' ---/krav/union	En klasse med stereotype «Union» beskriver et sett med mulige egenskaper. Kun en av egenskapene kan forekomme i hver instans. Modellelementet skal realiseres via et gruppeelement med navn som er tagged value SOSI_navn på den egenskapen som bruker unionen, og så med et element som inneholder kun SOSI_navn til det ene UML-elementnavnet som skal benyttes.	50
' /krav/enumerering	En klasse med stereotype «enumeration» beskriver et lukket sett med lovlige koder. Kun en av disse kodene kan forekomme i en instans. Modellelementet skal realiseres direkte via en tagged value SOSI_navn på egenskapen.	51
' /krav/kodeliste	En klasse med stereotype «CodeList» beskriver et åpent sett med lovlige koder. En av disse kodene kan forekomme i en instans, men andre lovlige koder kan også komme til seinere dersom kodelista er forvaltet i et register utenfor UML-modellen. Modellelementet skal realiseres direkte via en tagged value SOSI_navn på egenskapen.	51
' --/krav/kodenavn	 Elementer i klasser med stereotype «CodeList» eller «enumeration» beskriver lovlige koder. Modellelementet skal realiseres slik at koden benyttes direkte i datasettet. (Krav om NCName på koder). Dersom koden har en initialverdi skal denne initialverdien benyttes i datasettet istedenfor koden. Dersom det på koden finnes en tagged value SOSI_verdi som inneholder en verdi skal denne verdien benyttes i SOSI-format uansett. Dette kravet gjelder dersom kodelista mangler tagged value asDictionary eller verdien i denne tagged value er false.	52
' --/krav/koderegister	 Dersom kodelista er implementert i et register, angitt med tagged value asDictionary = true og med tagged value codeList med sti til registeret skal koden valideres mot verdier i det levende registeret. Registeret skal til enhver tid inneholde alle lovlige koder, og eventuelle initielle koder dokumentert i UML-modellen er da informative og skal ikke brukes til validering.	53
' 9.2/krav/pilhøyde	Hvis pilhøyden i en bue er mindre enn 2*enhet i datasettet skal det i stedet for geomatritype BUEP brukes geomtritype KURVE.	57
' 9.3/krav/Representasjonspunkt	FLATE skal ha et punkt. Dette er et representasjonspunkt for flaten. Representasjonspunktet skal ligge inne på flaten. FLATE kan ikke ha mer enn et punkt	59
' 9.3/krav/Geometri	Flater (polygoner) i SOSI formatet skal ha delt geometri.	59
' 9.3/krav/Flate 	Flater modellert som GM_Surface og/eller GM_CompositeSurface mappes til .FLATE	61
' 9.3/krav/Flateavgrensing	Der datamodellen er uten objekttyper med kurvegeometri skal flater referere til objekter med objekttype Flateavgrensning.	61
' 10/krav/nettverksassosiasjoner Assosiasjoner mellom nettverkselementer skal realiseres i form av assosiasjonsrollen og identifikasjon av det assosierte objektet.  ------------64
' --12/krav/posisjonskvalitet 	Dersom posisjonskvalitet skal angis benyttes egenskap kvalitet med datatype Posisjonskvalitet og SOSI-navn KVALITET.	66
' --13/krav/SOSI-Raster	 For modellering av «coverage» som skal realiseres i SOSI er det kun «RectifiedGridCoverage» med referanse til ekstern fil for selve verdiene som skal benyttes. Raster er en subtype av denne. Alle subtyper av <featureType> Raster mappes til SOSI elementet .RASTER.	74
' ---13/krav/rastermapping 	Realisering av et RectifiedGridCoverage modellert i UML til .RASTER skal benytte den «mappingen» som er vist i Tabell 12.3 UML egenskaper realisert i GML og SOSI format.	76
' 14/krav/tekstobjekt	Et objekt med egenskapen formatering skal mappes til .TEKST. Dersom geometrien er GM_Point (eller Punkt) vil objektpunktet oppfattes som tekstplasseringspunkt. Dersom geometrien er GM_Curve (eller Kurve) skal første punkt være objektpunkt, det neste punktet er teksplasseringspunkt. Teksten skal slynge seg når objektet har mer enn 3 punkter. Da skal teksten starte i punkt 2, og slynge seg langs punktene. Hvis den kurva som punktene danner er for kort, fortsetter teksten langs samme retning som kurvens avslutning.	80
' 
' 
' ANBEFALINGER
' /anbefaling/tekstformat	SOSI-formatet er et tekstformat og skal derfor ikke ha noe binærinnhold. SOSI-formatet åpner ikke for inkonsistens og skal derfor ikke inneholde alternative binære tegnsettidentifikatorer som for eksempel BOM (Byte Order Mark – ofte brukt til å angi tegnsett UTF-8 der formatet ikke har mulighet for tegnsettinformasjon)	20
' /anbefaling/rekkefølge	Det er anbefalt å følge den samme rekkefølgen på elementer innen samme grupperingsnivå som den som er i modellen. Dette vil lette brukens navigering og forståelse.	21
' /anbefaling/metadatalink	Link til datasettets metadatabeskrivelse bør være en stabil URI etter kravene i nasjonale URI-prinsipper.	27
' /anbefaling/harmoniserteKoordinatsystem	Det anbefales å bruke de internasjonalt mest kjente koordinatsystemkodene da disse direkte kan mappes til ved formatkonvertering. For formatkonvertering til GML med srsName i.h.h.t. Geodataloven og Inspire skal den nasjonale koden kunne mappes til riktig navneromssti for å få korrekt URI:   84 -> http://www.opengis.net/def/crs/EPSG/0/4258	30
' /anbefaling/eldreKoordinatsystem	 Eldre koordinatsystemer fra eldre versjoner av SOSI er ikke lenger anbefalt brukt i Norge. Historiske data med slike koordinatsystemer bør transformeres til et moderne system før datautveksling.	30
' ---krav---/anbefaling/høyderef	 Informasjon om høydereferansen bør alltid spesifiseres i SOSI-filen.	33
' /anbefaling/nøsteretning	Det anbefales at geometrien til ytre flateavgrensning nøstes i retning mot klokka, og indre avgrensinger i retning med klokka.	59
' /anbefaling/temporaleData 	Det anbefales å realisere temporale datatyper enten som tematisk basistype (DATO/DATOTID) eller som vanlige egenmodellerte datatyper.	65
' /anbefaling/bildesys	Det anbefales Anbefaler at SOSI-fila ligger i samme koordinatsystem som bilde. (Dvs SYSKODE i filhodet = BILDE-SYS).	72
' /anbefaling/referansemålestokk	Det anbefales på det sterkeste å bruke referansemålestokk for å uttrykke i hvilke brukstilfeller (målestokk) tekstobjektet skal uttrykkes.	81




'------------------------------------------------------------START-------------------------------------------------------------------------------------------
' Project Browser Script main function
'
sub OnProjectBrowserScript()
	
	Repository.EnsureOutputVisible("Script")
	' Get the type of element selected in the Project Browser
	dim treeSelectedType
	treeSelectedType = Repository.GetTreeSelectedItemType()
	
	' Handling Code: Uncomment any types you wish this script to support
	' NOTE: You can toggle comments on multiple lines that are currently
	' selected with [CTRL]+[SHIFT]+[C].
	select case treeSelectedType
	
'		case otElement
'			' Code for when an element is selected
'			dim theElement as EA.Element
'			set theElement = Repository.GetTreeSelectedObject()
'					
 		case otPackage 
 			' Code for when a package is selected 
 			dim thePackage as EA.Package 
 			set thePackage = Repository.GetTreeSelectedObject() 
 			
			if not thePackage.IsModel then
				'check if the selected package has stereotype applicationSchema 
 			
				if UCase(thePackage.element.stereotype) = UCase("ApplicationSchema") then 
				
					dim box, mess
					mess = "Indikerer om modellen kan realiseres etter standarden 'SOSI Realisering i SOSIformat versjon 5.0'"&Chr(13)&Chr(10)
					mess = mess + ""&Chr(13)&Chr(10)
					mess = mess + "En liste med kravene det testes for ligger i kildekoden (linje 15++)."&Chr(13)&Chr(10)
					mess = mess + ""&Chr(13)&Chr(10)
					mess = mess + "Starter validering av pakke [" & thePackage.Name &"]."&Chr(13)&Chr(10)

					box = Msgbox (mess, vbOKCancel, "realiserbarSOSIformat50 versjon 0.5-2021-11-17")
					select case box
						case vbOK
							dim logLevelFromInputBox, logLevelInputBoxText, correctInput, abort
							logLevelInputBoxText = "Velg loggnivå."&Chr(13)&Chr(10)
							logLevelInputBoxText = logLevelInputBoxText+ ""&Chr(13)&Chr(10)
							logLevelInputBoxText = logLevelInputBoxText+ ""&Chr(13)&Chr(10)
							logLevelInputBoxText = logLevelInputBoxText+ "E - Feil (Error): kun meldinger om direkte feil."&Chr(13)&Chr(10)
							logLevelInputBoxText = logLevelInputBoxText+ ""&Chr(13)&Chr(10)
							logLevelInputBoxText = logLevelInputBoxText+ "W - Advarsel (Warning): melder både feil og advarsler."&Chr(13)&Chr(10)
							logLevelInputBoxText = logLevelInputBoxText+ ""&Chr(13)&Chr(10)
							logLevelInputBoxText = logLevelInputBoxText+ "Angi E eller W:"&Chr(13)&Chr(10)
							correctInput = false
							abort = false
							do while not correctInput
						
								logLevelFromInputBox = InputBox(logLevelInputBoxText, "Velg loggnivå", "W")
								select case true 
									case UCase(logLevelFromInputBox) = "E"	
										globalLogLevelIsWarning = false
										correctInput = true
									case UCase(logLevelFromInputBox) = "W"	
										globalLogLevelIsWarning = true
										correctInput = true
									case UCase(logLevelFromInputBox) = "D"	
										globalLogLevelIsWarning = true
										debug = true
										correctInput = true
									case IsEmpty(logLevelFromInputBox)
										MsgBox "Abort",64
										abort = true
										exit do
									case else
										MsgBox "Du valgte et ukjent loggnivå, velg 'E' eller 'W'.",48
								end select
							
							loop
							

							if not abort then
								'give an initial feedback in system output 
								Session.Output("realiserbarSOSIformat50 versjon 0.5-2021-11-17 startet. "&Now())
								'Check model for script breaking structures
								if scriptBreakingStructuresInModel(thePackage) then
									Session.Output("Kritisk feil: Kan ikke validere struktur og innhold før denne feilen er rettet.")
									Session.Output("Aborterer skript.")
									exit sub
								else
									Session.Output("Rapporterer for pakke ["&thePackage.Name&"]") 		
								end if
							
							'	call populatePackageIDList(thePackage)
							'	call populateClassifierIDList(thePackage)
							'	call findPackageDependencies(thePackage.Element)
							'	call getElementIDsOfExternalReferencedElements(thePackage)
							'	call findPackagesToBeReferenced()
							'	call checkPackageDependency(thePackage)
							'	call dependencyLoop(thePackage.Element)
							  
                'For /req/Uml/Profile:
							  Set ProfileTypes = CreateObject("System.Collections.ArrayList")
							  Set ExtensionTypes = CreateObject("System.Collections.ArrayList")
							  Set CoreTypes = CreateObject("System.Collections.ArrayList")
							  reqUmlProfileLoad()
								'For /krav/18:
							'	set startPackage = thePackage
							'	Set diaoList = CreateObject( "System.Collections.Sortedlist" )
							'	Set diagList = CreateObject( "System.Collections.Sortedlist" )
							'	recListDiagramObjects(thePackage)

								Dim StartTime, EndTime, Elapsed
								StartTime = timer 
								startPackageName = thePackage.Name
								Session.Output("-----Start test av pakke ["&startPackageName&"]-----") 		
								
								FindInvalidElementsInASPackage(thePackage) 
								Elapsed = formatnumber((Timer - StartTime),2)

								'final report
								Session.Output("-----Rapport for pakke ["&startPackageName&"]-----") 		
								Session.Output("   Antall feil funnet: " & globalErrorCounter) 
								if globalLogLevelIsWarning then
									Session.Output("   Antall advarsler funnet: " & globalWarningCounter)
								end if	
								Session.Output("   Kjøretid: " &Elapsed& " sekunder" )
							end if	
						case VBcancel
							'nothing to do						
					end select 
				else 
 				Msgbox "Pakken [" & thePackage.Name &"] har ikke stereotype «ApplicationSchema». Velg en pakke med stereotype «ApplicationSchema»." 
				end if
			else
			Msgbox "Pakken [" & thePackage.Name &"] er en rotpakke og har ikke stereotype «ApplicationSchema». Velg en vanlig pakke med stereotype «ApplicationSchema»."
 			end if
'			
'		case otDiagram
'			' Code for when a diagram is selected
'			dim theDiagram as EA.Diagram
'			set theDiagram = Repository.GetTreeSelectedObject()
'			
'		case otAttribute
'			' Code for when an attribute is selected
'			dim theAttribute as EA.Attribute
'			set theAttribute = Repository.GetTreeSelectedObject()
'			
'		case otMethod
'			' Code for when a method is selected
'			dim theMethod as EA.Method
'			set theMethod = Repository.GetTreeSelectedObject()
		
		case else
			' Error message
			Session.Prompt "[Warning] You must select a package with stereotype ApplicationSchema in the Project Browser to start the validation.", promptOK 
			
	end select
	
end sub
'-------------------------------------------------------------END--------------------------------------------------------------------------------------------


'------------------------------------------------------------START-------------------------------------------------------------------------------------------
' Sub Name: FindInvalidElementsInASPackage
' Author: Kent Jonsrud
' Date: 2018-02-09
' Purpose: Test the content of the top level package

sub FindInvalidElementsInASPackage(package) 
			
	call kravProduktnavn(package)
	'call kravProduktforstavelse(package)
	'call kravProduktbeskrivelse(package)
	call kravProduktversjon(package)







	call FindInvalidElementsInPackage(package) 



end sub 
'-------------------------------------------------------------END--------------------------------------------------------------------------------------------

'------------------------------------------------------------START-------------------------------------------------------------------------------------------
' Sub Name: FindInvalidElementsInPackage
' Author: Kent Jonsrud
' Date: 2018-02-09
' Purpose: Main loop iterating all elements in selected package and all subpackages, conducting tests on their elements

sub FindInvalidElementsInPackage(package) 
			
 	dim elements as EA.Collection 
 	set elements = package.Elements 'collection of elements that belong to this package (classes, notes... BUT NO packages) 
 	Dim myDictionary 
 	dim errorsInFunctionTests 

	if debug then Session.Output("Debug: package to be tested: [«" &package.element.Stereotype& "» " &package.Name& "].")

	dim i 
	for i = 0 to elements.Count - 1 
		dim currentElement as EA.Element 
		set currentElement = elements.GetAt( i ) 
		if debug then Session.Output("Debug: class to be tested: [«" &currentElement.Stereotype& "» " &currentElement.Name& "].")

		if currentElement.Type = "Class" Or currentElement.Type = "Enumeration" Or currentElement.Type = "DataType" then 

			call kravObjekttype(currentElement)

			if UCase(currentElement.Stereotype) = "FEATURETYPE"  Or UCase(currentElement.Stereotype) = "DATATYPE" Or UCase(currentElement.Stereotype) = "UNION" or currentElement.Type = "DataType" then
				dim attributesCollection as EA.Collection 
				set attributesCollection = currentElement.Attributes 
				 
				if attributesCollection.Count > 0 then 
					dim n 
					for n = 0 to attributesCollection.Count - 1 					 
						dim currentAttribute as EA.Attribute		 
						set currentAttribute = attributesCollection.GetAt(n) 

						if debug then Session.Output("Debug: attribute to be tested: [«" &currentAttribute.Stereotype& "» " &currentAttribute.Name& "].")

						call kravObjektegenskap(currentAttribute)
						call kravObjektegenskapstype(currentAttribute)

					next
				end if
				if currentElement.Connectors.Count > 0 then
				 	dim conn as EA.Collection
					for each conn in currentElement.Connectors
						'TBD
						if conn.Type = "Generalization" or conn.Type = "Realisation" or conn.Type = "NoteLink" then
						else
							if debug then Session.Output("Debug: roles to be tested: [" &conn.ClientEnd.Role& "] and [" &conn.SupplierEnd.Role& "].")
							call kravObjektrolle(currentElement,conn)
						end if
					next
				end if
						'if debug then Session.Output("Debug: operation to be tested: [«" &operation.Stereotype& "» " &operation.Name& "].")
						'if debug then Session.Output("Debug: constraint to be tested: [«" &constraint.Stereotype& "» " &constraint.Name& "].")
			end if
			if UCase(currentElement.Stereotype) = "CODELIST"  Or UCase(currentElement.Stereotype) = "ENUMERATION" or currentElement.Type = "Enumeration" then
			end if
		end if
	next


	dim subP as EA.Package
	for each subP in package.packages
		call FindInvalidElementsInPackage(subP) 
	next




end sub 
'-------------------------------------------------------------END--------------------------------------------------------------------------------------------

'------------------------------------------------------------START-------------------------------------------------------------------------------------------
' Sub Name: kravProduktnavn
' Author: Kent Jonsrud
' Date: 2018-03-28
' Purpose: Test om tagged value SOSI_kortnavn finnes på pakka og om den har en gyldig verdi.

sub kravProduktnavn(package)

	if getPackageTaggedValue(package,"SOSI_kortnavn") = "" then
		Session.Output("Error: missing package tagged value SOSI_kortnavn. [/krav/produktnavn]")
 		globalErrorCounter = globalErrorCounter + 1 
	else
		if getPackageTaggedValue(package,"SOSI_kortnavn") <> getNCNameY(getPackageTaggedValue(package,"SOSI_kortnavn")) then 
			Session.Output("Error: package tagged value SOSI_kortnavn is not legal NCName: [" &getPackageTaggedValue(package,"SOSI_kortnavn")& "]. [/krav/produktnavn]")
			globalErrorCounter = globalErrorCounter + 1 
		end if
	end if
end sub
'-------------------------------------------------------------END--------------------------------------------------------------------------------------------


'------------------------------------------------------------START-------------------------------------------------------------------------------------------
' Sub Name: kravProduktforstavelse
' Author: Kent Jonsrud
' Date: 2018-02-09
' Purpose: Test om tagged value xmlns finnes i pakka og om den har en verdi. Info/advarsel dersom verdien ikke er app.

sub kravProduktforstavelse(package)
	dim forstavelse
	forstavelse = getPackageTaggedValue(package,"xmlns")
	if debug then Session.Output("Debug: package tagged value xmlns: " & forstavelse & " [«" &package.element.Stereotype& "» " &package.Name& "]. [/krav/produktforstavelse]")
	if len(forstavelse) = 0 then
			Session.Output("Error: missing package tagged value xmlns: [«" &package.element.Stereotype& "» " &package.Name& "]. [/krav/produktforstavelse]")
			globalErrorCounter = globalErrorCounter + 1
	end if
	if len(forstavelse) > 0 and forstavelse <> "app" and globalLogLevelIsWarning then
			Session.Output("Warning: package tagged value xmlns is not app but: " & forstavelse & " [«" &package.element.Stereotype& "» " &package.Name& "]. [/krav/produktforstavelse]")
			globalWarningCounter = globalWarningCounter + 1
	end if
end sub
'-------------------------------------------------------------END--------------------------------------------------------------------------------------------


'------------------------------------------------------------START-------------------------------------------------------------------------------------------
' Sub Name: kravProduktbeskrivelse
' Author: Kent Jonsrud
' Date: 2018-02-09
' Purpose: Test om tagged value targetNamespace finnes i pakka og om den har en gyldig uri som verdi.

sub kravProduktbeskrivelse(package)


end sub
'-------------------------------------------------------------END--------------------------------------------------------------------------------------------


'------------------------------------------------------------START-------------------------------------------------------------------------------------------
' Sub Name: kravProduktversjon
' Author: Kent Jonsrud
' Date: 2018-02-09
' Purpose: Test om tagged value targetNamespace finnes i pakka og om den har en gyldig uri som verdi.

sub kravProduktversjon(package)


end sub
'-------------------------------------------------------------END--------------------------------------------------------------------------------------------


'------------------------------------------------------------START-------------------------------------------------------------------------------------------
' Sub Name: kravObjekttype
' Author: Kent Jonsrud
' Date: 2018-02-09
' Purpose: Test om tagged value targetNamespace finnes i pakka og om den har en gyldig uri som verdi.

sub kravObjekttype(element)


end sub
'-------------------------------------------------------------END--------------------------------------------------------------------------------------------




'------------------------------------------------------------START-------------------------------------------------------------------------------------------
' Sub Name: kravObjektegenskap
' Author: Kent Jonsrud
' Date: 2018-03-28 / 2021-07-16
' Purpose: Test om egenskap har tagged value SOSI_navn med gyldig verdi. /krav/objektegenskap /krav/objektegenskapstype /krav/geometriegenskap /krav/SOSIGeometri

sub kravObjektegenskap(attr)
	Dim t
	if attr.ClassifierID <> 0 then
		if isElement(attr.ClassifierID) then
			dim datatype as EA.Element
			set datatype = Repository.GetElementByID(attr.ClassifierID)
			if datatype.Name <> attr.Type then
				Session.Output("Error: Class [«"&Repository.GetElementByID(attr.ParentID).Stereotype&"» "& Repository.GetElementByID(attr.ParentID).Name &"] attribute [" &attr.Name& "] has a type name ["&attr.Type&"] that is not corresponding to its linked type name ["&datatype.Name&"].")
			end if
			t = attr.Type
			if t="Punkt" or t="Kurve" or t="Flate" or t="Sverm" or t="GM_Point" or t="GM_Curve" or t="GM_Surface" or t="GM_MultiPoint" or t="GM_CompositeCurve" or t="GM_CompositeSurface" then
				' geometritypen er hovedobjektet i SOSI-format og trenger derfor ikke SOSI_navn (???)
			else
				if getTaggedValue(attr,"SOSI_navn") = "" then
					'Session.Output("Error: Attribute named [" & attr.Name & "] in class [«"&Repository.GetElementByID(attr.ParentID).Stereotype&"» "& Repository.GetElementByID(attr.ParentID).Name &"] missing tagged value SOSI_navn. [/krav/objektegenskap]")
					Session.Output("Error: Class [«"&Repository.GetElementByID(attr.ParentID).Stereotype&"» "& Repository.GetElementByID(attr.ParentID).Name &"] attribute [" & attr.Name & "] is missing tagged value SOSI_navn. [/krav/objektegenskap]")
					globalErrorCounter = globalErrorCounter + 1
				else
					if getTaggedValue(attr,"SOSI_navn") <> getNCNameY(getTaggedValue(attr,"SOSI_navn")) then
						Session.Output("Error: Class [«"&Repository.GetElementByID(attr.ParentID).Stereotype&"» "& Repository.GetElementByID(attr.ParentID).Name &"] attribute [" & attr.Name & "] tagged value SOSI_navn is not legal SOSI-name: [" &getTaggedValue(attr,"SOSI_navn")& "]. [/krav/objektegenskap]")
						globalErrorCounter = globalErrorCounter + 1
					end if
					if getTaggedValue(attr,"SOSI_navn") <> getTaggedValue(datatype,"SOSI_navn") and getTaggedValue(datatype,"SOSI_navn") <> "" and globalLogLevelIsWarning then
						Session.Output("Warning: Class [«"&Repository.GetElementByID(attr.ParentID).Stereotype&"» "& Repository.GetElementByID(attr.ParentID).Name &"] attribute [" & attr.Name & "] tagged value SOSI_navn [" &getTaggedValue(attr,"SOSI_navn")& "] is not same as SOSI-name on type: [" &getTaggedValue(datatype,"SOSI_navn")& "]. [/krav/objektegenskap]")
						globalWarningCounter = globalWarningCounter + 1
					end if
				end if
			end if
		else
			Session.Output("Error: Class [«"&Repository.GetElementByID(attr.ParentID).Stereotype&"» "& Repository.GetElementByID(attr.ParentID).Name &"] attribute [" &attr.Name& "] has a type name ["&attr.Type&"] but also a attr.ClassifierID with a ElementID that is not used! ["&attr.ClassifierID&"].")
		end if
	end if
end sub
'-------------------------------------------------------------END--------------------------------------------------------------------------------------------

'------------------------------------------------------------START-------------------------------------------------------------------------------------------
' Func Name: isElement
' Author: Kent Jonsrud
' Date: 2021-07-13
' Purpose: tester om det finnes et element med denne ID-en.

function isElement(ID)
	isElement = false
	if 	Mid(Repository.SQLQuery("select count(*) from t_object where Object_ID = " & ID & ";"), 113, 1) <> 0 then
		isElement = true
	end if
end function
'-------------------------------------------------------------END--------------------------------------------------------------------------------------------



'------------------------------------------------------------START-------------------------------------------------------------------------------------------
' Sub Name: kravObjektegenskapstype
' Author: Kent Jonsrud
' Date: 2018-03-27
' Purpose: Egenskapstyper skal være brukerdefinerte klasser eller kjente geometri- eller basistyper.

sub kravObjektegenskapstype(attr)
	'Iso 19109 Requirement /req/uml/profile - well known types. Including Iso 19103 Requirements 22 and 25
	if debug then Session.Output("Debug: datatype to be tested: [" &attr.Type& "].")
	if attr.ClassifierID <> 0 then
		if isElement(attr.ClassifierID) then
			dim datatype as EA.Element
			set datatype = Repository.GetElementByID(attr.ClassifierID)
			if datatype.Name <> attr.Type then
				Session.Output("Error: Class [«"&Repository.GetElementByID(attr.ParentID).Stereotype&"» "& Repository.GetElementByID(attr.ParentID).Name &"] attribute [" &attr.Name& "] has a type name ["&attr.Type&"] that is not corresponding to its linked type name ["&datatype.Name&"].")
				globalErrorCounter = globalErrorCounter + 1
			end if
		else
			Session.Output("Error: Class [«"&Repository.GetElementByID(attr.ParentID).Stereotype&"» "& Repository.GetElementByID(attr.ParentID).Name &"] attribute [" &attr.Name& "] has a type name ["&attr.Type&"] but also a attr.ClassifierID with a ElementID that is not used! ["&attr.ClassifierID&"].")
			globalErrorCounter = globalErrorCounter + 1
		end if
	else
		call reqUmlProfile(attr)
	end if
end sub
'-------------------------------------------------------------END--------------------------------------------------------------------------------------------



' -----------------------------------------------------------START-------------------------------------------------------------------------------------------
' Sub Name: reqUmlProfile
' Author: Kent Jonsrud
' Date: 2016-08-08, 2017-05-13, 2018-03-27
' Purpose: 
    'iso19109:2015 /req/uml/profile , includes iso109103:2015 requirement 25 and requirement 22.


sub reqUmlProfile(attr)
	
	'dim attr as EA.Attribute
	'navigate through all attributes 
	'for each attr in theElement.Attributes
		'if attr.ClassifierID = 0 then
			'Attribute not connected to a datatype class, check if the attribute has a iso TC 211 well known type
			if ProfileTypes.IndexOf(attr.Type,0) = -1 then	
				if ExtensionTypes.IndexOf(attr.Type,0) = -1 then	
					if CoreTypes.IndexOf(attr.Type,0) = -1 then	
						'Session.Output("Error: Class [«" &theElement.Stereotype& "» " &theElement.Name& "] has unknown type for attribute ["&attr.Name&" : "&attr.Type&"]. [/req/uml/profile] & krav/25 & krav/22")
						Session.Output("Error: Class [«"&Repository.GetElementByID(attr.ParentID).Stereotype&"» "& Repository.GetElementByID(attr.ParentID).Name &"] unknown type for attribute ["&attr.Name&" : "&attr.Type&"]. [/krav/objektegenskapstype & '/krav/SOSIGeometri]")
						globalErrorCounter = globalErrorCounter + 1 
					end if
				end if
			end if
		'end if 
	'next

end sub


sub reqUmlProfileLoad()
	
	'iso 19103:2015 Core types
	CoreTypes.Add "Date"
'	CoreTypes.Add "Time"
	CoreTypes.Add "DateTime"
	CoreTypes.Add "CharacterString"
'	CoreTypes.Add "Number"
'	CoreTypes.Add "Decimal"
	CoreTypes.Add "Integer"
	CoreTypes.Add "Real"
	CoreTypes.Add "Boolean"
	CoreTypes.Add "Vector"

	CoreTypes.Add "Bit"
	CoreTypes.Add "Digit"
	CoreTypes.Add "Sign"

	CoreTypes.Add "NameSpace"
	CoreTypes.Add "GenericName"
	CoreTypes.Add "LocalName"
	CoreTypes.Add "ScopedName"
	CoreTypes.Add "TypeName"
	CoreTypes.Add "MemberName"

	CoreTypes.Add "Any"

'	CoreTypes.Add "Record"
'	CoreTypes.Add "RecordType"
'	CoreTypes.Add "Field"
'	CoreTypes.Add "FieldType"
	
	'iso 19103:2015 Annex-C types
	'ExtensionTypes.Add "LanguageString"
	
	ExtensionTypes.Add "Anchor"
	ExtensionTypes.Add "FileName"
	ExtensionTypes.Add "MediaType"
	ExtensionTypes.Add "URI"
	
	ExtensionTypes.Add "UnitOfMeasure"
	ExtensionTypes.Add "UomArea"
	ExtensionTypes.Add "UomLenght"
	ExtensionTypes.Add "UomAngle"
	ExtensionTypes.Add "UomAcceleration"
	ExtensionTypes.Add "UomAngularAcceleration"
	ExtensionTypes.Add "UomAngularSpeed"
	ExtensionTypes.Add "UomSpeed"
	ExtensionTypes.Add "UomCurrency"
	ExtensionTypes.Add "UomVolume"
	ExtensionTypes.Add "UomTime"
	ExtensionTypes.Add "UomScale"
	ExtensionTypes.Add "UomWeight"
	ExtensionTypes.Add "UomVelocity"

	ExtensionTypes.Add "Measure"
	ExtensionTypes.Add "Length"
	ExtensionTypes.Add "Distance"
	ExtensionTypes.Add "Speed"
	ExtensionTypes.Add "Angle"
	ExtensionTypes.Add "Scale"
	ExtensionTypes.Add "TimeMeasure"
	ExtensionTypes.Add "Area"
	ExtensionTypes.Add "Volume"
	ExtensionTypes.Add "Currency"
	ExtensionTypes.Add "Weight"
	ExtensionTypes.Add "AngularSpeed"
	ExtensionTypes.Add "DirectedMeasure"
	ExtensionTypes.Add "Velocity"
	ExtensionTypes.Add "AngularVelocity"
	ExtensionTypes.Add "Acceleration"
	ExtensionTypes.Add "AngularAcceleration"
	
	'well known and often used spatial types from iso 19107:2003
'	ProfileTypes.Add "DirectPosition"
	ProfileTypes.Add "GM_Object"
	ProfileTypes.Add "GM_Primitive"
	ProfileTypes.Add "GM_Complex"
	ProfileTypes.Add "GM_Aggregate"
	ProfileTypes.Add "GM_Point"
	ProfileTypes.Add "GM_Curve"
	ProfileTypes.Add "GM_Surface"
	'ProfileTypes.Add "GM_Solid"
	ProfileTypes.Add "GM_MultiPoint"
	'ProfileTypes.Add "GM_MultiCurve"
	'ProfileTypes.Add "GM_MultiSurface"
	'ProfileTypes.Add "GM_MultiSolid"
'	ProfileTypes.Add "GM_CompositePoint"
	ProfileTypes.Add "GM_CompositeCurve"
	ProfileTypes.Add "GM_CompositeSurface"
	'ProfileTypes.Add "GM_CompositeSolid"
'	ProfileTypes.Add "TP_Object"
	'ProfileTypes.Add "TP_Primitive"
	'ProfileTypes.Add "TP_Complex"
	'ProfileTypes.Add "TP_Node"
	'ProfileTypes.Add "TP_Edge"
	'ProfileTypes.Add "TP_Face"
	'ProfileTypes.Add "TP_Solid"
	'ProfileTypes.Add "TP_DirectedNode"
	'ProfileTypes.Add "TP_DirectedEdge"
	'ProfileTypes.Add "TP_DirectedFace"
	'ProfileTypes.Add "TP_DirectedSolid"
	ProfileTypes.Add "GM_OrientableCurve"
	ProfileTypes.Add "GM_OrientableSurface"
	ProfileTypes.Add "GM_PolyhedralSurface"
	ProfileTypes.Add "GM_triangulatedSurface"
	ProfileTypes.Add "GM_Tin"

	'well known and often used coverage types from iso 19123:2007
	ProfileTypes.Add "CV_Coverage"
	ProfileTypes.Add "CV_DiscreteCoverage"
	ProfileTypes.Add "CV_DiscretePointCoverage"
	ProfileTypes.Add "CV_DiscreteGridPointCoverage"
	ProfileTypes.Add "CV_DiscreteCurveCoverage"
	ProfileTypes.Add "CV_DiscreteSurfaceCoverage"
	ProfileTypes.Add "CV_DiscreteSolidCoverage"
	ProfileTypes.Add "CV_ContinousCoverage"
	ProfileTypes.Add "CV_ThiessenPolygonCoverage"
	'ExtensionTypes.Add "CV_ContinousQuadrilateralGridCoverageCoverage"
	ProfileTypes.Add "CV_ContinousQuadrilateralGridCoverage"
	ProfileTypes.Add "CV_HexagonalGridCoverage"
	ProfileTypes.Add "CV_TINCoverage"
	ProfileTypes.Add "CV_SegmentedCurveCoverage"

	'well known and often used temporal types from iso 19108:2006/2002?
	ProfileTypes.Add "TM_Instant"
	ProfileTypes.Add "TM_Period"
	ProfileTypes.Add "TM_Node"
	ProfileTypes.Add "TM_Edge"
	ProfileTypes.Add "TM_TopologicalComplex"
	
	'well known and often used observation related types from OM_Observation in iso 19156:2011
	ProfileTypes.Add "TM_Object"
	ProfileTypes.Add "DQ_Element"
	ProfileTypes.Add "NamedValue"
	
	'well known and often used quality element types from iso 19157:2013
	ProfileTypes.Add "DQ_AbsoluteExternalPositionalAccurracy"
	ProfileTypes.Add "DQ_RelativeInternalPositionalAccuracy"
	ProfileTypes.Add "DQ_AccuracyOfATimeMeasurement"
	ProfileTypes.Add "DQ_TemporalConsistency"
	ProfileTypes.Add "DQ_TemporalValidity"
	ProfileTypes.Add "DQ_ThematicClassificationCorrectness"
	ProfileTypes.Add "DQ_NonQuantitativeAttributeCorrectness"
	ProfileTypes.Add "DQ_QuanatitativeAttributeAccuracy"

	'well known and often used metadata element types from iso 19115-1:200x and iso 19139:2x00x
	ProfileTypes.Add "PT_FreeText"
	ProfileTypes.Add "LocalisedCharacterString"
	ProfileTypes.Add "MD_Resolution"
	'ProfileTypes.Add "CI_Citation"
	'ProfileTypes.Add "CI_Date"

	'other less known Norwegian geometry types
	ProfileTypes.Add "Punkt"
	ProfileTypes.Add "Kurve"
	ProfileTypes.Add "Flate"
	ProfileTypes.Add "Sverm"


end sub
'-------------------------------------------------------------END--------------------------------------------------------------------------------------------


'------------------------------------------------------------START-------------------------------------------------------------------------------------------
' Sub Name: kravObjektrolle
' Author: Kent Jonsrud
' Date: 2021-07-16
' Purpose: Test om rolle har tagged value SOSI_navn med gyldig verdi.
'
' *--/krav/objektrolle	Navn på assosiasjonsroller til objekttyper med stereotype «FeatureType» er modellelementnavn som skal realiseres via en tagged value SOSI_navn som inneholder det SOSI-elementnavnet som skal benyttes. Assosiasjonsroller til objekttyper der rollen er uten denne tagged value skal ignoreres ved realisering i SOSI-format.	47
' /krav/objektrolletype	Dersom klassen som rollen peker på er en objekttype skal SOSI-formattypen til assosiasjonsroller alltid være REF.	47
' /krav/objektrollemål	 Verdien til SOSI-elementer med SOSI-formattype REF skal være referanse til et serienummer for et reelt objekt som finnes i samme datafila og er av samme klasse som den rollen står til i modellen.	47

sub kravObjektrolle(element,conn)

	if conn.ClientID = element.ElementID then
		if conn.SupplierEnd.Role <> "" then
			if getConnectorEndTaggedValue(conn.SupplierEnd,"SOSI_navn") = "" then
				Session.Output("Error: Class [«"&element.Stereotype&"» "& element.Name &"] role [" &conn.SupplierEnd.Role& "] has no tagged value SOSI_navn. [/krav/objektrolle]")
			end if

			if getConnectorEndTaggedValue(conn.SupplierEnd,"SOSI_datatype") <> "" then
				if getConnectorEndTaggedValue(conn.SupplierEnd,"SOSI_datatype") <> "REF" then
					Session.Output("Error: Class [«"&element.Stereotype&"» "& element.Name &"] role [" &conn.SupplierEnd.Role& "] has a tagged value SOSI_datatype that is not REF. [/krav/objektrolletype]")
				end if
			end if
		end if
		
	else
		if conn.ClientEnd.Role <> "" then
			if getConnectorEndTaggedValue(conn.ClientEnd,"SOSI_navn") = "" then
				Session.Output("Error: Class [«"&element.Stereotype&"» "& element.Name &"] role [" &conn.ClientEnd.Role& "] has no tagged value SOSI_navn. [/krav/objektrolle]")
			end if

			if getConnectorEndTaggedValue(conn.ClientEnd,"SOSI_datatype") <> "" then
				if getConnectorEndTaggedValue(conn.ClientEnd,"SOSI_datatype") <> "REF" then
					Session.Output("Error: Class [«"&element.Stereotype&"» "& element.Name &"] role [" &conn.ClientEnd.Role& "] has a tagged value SOSI_datatype that is not REF. [/krav/objektrolletype]")
				end if
			end if
		end if
	end if

end sub
'-------------------------------------------------------------END--------------------------------------------------------------------------------------------



'------------------------------------------------------------START-------------------------------------------------------------------------------------------
'Function name: scriptBreakingStructuresInModel
'Author: 		Åsmund Tjora
'Date: 			20170511 
'Purpose: 		Check that the model does not contain structures that will break script operations (e.g. cause infinite loops)
'Parameter: 	the package where the script runs
'Return value:	false if no script-breaking structures in model are found, true if parts of the model may break the script.
'Sub functions and subs:	inHeritanceLoop, inheritanceLoopCheck
function scriptBreakingStructuresInModel(thePackage)
	dim retVal
	retVal=false
	dim currentElement as EA.Element
	dim elements as EA.Collection
	
	'Package Dependency Loop Check
	set currentElement = thePackage.Element
'	Note:  Dependency loops will not cause script to hang
'	retVal=retVal or dependencyLoop(currentElement)
	
	'Inheritance Loop Check
	set elements = thePackage.elements
	dim i
	for i=0 to elements.Count-1
		set currentElement = elements.GetAt(i)
		if(currentElement.Type="Class") then
			retVal=retVal or inheritanceLoop(currentElement)
		end if
	next
	scriptBreakingStructuresInModel = retVal
end function

'Function name: dependencyLoop
'Author: 		Åsmund Tjora
'Date: 			20170511 
'Purpose: 		Check that dependency structure does not form loops.  Return true if no loops are found, return false if loops are found
'Parameter: 	Package element where check originates
'Return value:	false if no loops are found, true if loops are found.
function dependencyLoop(thePackageElement)
	dim retVal
	dim checkedPackagesList
	set checkedPackagesList = CreateObject("System.Collections.ArrayList")
	retVal=dependencyLoopCheck(thePackageElement, checkedPackagesList)
	if retVal then
		Session.Output("Error:  The dependency structure originating in [«" & thePackageElement.StereoType & "» " & thePackageElement.name & "] contains dependency loops [/req/uml/integration]")
		Session.Output("          See the list above for the packages that are part of a loop.")
		Session.Output("          Ignore this error for dependencies between packages outside the control of the current project.")
		globalErrorCounter = globalErrorCounter+1
	end if
	dependencyLoop = retVal
end function

function dependencyLoopCheck(thePackageElement, dependantCheckedPackagesList)
	dim retVal
	dim localRetVal
	dim dependee as EA.Element
	dim connector as EA.Connector
	
	' Generate a copy of the input list.  
	' The operations done on the list should not be visible by the dependant in order to avoid false positive when there are common dependees.
	dim checkedPackagesList
	set checkedPackagesList = CreateObject("System.Collections.ArrayList")
	dim ElementID
	for each ElementID in dependantCheckedPackagesList
		checkedPackagesList.Add(ElementID)
	next
	
	retVal=false
	checkedPackagesList.Add(thePackageElement.ElementID)
	for each connector in thePackageElement.Connectors
		localRetVal=false
		if connector.Type="Usage" or connector.Type="Package" or connector.Type="Dependency" then
			if thePackageElement.ElementID = connector.ClientID then
				set dependee = Repository.GetElementByID(connector.SupplierID)
				dim checkedPackageID
				for each checkedPackageID in checkedPackagesList
					if checkedPackageID = dependee.ElementID then localRetVal=true
				next
				if localRetVal then 
					Session.Output("         Package [«" & dependee.Stereotype & "» " & dependee.Name & "] is part of a dependency loop")
				else
					localRetVal=dependencyLoopCheck(dependee, checkedPackagesList)
				end if
				retVal=retVal or localRetVal
			end if
		end if
	next
	
	dependencyLoopCheck=retVal
end function


'Function name: inheritanceLoop
'Author: 		Åsmund Tjora
'Date: 			20170221 
'Purpose: 		Check that inheritance structure does not form loops.  Return true if no loops are found, return false if loops are found
'Parameter: 	Class element where check originates
'Return value:	false if no loops are found, true if loops are found.
function inheritanceLoop(theClass)
	dim retVal
	dim checkedClassesList
	set checkedClassesList = CreateObject("System.Collections.ArrayList")
	retVal=inheritanceLoopCheck(theClass, checkedClassesList)	
	if retVal then
		Session.Output("Error: Class hierarchy originating in [«" & theClass.Stereotype & "» "& theClass.Name & "] contains inheritance loops.")
	end if
	inheritanceLoop = retVal
end function

'Function name:	inheritanceLoopCheck
'Author:		Åsmund Tjora
'Date:			20170221
'Purpose		Internal workings of function inhertianceLoop.  Register the class ID, compare list of ID's with superclass ID, recursively call itself for superclass.  
'				Return "true" if class already has been registered (i.e. is a superclass of itself) 

function inheritanceLoopCheck(theClass, subCheckedClassesList)
	dim retVal
	dim superClass as EA.Element
	dim connector as EA.Connector

	' Generate a copy of the input list.  
	'The operations done on the list should not be visible by the subclass in order to avoid false positive at multiple inheritance
	dim checkedClassesList
	set checkedClassesList = CreateObject("System.Collections.ArrayList")
	dim ElementID
	for each ElementID in subCheckedClassesList
		checkedClassesList.Add(ElementID)
	next

	retVal=false
	checkedClassesList.Add(theClass.ElementID)	
	for each connector in theClass.Connectors
		if connector.Type = "Generalization" then
			if theClass.ElementID = connector.ClientID then
				set superClass = Repository.GetElementByID(connector.SupplierID)
				dim checkedClassID
				for each checkedClassID in checkedClassesList
					if checkedClassID = superClass.ElementID then retVal = true
				next
				if retVal then 
					Session.Output("Error: Class [«" & superClass.Stereotype & "» " & superClass.Name & "] is a generalization of itself")
				else
					retVal=inheritanceLoopCheck(superClass, checkedClassesList)
				end if
			end if
		end if
	next
	
	inheritanceLoopCheck = retVal
end function

'-------------------------------------------------------------END--------------------------------------------------------------------------------------------


function getTaggedValue(element,taggedValueName)
		dim i, existingTaggedValue
		getTaggedValue = ""
		for i = 0 to element.TaggedValues.Count - 1
			set existingTaggedValue = element.TaggedValues.GetAt(i)
			if existingTaggedValue.Name = taggedValueName then
				getTaggedValue = existingTaggedValue.Value
			end if
		next
end function

function getPackageTaggedValue(package,taggedValueName)
		dim i, existingTaggedValue
		getPackageTaggedValue = ""
		for i = 0 to package.element.TaggedValues.Count - 1
			set existingTaggedValue = package.element.TaggedValues.GetAt(i)
			if existingTaggedValue.Name = taggedValueName then
				getPackageTaggedValue = existingTaggedValue.Value
			end if
		next
end function

function getConnectorEndTaggedValue(connectorEnd,taggedValueName)
	getConnectorEndTaggedValue = ""
	if not connectorEnd is nothing and Len(taggedValueName) > 0 then
		dim existingTaggedValue as EA.RoleTag 
		dim i
		for i = 0 to connectorEnd.TaggedValues.Count - 1
			set existingTaggedValue = connectorEnd.TaggedValues.GetAt(i)
			if existingTaggedValue.Tag = taggedValueName then
				getConnectorEndTaggedValue = existingTaggedValue.Value
			end if 
		next
	end if 
end function 

function getNCNameY(str)
	' make name legal SOSI_kortnavn, (SOSI-Kontrolfil) (NC+ingen punktum)
	Dim txt, res, tegn, i, u
    u=0
		txt = Trim(str)
		res = ""
		'Repository.WriteOutput "Script", "New NCName: " & txt & " " & res,0

		' loop gjennom alle tegn
		For i = 1 To Len(txt)
		  ' blank, komma, !, ", #, $, %, &, ', (, ), *, +, /, :, ;, <, =, >, ?, @, [, \, ], ^, `, {, |, }, ~
		  ' (tatt med flere fnuttetyper, men hva med "."?) (‘'«»’)
		  tegn = Mid(txt,i,1)
		  if tegn = "." Then
			  'Repository.WriteOutput "Script", "Bad0 in SOSI-kontrollfil: " & tegn,0
			  u=1
		  Else
		  if tegn = " " or tegn = "," or tegn = """" or tegn = "#" or tegn = "$" or tegn = "%" or tegn = "&" or tegn = "(" or tegn = ")" or tegn = "*" Then
			  'Repository.WriteOutput "Script", "Bad1: " & tegn,0
			  u=1
		  Else
		    if tegn = "+" or tegn = "/" or tegn = ":" or tegn = ";" or tegn = "<" or tegn = ">" or tegn = "?" or tegn = "@" or tegn = "[" or tegn = "\" Then
			    'Repository.WriteOutput "Script", "Bad2: " & tegn,0
			    u=1
		    Else
		      If tegn = "]" or tegn = "^" or tegn = "`" or tegn = "{" or tegn = "|" or tegn = "}" or tegn = "~" or tegn = "'" or tegn = "´" or tegn = "¨" Then
			      'Repository.WriteOutput "Script", "Bad3: " & tegn,0
			      u=1
		      else
			      'Repository.WriteOutput "Script", "Good: " & tegn,0
			      If u = 1 Then
		          res = res + UCase(tegn)
		          u=0
			      else
		          res = res + tegn
		        End If
		      End If
		    End If
		  End If
		  End If
		Next
		' return res
		getNCNameY = res

End function


'global variables 
dim globalLogLevelIsWarning 'boolean variable indicating if warning log level has been choosen or not
globalLogLevelIsWarning = true 'default setting for warning log level is true
 
dim startClass as EA.Element  'the class which is the starting point for searching for multiple inheritance in the findMultipleInheritance subroutine 
dim loopCounterMultipleInheritance 'integer value counting number of loops while searching for multiple inheritance
dim foundHoveddiagram 'boolean to check if a diagram named Hoveddiagram is found. If found, foundHoveddiagram = true  
foundHoveddiagram = false 
dim numberOfHoveddiagram 'number of diagrams named Hoveddiagram
numberOfHoveddiagram = 0
dim numberOfHoveddiagramWithAdditionalInformationInTheName 'number of diagrams with a name starting with Hoveddiagram and including additional characters  
numberOfHoveddiagramWithAdditionalInformationInTheName = 0
dim globalErrorCounter 'counter for number of errors 
globalErrorCounter = 0 
dim globalWarningCounter
globalWarningCounter = 0
dim startPackageName
dim debug
debug = false

'List of well known type names defined in iso 19109:2015
dim ProfileTypes
'List of well known extension type names defined in iso 19103:2015
dim ExtensionTypes
'List of well known core type names defined in iso 19103:2015
dim CoreTypes

OnProjectBrowserScript
