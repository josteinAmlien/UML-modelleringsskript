Option Explicit

!INC Local Scripts.EAConstants-VBScript

' Script Name: listAdocFraModell
' Author: Tore Johnsen, Åsmund Tjora
' Purpose: Generate documentation in AsciiDoc syntax
' Original Date: 08.04.2021
'
' Version: 0.30 Date: 2022-07-04 Jostein Amlien: Lempa på rekkefølgekrav i hovedrutina, lagt til flere rutiner for Asciidoc-syntaks, formattert tekst og output, refaktorert Sub Relasjoner
' Version: 0.29 Date: 2022-06-17 Jostein Amlien: Definert og tatt i bruk noen enkle funksjoner for Asciidoc-syntaks
' Version: 0.28 Date: 2022-06-10 Kent Jonsrud: dersom diagrammer har beskrivelse så legges denne inn i alt=
' Version: 0.27 Date: 2022-01-17 Kent Jonsrud: endra Alt= til alt= på alternative bildetekster
' Version: 0.26 Date: 2021-12-15 Kent Jonsrud: retting av småfeil etter forrige retting
' Version: 0.25 Date: 2021-12-14 Kent Jonsrud: skille ocl fra beskrivelse med linjeskift før --, og komma fjernes kun fra bildetekst
' Version: 0.24 Date: 2021-12-09 Kent Jonsrud: AS på 2. nivå (===), FT og UP på nivåer under ned til 5. nivå (=====), tilpasset :toclevel: 4 og [discrete]
' Version: 0.23 Date: 2021-12-08 Kent Jonsrud: AS på 3. nivå, FT og UP på samme nivå under (kan justeres på linje ca. 200)
' Version: 0.22 Date: 2021-12-07 Kent Jonsrud: linjeskift i noter endres ikke lenger til blanke
' Version: 0.21 Date: 2021-11-25 Kent Jonsrud: endra nøsting til å nøste kun fire nivå ned (AS(FT og UP(FT og UP og UP::FT og (UP/)UP2::FT etc.)))
' Version: 0.20 Date: 2021-11-15 Kent Jonsrud: endra på Alt= , dobbeltparenteser, kun en lenke til ekstern kodeliste, nøsting av underpakker
' Version: 0.19 Date: 2021-10-05 Kent Jonsrud: satt inn Alt= i alle image:
' Version: 0.18 Date: 2021-09-28 Kent Jonsrud: bytta til eksplisitt skillelinje ("'''") og rydda vekk død kode
' Version: 0.17 Date: 2021-09-28 Kent Jonsrud: tatt bort eksplisitt nummerering av figurer
' Version: 0.16 Date: 2021-09-21 Kent Jonsrud: flyttet supertypen til slutt og laget hyperlinker til subtypene
' Version: 0.15 Date: 2021-09-17 Kent Jonsrud: smårettinger
' Version: 0.14 Date: 2021-09-16 Tore Johnsen/Kent Jonsrud: hyperlenker til egenskapenes typer innenfor modellen og absolutte lenker til basistyper
' Version: 0.13 Date: 2021-09-10 Kent Jonsrud: smårettinger
' Version: 0.12 Date: 2021-09-09 Kent Jonsrud: smårettinger, bedre angivelse av skille mellom klassene
' Version: 0.11 Date: 2021-09-05 Kent Jonsrud: Assosiasjonsnavn, ikke hente eksterne koder, sideskift for pakker i pdf
' Version: 0.10 Date: 2021-08-10 Kent Jonsrud: forbedra ledetekster
' Version: 0.9 Date: 2021-08-08 Kent Jonsrud: skriver ut navn og beskrivelse på alle operasjoner på objekttyper og datatyper
' Version: 0.8 Date: 2021-08-06 Kent Jonsrud: skriver ut alle restriksjoner på objekttyper og datatyper
' Version: 0.7 Date: 2021-07-08 Kent Jonsrud: retta en feil ved utskrift av roller
' Version: 0.6 Date: 2021-06-30 Kent Jonsrud: leser kodelister fra levende register
' Version: 0.5 Date: 2021-06-29 Kent Jonsrud: error if role list is not shown
' Date: 2021-06-24 Kent Jonsrud: endra skriptnavn fra AdocTest til listAdocFraModell
' Version: 0.4 Date: 2021-06-14 Kent Jonsrud: case-insensitiv test på navnet på tagged value SOSI_bildeAvModellelement
' Version: 0.3 Date: 2021-06-01 Kent Jonsrud: retta bildesti til app_img
' Version: 0.2 Date: 2021-04-16 Kent Jonsrud: tagged value SOSI_bildeAvModellelement på pakker og klasser: verdien vises som ekstern sti til bilde
' Date: 2021-04-15 Kent Jonsrud: diagrammer legges i underkatalog med navn enten verdien i tagged value SOSI_kortnavn eller img.
' Date: 2021-04-09/14 Kent Jonsrud:  - tagged value lists come right after definition, on packages and classes - "Spesialisering av" changed to Supertype, no list of subtypes shown
' - removed formatting in notes, except CRLF - show stereotype on attribute "Type" if present - roles shall have same simple look and structure as attributes
' - Relasjoner changed to Roller, show only ends with role names (and navigable ?) - tagged values on CodeList classes, empty tags suppressed (suppress only those from the standard profile?), heading?
' - simpler list for codelists with more than 1 code, three-column list when Defaults are used (Utvekslingsalias)
'
' TBD: tagged values on roles
' TBD: fjerne komma og sette inn - for blanke i diagrammnavn for enklere_filnavn.png ?
' TBD: show stereotype on Type DONE
' TBD: show abstract on Type 
' TBD: show navigable 
' TBD: show association type 
' TBD: output operations and constraints right after attributes and roles DONE
' TBD: codes with tagged values
' TBD: output info on associations if present
' TBD: Hva med tagged values på koder?
' TBD: if tV SOSI_bildeAvModellelement (på koder og egenskaper) -> Session.Output("image::"& tV &".png["& tV &"]")
' TBD: special handling of classes that have tV with names like FKB-A etc. and are subtypes of feature types
' TBD: write adoc and diagram files to a subfolder, ensure utf-8 in adoc (no &#229)
'		==== «dataType» Matrikkelenhetreferanse
'		Definisjon: Mulighet for &#229; koble matrikkelenhet til objekt i SSR for &#229; oppdatere bruksnavn i matrikkelen.
' TBD: opprydding !!!
'
Dim imgfolder, imgparent
''Dim diagCounter,figurcounter
Dim imgFSO
'
' Project Browser Script main function
Sub OnProjectBrowserScript()

	Dim treeSelectedType
	treeSelectedType = Repository.GetTreeSelectedItemType()

	Select Case treeSelectedType

		Case otPackage
			Repository.EnsureOutputVisible "Script"
			Repository.ClearOutput "Script"
			' Code for when a package is selected
''			diagCounter = 0
''			figurcounter = 0
			Dim innrykk, nivaa
			Dim thePackage As EA.Package
			set thePackage = Repository.GetTreeSelectedObject()
			imgfolder = "diagrammer"
			Set imgFSO=CreateObject("Scripting.FileSystemObject")
			imgparent = imgFSO.GetParentFolderName(Repository.ConnectionString())  & "\" & imgfolder
			if not imgFSO.FolderExists(imgparent) then
				imgFSO.CreateFolder imgparent
			end if
			Session.Output("// Start of UML-model")
			innrykk = "==="
			nivaa = 2
			Call ListAsciiDoc(innrykk,thePackage)
			Session.Output("// End of UML-model")
		Case Else
			' Error message
			Session.Prompt "This script does not support items of this type.", promptOK

	End Select
	Set imgFSO = Nothing
End Sub


Sub ListAsciiDoc(innrykk,thePackage)

	Dim element As EA.Element
	dim tag as EA.TaggedValue
	Dim diag As EA.Diagram
	Dim projectclass As EA.Project
	set projectclass = Repository.GetProjectInterface()
	Dim listTags, innrykkLokal, bilde, bildetekst, alternativbildetekst
	dim overskrift, diagramfil
		
	if thePackage.Element.Stereotype <> "" then
		overskrift = "Pakke: " & tekstformatStereotype(thePackage.Element.Stereotype) & thePackage.Name
	else
		Call skrivTekst(adocPageBreak())
		Call skrivTekst(adocBreak())
		if innrykk = "=====" then
			overskrift = "Underpakke: " & thePackage.Name
		else
			overskrift = "Pakke: " & thePackage.Name
		end if

	end if
	Call skrivTekst(adocOverskrift( innrykk, overskrift) )
	Call skrivTekst(adocDefinisjonsAvsnitt(  thePackage) )

	dim tabellOverskrift, tabell
	tabellOverskrift = adocStorDiskretOverskrift(innrykk, "Profilparametre i tagged values")
	tabell = adocTabellstart("20,80", tabellOverskrift)
	listTags = false
	for each tag in thePackage.element.TaggedValues
		if tag.Value = "" then	
		elseif tag.Name = "persistence" or tag.Name = "SOSI_melding" then
		else
			tabell = appendArray( tabell, adocTabellRad( tag.Name, tag.Value) )
			listTags = true
		end if
	next
	if listTags then
		call skrivTabell( tabell)
	end if

'-----------------Diagram-----------------

	for each tag in thePackage.element.TaggedValues
		if LCase(tag.Name) = "sosi_bildeavmodellelement" and tag.Value <> "" then
	'	if getPackageTaggedValue("SOSI_bildeAvModellelement") <> "" then
			bilde = getPackageTaggedValue(thePackage,"SOSI_bildeAvModellelement") 
			
			if getPackageTaggedValue(thePackage,"SOSI_bildetekst") <> "" then 
				bildetekst = getPackageTaggedValue(thePackage,"SOSI_bildetekst")
			else
				bildetekst = "Illustrasjon av pakke " & thePackage.Name & ""
			end if
			
			if getPackageTaggedValue(thePackage,"SOSI_alternativbildetekst") <> "" then 
				alternativbildetekst = getPackageTaggedValue(thePackage, "SOSI_alternativbildetekst")
			else
				alternativbildetekst = "Bildet viser en illustrasjon av innholdet i UML-pakken " & thePackage.Name & ". Alle detaljene kommer i teksten nedenfor."
			end if
			
			call skrivTekst(adocBildeTekst(bildetekst, bilde, alternativbildetekst) )
			call skrivTekst(adocAvsnittSkille( ))
		end if
	next
	
	For Each diag In thePackage.Diagrams
''''		diagCounter = diagCounter + 1
		Call projectclass.PutDiagramImageToFile(diag.DiagramGUID, imgparent & "\" & diag.Name & ".png", 1)
		Repository.CloseDiagram(diag.DiagramID)
		call skrivTekst(adocAvsnittSkille( ))
		call skrivTekst(adocBreak())
		call skrivTekst(adocAvsnittSkille( ))

		if diag.Notes <> "" then
			alternativbildetekst = diag.Notes
		else
			alternativbildetekst = "Diagram med navn " & diag.Name & " som viser UML-klasser beskrevet i teksten nedenfor."
		end if
		
		diagramFil = imgfolder & "\" & diag.Name & ".png"
		call skrivTekst(adocBildeTekst(diag.Name, diagramFil, alternativbildetekst) )
	Next

'-----------------Elementer----------------- 
	dim uppStereo
	For each element in thePackage.Elements
		If Ucase(element.Stereotype) = "FEATURETYPE" OR Ucase(element.Stereotype) = "DATATYPE" OR Ucase(element.Stereotype) = "UNION"  Then
			Call ObjektOgDatatyper(innrykk,element,thePackage)
		End If

		If Ucase(element.Stereotype) = "CODELIST" OR Ucase(element.Stereotype) = "ENUMERATION" OR element.Type = "Enumeration" Then
			Call Kodelister(innrykk,element,thePackage)
		End if
	Next

'----------------- Underpakker ----------------- 

'	ALT 1 Underpakker flatt på samme nivå som Application Schema
'	innrykkLokal = innrykk

'	ALT 2 Nøsting av pakker ned til nivå 4 under Application Schema
	if innrykk = "=====" then 
		innrykkLokal = "====="
	else
		innrykkLokal = innrykk & "="
	end if

'	ALT 3 TBD Nøsting helt ned med utskrift av Pakke::Klasse (Pakke/Pakke2::Klasse TBD)
'	innrykkLokal = innrykk & "="

	dim pack as EA.Package
	for each pack in thePackage.Packages
		Call ListAsciiDoc(innrykkLokal,pack)
	next

'	Set imgFSO = Nothing
end sub

'-----------------ObjektOgDatatyper-----------------
Sub ObjektOgDatatyper(innrykk,element,pakke)
	Dim att As EA.Attribute
	dim tag as EA.TaggedValue
	Dim con As EA.Connector
	Dim supplier As EA.Element
	Dim client As EA.Element
	Dim association
	Dim aggregation
	association = False
 
	Dim numberSpecializations, numberGeneralizations, numberRealisations, elementnavn

	Dim textVar, bilde, bildetekst, alternativbildetekst
	dim externalPackage
	Dim listTags
	dim typ, elementOverskrift

	call skrivTekst(adocAvsnittSkille( ))
	call skrivTekst(adocBreak())
	
	call skrivTekst(adocAvsnittSkille( ))

	call skrivTekst(adocBokmerke(element))
	elementnavn = stereotypeNavn(element) 

	if element.Abstract = 1 then
		elementnavn = adocKursiv( elementnavn & " (abstrakt)" )    '''' NYTT: gjort abstracte klasser kursiv
	end if
	if innrykk = "=====" then
		elementOverskrift = adocOverskrift(innrykk, pakke.Name & "::" & elementnavn)
	else
		elementOverskrift = adocOverskrift(innrykk & "=", elementnavn) 
	end if
	call skrivTekst(elementOverskrift)
	Call skrivTekst(adocDefinisjonsAvsnitt( element) )
	call skrivTekst(adocAvsnittSkille( ))

	dim tabellOverskrift, tabell
	tabellOverskrift = adocDiskretOverskrift(innrykk, "Profilparametre i tagged values")
	tabell = adocTabellstart("20,80", tabellOverskrift)
	listTags = false
	for each tag in element.TaggedValues
		if tag.Value = "" then	
		elseif tag.Name = "persistence" or tag.Name = "SOSI_melding" or LCase(tag.Name) = "sosi_bildeavmodellelement" then
		else
			tabell = appendArray( tabell, adocTabellRad( tag.Name, tag.Value) )
			listTags = true
		end if
	next
	if listTags then call skrivTabell( tabell)

	
	for each tag in element.TaggedValues								
		if LCase(tag.Name) = "sosi_bildeavmodellelement" and tag.Value <> "" then
''''			diagCounter = diagCounter + 1
			bilde = getTaggedValue(element, "SOSI_bildeAvModellelement") 
			
			if getTaggedValue(element, "SOSI_bildetekst") <> "" then 
				bildetekst = getTaggedValue(element,"SOSI_bildetekst")
			else
				bildetekst = "Illustrasjon av objekttype " & element.Name & ""
			end if
			
			if getTaggedValue(element,"SOSI_alternativbildetekst") <> "" then 
				alternativbildetekst = getTaggedValue(element, "SOSI_alternativbildetekst")
			else
'''				alternativbildetekst = "Bilde av et eksempel på objekttypen " & element.Name & ", eventuelt med påtegning av streker som viser hvor geometrien til objektet skal måles fra."
				alternativbildetekst = "Bilde av et eksempel på objekttypen " & element.Name  '''' Tatt bort formuleringen om påtegning
			end if
			
			call skrivTekst(adocAvsnittSkille( ))
			call skrivTekst(adocBreak())
			call skrivTekst(adocBildeTekst(bildetekst, bilde, alternativbildetekst) )
			
		end if
	next


	dim egenskapsOverskrift 
	egenskapsOverskrift = adocDiskretOverskrift(innrykk, "Egenskaper")
''	if element.Attributes.Count > 0 then
''		call skrivTekst(  adocDiskretOverskrift(innrykk, "Egenskaper") )
		for each att in element.Attributes
			tabell = adocTabellstart("20,80", egenskapsOverskrift)
			
			tabell = appendArray( tabell, adocTabellOverskrift( "Navn:", att.Name) )
			tabell = appendArray( tabell, adocTabellRad( "Definisjon:", getCleanDefinition(att.Notes)) )
			tabell = appendArray( tabell, adocTabellRad( "Multiplisitet:", bounds(att)) )
			if not att.Default = "" then
				tabell = appendArray( tabell, adocTabellRad( "Initialverdi:", att.Default) )
			end if
			if not att.Visibility = "Public" then
				tabell = appendArray( tabell, adocTabellRad( "Visibilitet:", att.Visibility) )
			end if
			
			if att.ClassifierID <> 0 then
				if isElement(att.ClassifierID) then
					dim stereo
					stereo = Repository.GetElementByID(att.ClassifierID).Stereotype
''					if stereo = "" then
''						typ = adocLink( att.Type, att.Type )
''					else
						typ = adocLink( att.Type, tekstformatStereotype(stereo) & att.Type )
''					end if
				else
					typ = att.Type
				end if
			else
				typ = "http://skjema.geonorge.no/SOSI/basistype/" & att.Type & "[" & att.Type & "]"		''' adoc-syntaks for en link
			end if
			tabell = appendArray( tabell, adocTabellRad( "Type:", typ) )

			if att.TaggedValues.Count > 0 then
				tabell = appendArray( tabell, adocTabellRad( "Profilparametre i tagged values: ", "") )
				for each tag in att.TaggedValues
					tabell = appendArray( tabell, tag.Name& ": "&tag.Value & adocLinjeskift() )
				next
			end if
			
			call skrivTabell( tabell)
			egenskapsOverskrift = ""			
		next
''	end if


	call Relasjoner(innrykk,element)

	if element.Methods.Count > 0 then
		call Operasjoner(innrykk,element)
	end if

	if element.Constraints.Count > 0 then
		call Restriksjoner(innrykk,element)
	end if


''''''''''''
''	dim tabellOverskrift, tabell
	tabellOverskrift = adocDiskretOverskrift(innrykk, "Arv og realiseringer")
	tabell = adocTabellstart("20,80", tabellOverskrift)
	listTags = false   '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' Supertype
	numberSpecializations = 0
	For Each con In element.Connectors
		set supplier = Repository.GetElementByID(con.SupplierID)
		If con.Type = "Generalization" And supplier.ElementID <> element.ElementID Then
			numberSpecializations = numberSpecializations + 1
			tabell = appendArray( tabell, adocTabellRad("Supertype: ", targetLink(supplier)) )
			tabell = appendArray( tabell, adocAvsnittSkille( ))
		End If
	Next

' Spesialiseringer av klassen
	numberGeneralizations = 0
	For Each con In element.Connectors
		If con.Type = "Generalization" Then
			set supplier = Repository.GetElementByID(con.SupplierID)
			set client = Repository.GetElementByID(con.ClientID)
			If supplier.ElementID = element.ElementID then 'dette er en generalisering
				If numberGeneralizations = 0 Then
					tabell = appendArray( tabell, adocTabellRad("Subtyper:", "") )
				End If
				tabell = appendArray( tabell, targetLink(client) & adocLinjeskift() )
				numberGeneralizations = numberGeneralizations + 1
			End If
		End If
	Next

	For Each con In element.Connectors  
		numberRealisations = 0
'Må forbedres i framtidige versjoner dersom denne skal med 
'- full sti (opp til applicationSchema eller øverste pakke under "Model") til pakke som inneholder klassen som realiseres
		set supplier = Repository.GetElementByID(con.SupplierID)
		If con.Type = "Realisation" And supplier.ElementID <> element.ElementID Then
			set externalPackage = Repository.GetPackageByID(supplier.PackageID)
			textVar=getPath(externalPackage)
			if numberRealisations = 0 Then
				tabell = appendArray( tabell, adocTabellRad("Realisering av: ", "") )
				numberRealisations = numberRealisations + 1
			end if
			tabell = appendArray( tabell, textVar & "::" & stereotypeNavn(supplier) & adocLinjeskift())
			tabell = appendArray( tabell, adocAvsnittSkille( ))
			numberRealisations = numberRealisations + 1
		end if
	next

	if numberSpecializations = 0 and numberGeneralizations = 0 and numberRealisations = 0 then
	else
		call skrivTekst(adocAvsnittSkille( ))
		call skrivTabell( tabell)
	end if
''''''''''''''''''
exit sub
' Supertype
	numberSpecializations = 0
	For Each con In element.Connectors
		set supplier = Repository.GetElementByID(con.SupplierID)
		If con.Type = "Generalization" And supplier.ElementID <> element.ElementID Then
			if numberSpecializations = 0 then
				call skrivTekst(adocAvsnittSkille( ))
				Call skrivTekst(  adocDiskretOverskrift(innrykk, "Arv og realiseringer"))
				Call skrivTekst( adocTabellstart("20,80") )
			end if
			numberSpecializations = numberSpecializations + 1
			call skrivTekst(adocTabellRad("Supertype: ", targetLink(supplier)) )
			call skrivTekst(adocAvsnittSkille( ))
		End If
	Next



' Spesialiseringer av klassen
	numberGeneralizations = 0
	For Each con In element.Connectors
		If con.Type = "Generalization" Then
			set supplier = Repository.GetElementByID(con.SupplierID)
			set client = Repository.GetElementByID(con.ClientID)
			If supplier.ElementID = element.ElementID then 'dette er en generalisering
				if numberSpecializations = 0 and numberGeneralizations = 0 then
					call skrivTekst(adocAvsnittSkille( ))
					call skrivTekst(  adocDiskretOverskrift(innrykk, "Arv og realiseringer"))
					Call skrivTekst( adocTabellstart("20,80") )
				end if		
				If numberGeneralizations = 0 Then
					call skrivTekst(adocTabellRad("Subtyper:", "") )
				End If
				call skrivTekst(targetLink(client) & adocLinjeskift() )
				numberGeneralizations = numberGeneralizations + 1
			End If
		End If
	Next

	For Each con In element.Connectors  
		numberRealisations = 0
'Må forbedres i framtidige versjoner dersom denne skal med 
'- full sti (opp til applicationSchema eller øverste pakke under "Model") til pakke som inneholder klassen som realiseres
		set supplier = Repository.GetElementByID(con.SupplierID)
		If con.Type = "Realisation" And supplier.ElementID <> element.ElementID Then
			if numberSpecializations = 0 and numberGeneralizations = 0 and numberRealisations = 0 then
				call skrivTekst(  adocDiskretOverskrift(innrykk, "Arv og realiseringer") )
				Call skrivTekst( adocTabellstart("20,80") )
			end if		
			set externalPackage = Repository.GetPackageByID(supplier.PackageID)
			textVar=getPath(externalPackage)
			if numberRealisations = 0 Then
				call skrivTekst(adocTabellRad("Realisering av: ", "") )
				numberRealisations = numberRealisations + 1
			end if
			call skrivTekst( textVar & "::" & stereotypeNavn(supplier) & adocLinjeskift())
			call skrivTekst(adocAvsnittSkille( ))
			numberRealisations = numberRealisations + 1
		end if
	next

	If numberSpecializations + numberGeneralizations + numberRealisations > 0 then
		call adocAvsluttTabell
	End If

End sub
'-----------------ObjektOgDatatyper End-----------------


'-----------------CodeList-----------------
Sub Kodelister(innrykk,element,pakke)
	Dim att As EA.Attribute
	dim tag as EA.TaggedValue
	dim utvekslingsalias, codeListUrl, asdict, elementnavn, attDef
	asdict = false
	call skrivTekst(adocAvsnittSkille( ))
	call skrivTekst(adocBreak())
	 
	call skrivTekst(adocAvsnittSkille( ))
	call skrivTekst(adocBokmerke(element)	)

	elementnavn = stereotypeNavn(element)
	if innrykk = "=====" then
		call skrivTekst(adocOverskrift(innrykk, pakke.Name & "::" & elementnavn) )
	else
		call skrivTekst(adocOverskrift(innrykk & "=", elementnavn) )
	end if
	
''	Call skrivTekst(innrykk&"= «"&element.Stereotype&"» "&element.Name&"")
'	call skrivTekst(adocOverskrift(innrykk & "=", stereotypeNavn(element) & "") )

	Call skrivTekst(adocDefinisjonsAvsnitt( element) )
	call skrivTekst(adocAvsnittSkille( ))

	if element.TaggedValues.Count > 0 then
		call skrivTekst(  adocDiskretOverskrift(innrykk, "Profilparametre i tagged values"))
		
		Call skrivTekst( adocTabellstart("20,80", "") )
		for each tag in element.TaggedValues								
			if tag.Value = "" then
			elseif tag.Name = "persistence" or tag.Name = "SOSI_melding" or LCase(tag.Name) = "sosi_bildeavmodellelement" then
			else
				Call skrivTekst(adocTabellRad( tag.Name, tag.Value) )
			end if
		next
		call adocAvsluttTabell
			
		codeListUrl = ""	
		for each tag in element.TaggedValues								
			if LCase(tag.Name) = "asdictionary" and tag.Value = "true" then asdict = true
			
			if LCase(tag.Name) = "sosi_bildeavmodellelement" and tag.Value <> "" then
''''				diagCounter = diagCounter + 1
				call skrivTekst(adocBreak())
				
				tekst = "Illustrasjon av kodeliste: " & element.Name
				bilde = tag.Value
				alternativbildetekst = "Illustrasjon av hva kodelisten " & element.Name & " kan inneholde."
				call skrivTekst(adocBildeTekst(tekst, bilde, alternativbildetekst) )
			end if
			if LCase(tag.Name) = "codelist" and tag.Value <> "" then
				codeListUrl = tag.Value
			end if
		next
	end if

'	if codeListUrl <> "" and asdict then
'		skrivTekst("Koder fra ekstern kodeliste kan hentes fra register: " & codeListUrl & "")	
'		skrivTekst(" ")
'	end if


	if element.Attributes.Count > 0 then
		call skrivTekst(  adocDiskretOverskrift(innrykk, "Koder i modellen"))
	end if
	utvekslingsalias = false
	for each att in element.Attributes
		if att.Default <> "" then
			utvekslingsalias = true
		end if
	next
	if element.Attributes.Count > 0 then
		if utvekslingsalias then
			Call skrivTekst( adocTabellstart("25,60,15", "") )
			Call skrivTekst(adocTabellOverskrift3( "Kodenavn:", "Definisjon:", "Utvekslingsalias:" ) )
			for each att in element.Attributes
			
'				if att.Default <> "" then
'					attDef = att.Default
'				else
'					attDef = " "
'				end if
'				Call skrivTekst(adocTabellRad3( att.Name, getCleanDefinition(att.Notes), attDef) )
				Call skrivTekst(adocTabellRad3( att.Name, getCleanDefinition(att.Notes), att.Default) )
				
				call attrbilde(att,"kodelistekode")
			next
		else
			Call skrivTekst( adocTabellstart("20,80", "") )
			Call skrivTekst(adocTabellOverskrift( "Navn:", "Definisjon:" ) )
			
			for each att in element.Attributes
				Call skrivTekst(adocTabellRad( att.Name, getCleanDefinition(att.Notes) )    )

				call attrbilde(att,"kodelistekode")
			next

		end if
		call adocAvsluttTabell

	end if
End sub
'-----------------CodeList End-----------------


'-----------------Relasjoner-----------------
sub Relasjoner(innrykk,element)
	Dim con
	Dim supplier
	Dim client
	Dim skrivRoller

	skrivRoller = false

'assosiasjoner
' skriv ut roller - sortert etter tagged value sequenceNumber TBD

	For Each con In element.Connectors
		If con.Type = "Association" or con.Type = "Aggregation" Then
			set supplier = Repository.GetElementByID(con.SupplierID)
			set client = Repository.GetElementByID(con.ClientID)
			
			If element.elementID = supplier.elementID and con.ClientEnd.Role <> ""  Then 
				'dette elementet er suppliersiden - implisitt at fraklasse er denne klassen
				Call skrivManglendeOverskrift( "Roller", innrykk, skrivRoller)
				Call skrivRelasjon( con, con.SupplierEnd, con.ClientEnd, client) 

			ElseIf element.elementID = client.elementID and con.SupplierEnd.Role <> "" Then
				'dette elementet er clientsiden, (rollen er på target)
				Call skrivManglendeOverskrift( "Roller", innrykk, skrivRoller)
				Call skrivRelasjon( con, con.ClientEnd, con.SupplierEnd, supplier) 
				
			End If
			
		End If
	Next

end sub

sub skrivManglendeOverskrift( overskrift, innrykk, overskriftFerdig)
	'' skriver ut en overskift dersom den ikke er skrevet ut tidligere
	if overskriftFerdig = false then
		call skrivTekst(adocAvsnittSkille( ))
		call skrivTekst(  adocDiskretOverskrift(innrykk, overskrift))
		overskriftFerdig = true
	end if
end sub

sub skrivRelasjon( connector, currentEnd, targetEnd, target)

	Dim textVar, linkVar, referanse
	DIM conType

	Call skrivTekst( adocTabellstart("20,80", "")	)					
	Call skrivTekst(adocTabellOverskrift( "Rollenavn:", targetEnd.Role ) )

''    exit sub
	If targetEnd.RoleNote <> "" Then
		Call skrivTekst(adocTabellRad( "Definisjon:", getCleanDefinition(targetEnd.RoleNote) )  )
	End If
	If targetEnd.Cardinality <> "" Then
		Call skrivTekst(adocTabellRad( "Multiplisitet:", "[" & targetEnd.Cardinality & "]" )   )  '''' tekstformat
	End If
	If currentEnd.Aggregation <> 0 Then
		if currentEnd.Aggregation = 2 then
			conType = "Komposisjon " & connector.Type
		else
			conType = "Aggregering " & connector.Type
		end if
		Call skrivTekst(adocTabellRad( "Assosiasjonstype:", conType) )
	End If
	If connector.Name <> "" Then
		Call skrivTekst(adocTabellRad( "Assosiasjonsnavn:", connector.Name ) )
	End If

	textVar = "Til klasse"
	If targetEnd.Navigable = "Navigable" Then 'Legg til info om klassen er navigerbar eller spesifisert ikke-navigerbar.
		textVar = "Til klasse"
	ElseIf targetEnd.Navigable = "Non-Navigable" Then 
		textVar = "Til klasse " + adocKursiv("(ikke navigerbar):") 
	Else 
		textVar = "Til klasse:" 
	End If
	
	Call skrivTekst(adocTabellRad( textVar, targetLink( target) ) )

	if false then
		If currentEnd.Role <> "" Then
			Call skrivTekst(adocTabellRad( "Fra rolle:", currentEnd.Role ) )
		End If
		If currentEnd.RoleNote <> "" Then
			Call skrivTekst(adocTabellRad( "Fra rolle definisjon:", getCleanDefinition(currentEnd.RoleNote) ) )
		End If
		If currentEnd.Cardinality <> "" Then
			Call skrivTekst(adocTabellRad( "Fra multiplisitet:", currentEnd.Cardinality )  )
		End If
	End If
	
	call adocAvsluttTabell	

end sub


'-----------------Relasjoner End-----------------



'-----------------Operasjoner-----------------
sub Operasjoner(innrykk,element)
	Dim meth as EA.Method

	call skrivTekst(adocAvsnittSkille( ))
	call skrivTekst(  adocDiskretOverskrift(innrykk, "Operasjoner"))
						
	For Each meth In element.Methods
		Call skrivTekst( adocTabellstart("20,80", "") )
		
		Call skrivTekst(adocTabellOverskrift( "Navn:", meth.Name ) )
		Call skrivTekst(adocTabellRad( "Beskrivelse:", getCleanDefinition(meth.Notes) ) )

''''''''''''''''''''''''''''''''''''''''''''''

'''		Call skrivTekst(adocTabellRad( "Stereotype:", meth.Stereotype) )
'''		Call skrivTekst(adocTabellRad( "Retur type:", meth.ReturnType) )
'''		Call skrivTekst(adocTabellRad( "Oppførsel:", meth.Behaviour) )

		call adocAvsluttTabell
	Next

end sub
'-----------------Operasjoner End-----------------


'-----------------Restriksjoner-----------------
sub Restriksjoner(innrykk,element)
	Dim constr as EA.Constraint

	call skrivTekst(adocAvsnittSkille( ))
	call skrivTekst(  adocDiskretOverskrift(innrykk, "Restriksjoner"))
						
	For Each constr In element.Constraints
		Call skrivTekst( adocTabellstart("20,80", "") )
		
		Call skrivTekst(adocTabellOverskrift( "Navn:", Trim(constr.Name) ) )
		Call skrivTekst(adocTabellRad( "Beskrivelse:", getCleanRestriction(constr.Notes) ) )
		
'''''''''''''''''
'''		Call skrivTekst(adocTabellRad( "Type:", constr.Type) )
'''		Call skrivTekst(adocTabellRad( "Status:", constr.Status) )
'''		Call skrivTekst(adocTabellRad( "Vekt:", constr.Weight) )

		call adocAvsluttTabell
	Next

end sub
'-----------------Restriksjoner End-----------------


'------------------------------------------------------------START-------------------------------------------------------------------------------------------
' Func Name: attrbilde(att)
' Author: Kent Jonsrud
' Date: 2021-09-16
' Purpose: skriver ut lenke til bilde av element ved siden av elementet

sub attrbilde(att,typ)
	dim tag as EA.TaggedValue
	for each tag in att.TaggedValues								
		if LCase(tag.Name) = "sosi_bildeavmodellelement" and tag.Value <> "" then
			Session.Output(" +")
			Session.Output("Illustrasjon av " & typ & " "&att.Name&"")
			Session.Output("image:"&tag.Value&"[link="&tag.Value&",width=100,height=100, alt=""Bilde av " & typ & " "&att.Name&" som er forklart i teksten.""]")
		end if
	next
end sub
'-------------------------------------------------------------END--------------------------------------------------------------------------------------------



'------------------------------------------------------------START-------------------------------------------------------------------------------------------
' Func Name: isElement
' Author: Kent Jonsrud
' Date: 2021-07-13
' Purpose: tester om det finnes et element med denne ID-en.

function isElement(ID)
	isElement = false
	if Mid(Repository.SQLQuery("select count(*) from t_object where Object_ID = " & ID & ";"), 113, 1) <> 0 then
		isElement = true
	end if
end function
'-------------------------------------------------------------END--------------------------------------------------------------------------------------------


'-----------------Funksjon for full path-----------------
function getPath(package)
	dim path
	dim parent
	if package.parentID <> 0 then
'		Session.Output(" -----DEBUG getPath=" & getPath & " package.Name = " & package.Name & " package.ParentID = " & package.ParentID & " package.Element.Stereotype = " & package.Element.Stereotype & " ----- ")
		if package.Element.Stereotype = "" then
			path = package.Name
		else
			path = tekstformatStereotype( package.Element.Stereotype) & package.Name
		end if

		if ucase(package.Element.Stereotype) <> "APPLICATIONSCHEMA" then
			set parent = Repository.GetPackageByID(package.ParentID)
			path = getPath(parent) + "/" + path
		end if
	end if
	getPath = path
end function
'-----------------Funksjon for full path End-----------------


function getTaggedValue(element,taggedValueName)
	dim i, existingTaggedValue
	getTaggedValue = ""
	for i = 0 to element.TaggedValues.Count - 1
		set existingTaggedValue = element.TaggedValues.GetAt(i)
		if LCase(existingTaggedValue.Name) = LCase(taggedValueName) then
			getTaggedValue = existingTaggedValue.Value
		end if
	next
end function

function getPackageTaggedValue(package,taggedValueName)
	dim i, existingTaggedValue
	getPackageTaggedValue = ""
	for i = 0 to package.element.TaggedValues.Count - 1
		set existingTaggedValue = package.element.TaggedValues.GetAt(i)
		if LCase(existingTaggedValue.Name) = LCase(taggedValueName) then
			getPackageTaggedValue = existingTaggedValue.Value
		end if
	next
end function

'-----------------Function getCleanDefinition Start-----------------
function getCleanDefinition(txt)
	'removes all formatting in notes fields, except crlf
	Dim res, tegn, i, u, forrige
	u=0
	getCleanDefinition = ""
	forrige = " "
	res = ""
	txt = Trimutf8(txt)
	For i = 1 To Len(txt)
		tegn = Mid(txt,i,1)
		'for adoc \|
		if tegn = "|" then
			res = res + "\"
		end if
		if tegn = "(" and forrige = "(" then
			res = res + " "
		end if
		if tegn = ")" and forrige = ")" then
			res = res + " "
		end if
'			if tegn = "," then tegn = " " 
		'for xml
		If tegn = "<" Then
			u = 1
			tegn = " "
		end if 
		If tegn = ">" Then
			u = 0
			tegn = " "
		end if
		if u = 0 then
			res = res + tegn
		end if

		forrige = tegn
	'	Session.Output(" tegn" & tegn)
	Next

	getCleanDefinition = res
end function
'-----------------Function getCleanDefinition End-----------------

'-----------------Function getCleanRestriction Start-----------------
function getCleanRestriction(txt)
	'removes all formatting in notes fields, except crlf
	Dim res, tegn, i, u, forrige, v, kommentarlinje
	kommentarlinje = 0
	u=0
	v=0
	getCleanRestriction = ""
	forrige = " "
		res = ""
		txt = Trimutf8(txt)
		For i = 1 To Len(txt)
			tegn = Mid(txt,i,1)
			'for adoc \|
			if tegn = "|" then
				res = res + "\"
			end if
			if tegn = "(" and forrige = "(" then
				res = res + " "
			end if
			if tegn = ")" and forrige = ")" then
				res = res + " "
			end if
	'		if tegn = "-" and forrige <> "-" then
	'			u = 1
	'		end if
			if tegn = "-" then
				if forrige = "-" then
					u = 0
					if kommentarlinje > 0 then
						res = res + " + " + vbCrLf  + "-"
					else
						res = res + vbCrLf  + "-"
					end if
					kommentarlinje = kommentarlinje + 1
					forrige = " "
					v = 1
				else
					u = 1
				end if
			else
				if forrige = "-" and v = 0 then
					res = res + "-"
					u = 0
				end if
				v = 0
			end if

		'	if tegn = "," then tegn = " " 
			'for xml
			If tegn = "<" Then
				u = 1
				tegn = " "
			end if 
			If tegn = ">" Then
				u = 0
				tegn = " "
			end if
			if u = 0 then
				res = res + tegn
			end if

			forrige = tegn
		'	Session.Output(" tegn" & tegn)
		Next

	getCleanRestriction = res
end function
'-----------------Function getCleanRestriction End-----------------

'-----------------Function getCleanBildetekst Start-----------------
function getCleanBildetekst(txt)
	'removes all formatting in notes fields, except crlf
	Dim res, tegn, i, u, forrige
	u=0
	getCleanBildetekst = ""
	forrige = " "
	res = ""
	txt = Trimutf8(txt)
	For i = 1 To Len(txt)
		tegn = Mid(txt,i,1)
		'for adoc \|
		if tegn = "|" then
			res = res + "\"
		end if
		if tegn = "(" and forrige = "(" then
			res = res + " "
		end if
		if tegn = ")" and forrige = ")" then
			res = res + " "
		end if
		if tegn = "," then tegn = " " 
		'for xml
		If tegn = "<" Then
			u = 1
			tegn = " "
		end if 
		If tegn = ">" Then
			u = 0
			tegn = " "
		end if
		if u = 0 then
			res = res + tegn
		end if

		forrige = tegn
	'	Session.Output(" tegn" & tegn)
	Next

	getCleanBildetekst = res
end function
'-----------------Function getCleanBildetekst End-----------------

'-----------------Function Trimutf8 Start-----------------
function Trimutf8(txt)
	'convert national characters back to utf8
	Dim inp
'	dim res, tegn, i, u, ÉéÄäÖöÜü-Áá &#233; forrige &#229;r i samme retning skal den h&#248; prim&#230;rt prim&#230;rt

	inp = Trim(txt)
	if InStr(1,inp,"&#230;",0) <> 0 then
		inp = Replace(inp,"&#230;","æ",1,-1,0)
	end if
	if InStr(1,inp,"&#248;",0) <> 0 then
		inp = Replace(inp,"&#248;","ø",1,-1,0)
	end if
	if InStr(1,inp,"&#229;",0) <> 0 then
		inp = Replace(inp,"&#229;","å",1,-1,0)
	end if
	if InStr(1,inp,"&#198;",0) <> 0 then
		inp = Replace(inp,"&#198;","Æ",1,-1,0)
	end if
	if InStr(1,inp,"&#216;",0) <> 0 then
		inp = Replace(inp,"&#216;","Ø",1,-1,0)
	end if
	if InStr(1,inp,"&#197;",0) <> 0 then
		inp = Replace(inp,"&#197;","Å",1,-1,0)
	end if
	if InStr(1,inp,"&#233;",0) <> 0 then
		inp = Replace(inp,"&#233;","é",1,-1,0)
	end if
	Trimutf8 = inp
end function
'-----------------Function Trimutf8 End-----------------


'-----------------Function nao Start-----------------
function nao()
	' I just want a correct xml timestamp to document when the script was run
	dim m,d,t,min,sek,tm,td,tt,tmin,tsek
	m = Month(Date)
	if m < 10 then
		tm = "0" & FormatNumber(m,0,0,0,0)
	else
		tm = FormatNumber(m,0,0,0,0)
	end if
	d = Day(Date)
	if d < 10 then
		td = "0" & FormatNumber(d,0,0,0,0)
	else
		td = FormatNumber(d,0,0,0,0)
	end if
	t = Hour(Time)
	if t < 10 then
		tt = "0" & FormatNumber(t,0,0,0,0)
	else
		tt = FormatNumber(t,0,0,0,0)
	end if
	if t = 0 then tt = "00"
	min = Minute(Time)
	if min < 10 then
		tmin = "0" & FormatNumber(min,0,0,0,0)
	else
		tmin = FormatNumber(min,0,0,0,0)
	end if
	if min = 0 then tmin = "00"
	sek = Second(Time)
	if sek < 10 then
		tsek = "0" & FormatNumber(sek,0,0,0,0)
	else
		tsek = FormatNumber(sek,0,0,0,0)
	end if
	if sek = 0 then tsek = "00"
	'SessionOutput("  timeStamp=""" & Year(Date) & "-" & tm & "-" & td & "T" & tt & ":" & tmin & ":" & tsek & "Z""")
	nao = Year(Date) & "-" & tm & "-" & td & "T" & tt & ":" & tmin & ":" & tsek & "Z"
end function
'-----------------Function nao End-----------------

'======  Funksjoner og rutiner for asciidoc-koding, utforming av tekst, og utskrift av resultatet =====================

' --------   Funksjoner som returnerer rein tekst  ---------------
function bounds( att)
''  Returnerer en formattert tekst som angir nedre og øvre grense for et intervall
	bounds = att.LowerBound & ".." & att.UpperBound
	bounds = "[" & bounds & "]"
end function

function tekstformatStereotype( stereotype)
	if stereotype <> "" then 
		tekstformatStereotype = "«" & stereotype & "» "
	else
		tekstformatStereotype = ""
	end if
end function

function stereotypeNavn( element)
	stereotypeNavn = tekstformatStereotype( element.Stereotype) & element.Name
end function

' ----------  	Funksjoner og rutiner for adoc-kode  -------------
' *** Det gjenstår å rydde opp og forenkle

''' --- Asciidoc-rutiner for dokumentoppdeling
'''
function adocPageBreak()
	adocPageBreak = "<<<"
end function

function adocBreak()
	adocBreak = "'''"
end function

function adocAvsnittSkille( )
	adocAvsnittSkille = " "
end function

function adocLinjeskift( )
	adocLinjeskift = " +"
end function


''' --- Ascidoc for overskrifter
'''
function adocOverskrift(innrykk, overskrift)
	adocOverskrift = innrykk & " " & overskrift
end function


function adocStorDiskretOverskrift(innrykk, overskrift)
''  Returnerer asciidoc-kode for en stor diskret overskrift
''  Med stor menes at den skal innledes med et linjeskift og være ett nivå lavere enn gjeldende nivå.
''  Med diskret menees at den ikke skal vises i innholdsfortegnelsen
''
	dim res(2) 
	res(0) = adocAvsnittSkille()
	res(1) = "[discrete]"
	res(2) = innrykk & "= " & overskrift
	adocStorDiskretOverskrift = res
end function

function adocDiskretOverskrift(innrykk, overskrift)
''  Returnerer asciidoc-kode for en liten diskret overskrift
''  Med liten med at den skal være to nivå lavere enn gjeldende nivå
''  Med diskret menees at den ikke skal vises i innholdsfortegnelsen
''	
	dim res(1)
	res(0) = "[discrete]"
'''	res(1) = innrykk & "== " & overskrift  'Et lite HACK or å redusere et for langt innrykk
	res(1) = innrykk & "= " & overskrift
	adocDiskretOverskrift = res
end function


''' --- Ascidoc-funksjoner for linker og referanser
'''
function adocBokmerke(element)
	adocBokmerke = "[[" & LCase(element.Name) & "]]"
end function

function targetLink( target)
	targetLink = adocLink( target.Name, stereotypeNavn(target) )
end function

'function typeLink( att, typ)
''	typeLink = "<<" & LCase(att.Type) & "," & typ & ">>"  ''' adoc-syntaks for en link
'	typeLink = adocLink( att.Type, typ )
'end function

function adocLink( link, tekst)
	adocLink = "<<" & LCase(link) & ", " & tekst & ">>"  
end function

''' --- Asciidoc for tabeller
'''
function adocTabellavslutning()
''  Returnrer asciidoc-kode for å avslutte en tabell
	adocTabellavslutning = "|==="
end function
SUB adocAvsluttTabell
''  Skriver asciidoc-kode for å avslutte en tabell
	call skrivTekst( adocTabellavslutning() )
END SUB

function appendArray( ByVal array, tillegg)
	dim i, start
	start = UBound(array) + 1
	if isArray(tillegg) Then
		REDIM preserve array(start + UBound(tillegg) )
		for i = 0 to UBound(tillegg) 
			array(start + i) = tillegg(i)
		next
	else 
		REDIM preserve array(start )
		array(start) = tillegg
	end if
	appendArray = array
end function

function adocTabellstart( kolonneBredder, overskrift )
''  Returnerer asciidoc-kode for å opprette en tabell med overskrift og angitte kolonnebredder
	dim res(), start, i
	
	if isArray(overskrift) then   
		start = ubound(overskrift)  
		redim res(start+2)
		for i = 0 to start
			res(i) = overskrift(i)
		next
		start = start + 1
	elseif overskrift <> "" then
		redim res(2)
		res(0) = overskrift
		start = 1
	else
		start = 0
		redim res(1)
	end if

	res(start)   = "[cols=""" & kolonneBredder & """]"
	res(start+1) = "|==="

	adocTabellstart = res
end function

sub skrivTabell(tabell)
	call skrivTekst( tabell)
	call skrivTekst( adocTabellavslutning() )
end sub

sub fullforTabell(overskrift, tabell)
	call skrivTekst( overskrift)
	call skrivTekst( tabell)
	call skrivTekst( adocTabellavslutning() )
end sub

function adocTabellOverskrift( parameter, verdi)
    adocTabellOverskrift = adocTabellRad( adocBold(parameter), adocBold(verdi) ) 
end function

function adocTabellOverskrift3( parameter, verdi, ekstra)
    adocTabellOverskrift3 = adocTabellRad3( adocBold(parameter), adocBold(verdi), adocBold(ekstra) ) 
end function

function adocTabellCelle( innhold)
	adocTabellCelle = "|" & innhold & " "
end function

function adocTabellRad( parameter, verdi)
''  Returnerer asciidoc-kode for å skive ut en rad i en tabell med to kolonner
	dim res()
	redim res(1)
	res(0) = "|" & parameter & " "
	res(1) = "|" & verdi & " "
''	redim preserve res(2)	
''	res(2) = " "
	adocTabellRad = res
end function


function adocTabellRad3( parameter, verdi, ekstra)
''  Returnerer asciidoc-kode for å skive ut en rad i en tabell med to kolonner
	dim res()
	redim res(2)
	res(0) = "|" & parameter & " "
	res(1) = "|" & verdi & " "
	res(2) = "|" & ekstra & " "
''	redim preserve res(3)	
''	res(3) = " "
	adocTabellRad3 = res
end function



''' Asciidoc for bilder
'''
function adocBildeTekst(tekst, bilde, alternativbildetekst)
	adocBildeTekst = array("." & tekst , adocBildeLink(bilde, alternativbildetekst) )
end function

function adocBildeLink(bilde, alternativbildetekst)
	adocBildeLink = "image::" & bilde & "[link=" & bilde & ", alt=""" & alternativbildetekst & """]"
end function


''' Ascidoc-funksjoner for tekstformatering
'''
function adocBold( tekst)
''	Returnerer asciidoc-kode for feit/bold tekst
	adocBold = "*" & tekst & "*"
end function 

function adocKursiv( tekst)
''	Returnerer asciidoc-kode for kursiv tekst
	adocKursiv = "_" & tekst & "_"
end function 


''' --- Ascidoc for definisjoner
'''
function adocDefinisjonsAvsnitt( element)
	adocDefinisjonsAvsnitt = adocBold("Definisjon:") & " " & getCleanDefinition(element.Notes)
end function 

	
' ----------  	Rutiner for utskrift av tekst til output    ----------------

sub skrivTekstlinje(tekst)
	if tekst <> "" then Session.Output(tekst)
end sub

sub skrivTekstblokk(tekstBlokk)
	dim tekst
	for each tekst in tekstBlokk 
		Session.Output(tekst)
	next
end sub

sub skrivTekst(tekst)
	if isArray(tekst) then
		call skrivTekstblokk(tekst)
	else
		call skrivTekstlinje(tekst)
	end if 
end sub

'====================================================

OnProjectBrowserScript

'====================================================

