// Start of UML-model
<<<
'''
=== Pakke: Arealplan
*Definisjon:* inneholder objekttypen arealplan med tilhørende datatyper og assosiasjoner
 
'''
 
.Arealplan 
image::diagrammer/Arealplan.png[link=diagrammer/Arealplan.png, alt="Diagram med navn Arealplan som viser UML-klasser beskrevet i teksten nedenfor."]
 
'''
 
.Arealplan kodelister 
image::diagrammer/Arealplan kodelister.png[link=diagrammer/Arealplan kodelister.png, alt="Diagram med navn Arealplan kodelister som viser UML-klasser beskrevet i teksten nedenfor."]
 
'''
 
[[arealplan]]
==== «featureType» Arealplan
*Definisjon:* toppobjekt for en arealplan, som Inneholder informasjon om planen som helhet

En arealplan kan være:
regulerings- og bebyggelsesplan ( pbl. 1985 &#167;&#167; 22 og 24 og 28-2,) / 
områderegulering eller detaljregulering ( pbl. 2008 &#167;&#167; 12-1, 12-2 og 12-3)
eller
kommune (-del) plan (pbl. 1985 &#167; 20-4 første ledd, eller pbl. 2008 &#167; 11-5)

 
[discrete]
==== Egenskaper
[cols="20,80"]
|===
|*Navn:* 
|*nasjonalArealplanId*
 
|Definisjon: 
|landsdekkende entydig og unik identifikasjon for en arealplan (pbl. 1985 &#167; 18, &#167; 20-1 andre og femte ledd og &#167; 22 og &#167; 28-2 / pbl. &#167;&#167; 6-4, 8-1, 9-1, 11-1 og &#167; 12-1, samt kart- og planforskriften &#167; 9 andre og sjette ledd)
 
|Multiplisitet: 
|[1..1]
 
|Type: 
|<<nasjonalarealplanid,«dataType» NasjonalArealplanId>>
|Profilparametre i tagged values: 
|
SOSI_navn: NASJONALAREALPLANID + 
|===
[cols="20,80"]
|===
|*Navn:* 
|*plannavn*
 
|Definisjon: 
|planens offisielle navn
 
|Multiplisitet: 
|[1..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/CharacterString[CharacterString]
|Profilparametre i tagged values: 
|
SOSI_navn: PLANNAVN + 
|===
[cols="20,80"]
|===
|*Navn:* 
|*plantype*
 
|Definisjon: 
|type arealplan
Arealpan kan være en type reguleringsplan eller en type kommuneplan
 
|Multiplisitet: 
|[1..1]
 
|Type: 
|<<plantype,«Union» Plantype>>
|Profilparametre i tagged values: 
|
SOSI_navn: PLANTYPE + 
|===
[cols="20,80"]
|===
|*Navn:* 
|*planstatus*
 
|Definisjon: 
|planens behandling (pbl. 1985 &#167;&#167; 20-5, 27-1, 27-2, 28-1 og 28-2) 
samt planens rettsvirkning (pbl. 1985 &#167;&#167;  20-6, 28-2 og 31 / pbl. &#167;&#167; 8-3, 8-4, 9-3, 9-4, &#167;&#167; 11-12 til 11-15, og &#167;&#167; 12-8 til 12-12)
 
|Multiplisitet: 
|[1..1]
 
|Type: 
|<<planstatus,«Enumeration» Planstatus>>
|Profilparametre i tagged values: 
|
SOSI_navn: PLANSTAT + 
|===
[cols="20,80"]
|===
|*Navn:* 
|*omPlanbestemmelser*
 
|Definisjon: 
|om planen har bestemmelser (pbl. 1985 &#167; 20-4 andre ledd bokstav a til h og &#167; 26 / pbl. &#167;&#167; 11-9, 11-10 og 11-11, samt &#167; 12-7), og hvordan disse i så fall er representert

Merknad: Tidligere hadde denne egenskapen navnet 'planbestemmelser', men er gitt nytt navn for at den ikke skal forveksles med forhold knyttet til digitale planbestemmelser.
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|<<omplanbestemmelser,«Enumeration» OmPlanbestemmelser>>
|Profilparametre i tagged values: 
|
SOSI_navn: PLANBEST + 
|===
[cols="20,80"]
|===
|*Navn:* 
|*lovreferanse*
 
|Definisjon: 
|hvilken lov planen er vedtatt etter
 
|Multiplisitet: 
|[1..1]
 
|Type: 
|<<lovreferansetype,«Enumeration» LovreferanseType>>
|Profilparametre i tagged values: 
|
SOSI_navn: LOVREFERANSE + 
|===
[cols="20,80"]
|===
|*Navn:* 
|*lovreferanseBeskrivelse*
 
|Definisjon: 
|tekstlig beskrivelse av hvilken lov planen er vedtatt etter. 

Merknad: Kan være utfyllende til egenskapen lovereferanse
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/CharacterString[CharacterString]
|Profilparametre i tagged values: 
|
SOSI_navn: LOVREFBESKRIVELSE + 
|===
[cols="20,80"]
|===
|*Navn:* 
|*opprinneligPlanId*
 
|Definisjon: 
|opprinnelig planidentifikasjon (planid)

Danner sammen med egenskapen opprinneligAdministrativEnhet den opprinnelige unike identifikasjonen til planen (opprinnelig nasjonalArealplanid). Disse to egenskapen brukes kun dersom planen har fått ny nasjonalArealplanid.
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/CharacterString[CharacterString]
|Profilparametre i tagged values: 
|
SOSI_navn: OPPRINNELIGPLANID + 
|===
[cols="20,80"]
|===
|*Navn:* 
|*opprinneligAdministrativEnhet*
 
|Definisjon: 
|opprinnelig administrativEnhet for arealplanen.

Danner sammen med egenskapen opprinneligPlanId den opprinnelige unike identifikasjonen til planen (opprinnelig nasjonalArealplanid). Disse to egenskapen brukes kun dersom planen har fått ny nasjonalArealplanid.
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|<<characterstring,«Union» CharacterString>>
|Profilparametre i tagged values: 
|
SOSI_navn: OPPRINNELIGADMINISTRATIVENHET + 
|===
[cols="20,80"]
|===
|*Navn:* 
|*forslagsstillerType*
 
|Definisjon: 
|om forslagsstiller er privat eller offentlig
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|<<forslagsstillertype,«Enumeration» ForslagsstillerType>>
|Profilparametre i tagged values: 
|
SOSI_navn: FORSLAGSSTILLERTYPE + 
|===
[cols="20,80"]
|===
|*Navn:* 
|*plandokumentasjonOppdatert*
 
|Definisjon: 
|om plandokument er oppdatert i henhold til endelig planvedtak
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/Boolean[Boolean]
|===
[cols="20,80"]
|===
|*Navn:* 
|*ubehandletKlage*
 
|Definisjon: 
|om det foreligger klage med oppsettende virkning
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/Boolean[Boolean]
|===
[cols="20,80"]
|===
|*Navn:* 
|*ubehandletInnsigelse*
 
|Definisjon: 
|om det foreligger innsigelse som ikke er behandlet av departementet.

Merknad: kommunen har vedtatt planen men den har ikke full rettsvirkning før endelig avgjørelse av departementet.
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/Boolean[Boolean]
|===
[cols="20,80"]
|===
|*Navn:* 
|*vedtakEndeligPlanDato*
 
|Definisjon: 
|dato for rettsvirkning av arealplanen med tilhørende bestemmelser gjennom statlig, regionalt eller kommunalt vedtak etter plan- og bygningsloven
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/Date[Date]
|Profilparametre i tagged values: 
|
SOSI_navn: VEDTAKENDELIGPLANDATO + 
|===
[cols="20,80"]
|===
|*Navn:* 
|*kunngjøringsdato*
 
|Definisjon: 
|dato når endelig vedtatt arealplan eller planbestemmelse ble kunngjort, pbl. § 6-3, 8-5 siste ledd, 11-15 tredje ledd og 12-12 siste ledd
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/Date[Date]
|Profilparametre i tagged values: 
|
SOSI_navn: KUNNGJØRINGSDATO + 
|===
[cols="20,80"]
|===
|*Navn:* 
|*ikrafttredelsesdato*
 
|Definisjon: 
|dato når arealplanen trådte ikraft (pbl. 1985 &#167;&#167; 18, 19-1 sjette ledd, 20-1 andre ledd, 22 og 28-2, samt pbl. &#167;&#167; 8-4, 8-5, 11-6, 11- 15, 11-16, 12-4, 12-12 og 12-13)
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/Date[Date]
|Profilparametre i tagged values: 
|
SOSI_navn: IKRAFT + 
|===
[cols="20,80"]
|===
|*Navn:* 
|*versjonsdato*
 
|Definisjon: 
|datoen for denne versjonen

Egenskapen kan anvendes for planer i forslagsfasen
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/DateTime[DateTime]
|===
[cols="20,80"]
|===
|*Navn:* 
|*versjonsnummer*
 
|Definisjon: 
|viser versjonen av et planforslag
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/CharacterString[CharacterString]
|===
[cols="20,80"]
|===
|*Navn:* 
|*alternativReferanse*
 
|Definisjon: 
|gir anledning til å identifisere ulike planalternativ for et planforslag
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/CharacterString[CharacterString]
|===
[cols="20,80"]
|===
|*Navn:* 
|*planhøring*
 
|Definisjon: 
|egenskapssett for å holde rede på versjoner og alternativer for planforslag som er på høring

Med høring menes at planforslag sendes ut og legges ut til offentlig ettersyn (pbl. &#167; 11-15, &#167; 12-9)
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|<<planhøring,«dataType» Planhøring>>
|===
[cols="20,80"]
|===
|*Navn:* 
|*planområde*
 
|Definisjon: 
|hele planens utstrekning uavhengig av vertikalnivå
Brukes for planer i oppstartsfasen der planområder/vertikalnivå ikke er definert ennå
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|<<gm_multisurface,GM_MultiSurface>>
|===
[cols="20,80"]
|===
|*Navn:* 
|*referansemålestokk*
 
|Definisjon: 
|Målestokktall for plankartet
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/Integer[Integer]
|===
 
[discrete]
==== Roller
[cols="20,80"]
|===
|*Rollenavn:* 
|*kommentar*
 
|Multiplisitet: 
|[0..*]
 
|Til klasse 
|<<kommentar,«FeatureType» Kommentar>>
 
|===
[cols="20,80"]
|===
|*Rollenavn:* 
|*bestemmelseSamling*
 
|Multiplisitet: 
|[0..1]
 
|Til klasse: 
|<<reguleringsplanbestemmelser,«featureType» Reguleringsplanbestemmelser>>
 
|===
[cols="20,80"]
|===
|*Rollenavn:* 
|*rpOmråde*
 
|Definisjon: 
|reguleringsplanområde som inngår i arealplanen
 
|Multiplisitet: 
|[0..*]
 
|Til klasse 
|<<rpområde,«featureType» RpOmråde>>
 
|===
[cols="20,80"]
|===
|*Rollenavn:* 
|*plandokument*
 
|Multiplisitet: 
|[0..*]
 
|Assosiasjonstype: 
|Aggregering Aggregation
 
|Til klasse 
|<<plandokument,«FeatureType» Plandokument>>
 
|===
[cols="20,80"]
|===
|*Rollenavn:* 
|*kpOmråde*
 
|Definisjon: 
|kommuneplanområde som inngår i arealplanen
 
|Multiplisitet: 
|[0..*]
 
|Til klasse 
|<<kpområde,«featureType» KpOmråde>>
 
|===
[cols="20,80"]
|===
|*Rollenavn:* 
|*planbehandling*
 
|Multiplisitet: 
|[1..*]
 
|Til klasse 
|<<planbehandling,«FeatureType» Planbehandling>>
 
|===
[cols="20,80"]
|===
|*Rollenavn:* 
|*fraPlan*
 
|Definisjon: 
|assosiasjon fra plan
 
|Multiplisitet: 
|[0..*]
 
|Assosiasjonsnavn: 
|RelasjonTilAnnenPlan
 
|Til klasse 
|<<arealplan,«featureType» Arealplan>>
 
|===
 
[discrete]
==== Restriksjoner
[cols="20,80"]
|===
|*Navn:* 
|*Samsvar mellom plantype og type planområde*
 
|Beskrivelse: 
|/* Planområdene til en reguleringsplan skal være RpOmråde, mens planområdene til en kommuneplan skal være KpOmråde */

inv: rpOmråde.nonEmpty() implies  plantype.rpPlantype.nonEmpty()

inv: kpOmråde.nonEmpty() implies  plantype.kpPlantype.nonEmpty()
 
|===
 
'''
 
[[planhøring]]
==== «dataType» Planhøring
*Definisjon:* egenskapssett for å holde rede på versjoner og alternativer for planforslag legges ut til offentlig ettersyn (pbl. &#167; 11-15, &#167; 12-9)
 
[discrete]
==== Egenskaper
[cols="20,80"]
|===
|*Navn:* 
|*høringsversjon*
 
|Definisjon: 
|planforslaget kan legges ut til offentlig ettersyn flere ganger. 

Hver publisering gis en versjonsangivelse (f.eks. en dato eller et serienummer)
 
|Multiplisitet: 
|[1..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/Integer[Integer]
|===
[cols="20,80"]
|===
|*Navn:* 
|*høringsalternativ*
 
|Definisjon: 
|planforslaget kan legges ut til offentlig ettersyn med to eller flere planalternativer
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/CharacterString[CharacterString]
|===
[cols="20,80"]
|===
|*Navn:* 
|*høringsstart*
 
|Definisjon: 
|dato for når offentlig ettersyn starter
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/Date[Date]
|===
[cols="20,80"]
|===
|*Navn:* 
|*høringsslutt*
 
|Definisjon: 
|dato for når offentlig ettersyn slutter
 
|Multiplisitet: 
|[0..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/Date[Date]
|===
 
'''
 
[[plantype]]
==== «Union» Plantype
*Definisjon:* sammensatt datatype som angir type reguleringsplan eller type kommuneplan
 
[discrete]
==== Egenskaper
[cols="20,80"]
|===
|*Navn:* 
|*rpPlantype*
 
|Definisjon: 
|type reguleringsplan
 
|Multiplisitet: 
|[1..1]
 
|Type: 
|<<rpplantype,«Enumeration» RpPlantype>>
|===
[cols="20,80"]
|===
|*Navn:* 
|*kpPlantype*
 
|Definisjon: 
|type kommuneplan
 
|Multiplisitet: 
|[1..1]
 
|Type: 
|<<kpplantype,«Enumeration» KpPlantype>>
|===
 
'''
 
[[planstatus]]
==== «Enumeration» Planstatus
*Definisjon:* kodeliste for planens behandling (pbl. 1985 &#167;&#167; 19-4, 20-5, 27-1, 27-2, 28-1 og 28-2) samt planens rettsvirkning (pbl. 1985 &#167;&#167; 19-6, 20-6, 28-2 og 31/pbl. &#167;&#167; 8-3, 8-4, 9-3, 9-4, &#167;&#167; 11-12 til 11-15, og &#167;&#167; 12-8 til 12-12)
 
[discrete]
==== Koder i modellen
[cols="25,60,15"]
|===
|*Navn:*: 
|*Definisjon:*
|*Utvekslingsalias:*
 
|Planinitiativ: 
|
|0
 
|Planlegging igangsatt: 
|
|1
 
|Planforslag: 
|
|2
 
|Endelig vedtatt arealplan: 
|
|3
 
|Opphevet: 
|
|4
 
|Utgått/erstattet: 
|
|5
 
|Vedtatt plan med utsatt rettsvirkning: 
|
|6
 
|Overstyrt: 
|
|8
 
|Avvist: 
|
|9
 
|Trukket/uaktuelt: 
|
|10
 
|===
 
'''
 
[[omplanbestemmelser]]
==== «Enumeration» OmPlanbestemmelser
*Definisjon:* kodeliste for om planen har bestemmelser (pbl. 1985 &#167; 20-4 andre ledd bokstav a til h og &#167; 26 / pbl. &#167;&#167; 11-9, 11-10 og 11-11, samt &#167; 12-7), og hvordan disse i så fall er representert
 
[discrete]
==== Koder i modellen
[cols="25,60,15"]
|===
|*Navn:*: 
|*Definisjon:*
|*Utvekslingsalias:*
 
|Med bestemmelser som egen tekst: 
|Planbestemmelser framgår som egen tekst, men ikke på kartet
|1
 
|Uten bestemmelser: 
|Planen har ingen bestemmelser, hverken på kartet eller som egen tekst
|2
 
|Planbestemmelser fremgår kun av kartet: 
|Planbestemmelser fremgår kun av kartet (bygghøyder mv.)
|3
 
|Planbestemmelser både kart og tekst: 
|Planbestemmelser både på kart og som egen tekst
|4
 
|===
 
'''
 
[[lovreferansetype]]
==== «Enumeration» LovreferanseType
*Definisjon:* kodeliste for hvilken lov planen er vedtatt etter
 
[discrete]
==== Koder i modellen
[cols="25,60,15"]
|===
|*Navn:*: 
|*Definisjon:*
|*Utvekslingsalias:*
 
|Før BL 1924: 
|Før bygningsloven av 1924
|1
 
|BL 1924: 
|Bygningsloven av 1924
|2
 
|BL 1965: 
|Bygningsloven av 1965
|3
 
|PBL 1985: 
|Plan- og bygningsloven av 1985
|4
 
|PBL 1985 eller før: 
|Plan- og bygningsloven av 1985 eller før
|5
 
|PBL 2008: 
|Plan- og bygningsloven av 2008
|6
 
|===
 
'''
 
[[forslagsstillertype]]
==== «Enumeration» ForslagsstillerType
*Definisjon:* kodeliste for om forslagsstiller er offentlig planmyndighet eller privat
 
[discrete]
==== Koder i modellen
[cols="25,60,15"]
|===
|*Navn:*: 
|*Definisjon:*
|*Utvekslingsalias:*
 
|offentlig: 
|
|1
 
|privat: 
|
|2
 
|===
<<<
'''
==== Pakke: NasjonalArealplanID
*Definisjon:* 
 
'''
 
.Nasjonal ArealplanID 
image::diagrammer/Nasjonal ArealplanID.png[link=diagrammer/Nasjonal ArealplanID.png, alt="Diagram som viser den sammensatte datatypen NasjonalArealplanId"]
 
'''
 
[[nasjonalarealplanid]]
===== «dataType» NasjonalArealplanId
*Definisjon:* landsdekkende entydig og unik identifikasjon av en arealplan (pbl. &#167;&#167; 6-4, 9-1, og 12-1, samt kart- og planforskriften &#167; 9 andre og sjette ledd).
 
[discrete]
===== Egenskaper
[cols="20,80"]
|===
|*Navn:* 
|*administrativEnhet*
 
|Definisjon: 
|entydig identifikasjon av administrativ enhet som vedtar planen (vedtaksmyndighet)

Merknad: Bruken av landkode=NO er forbeholdt statlig vedtaksmyndighet
 
|Multiplisitet: 
|[1..1]
 
|Type: 
|<<administrativenhetskode,«Union» AdministrativEnhetskode>>
|===
[cols="20,80"]
|===
|*Navn:* 
|*planId*
 
|Definisjon: 
|entydig identifikasjon for en plan innen vedkommende administrative enhet  (pbl. 1985 &#167; 18, &#167; 19-1 sjette ledd, &#167; 20-1 andre og femte ledd og &#167; 22 og &#167; 28-2 / pbl. &#167;&#167; 6-4, 8-1, 9-1, 11-1 og &#167; 12-1, samt kart- og planforskriften &#167; 9 andre og sjette ledd)
 
|Multiplisitet: 
|[1..1]
 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/CharacterString[CharacterString]
|Profilparametre i tagged values: 
|
SOSI_navn: PLANID + 
|===
 
[discrete]
===== Restriksjoner
[cols="20,80"]
|===
|*Navn:* 
|*maksimalt 16 tegn for planid*
 
|Beskrivelse: 
|Det kan anvendes maksimalt 16 tegn for planid
 
|===
 
'''
 
[[administrativenhetskode]]
===== «Union» AdministrativEnhetskode
*Definisjon:* entydig identifikasjon av administrativ enhet som kan vedta en arealplan, enten en kommune, et fylke, eller staten
 
[discrete]
===== Egenskaper
[cols="20,80"]
|===
|*Navn:* 
|*kommunenummer*
 
|Definisjon: 
|ekstern kodeliste som viser til offisiell nummerering av kommuner 

Merknad:
Det presiseres at kommunenummer alltid skal ha 4 siffer, dvs. eventuelt med ledende null. Kommunenummer benyttes for kopling mot en rekke andre registre som også benytter 4 siffer.
 
|Multiplisitet: 
|[1..1]
 
|Type: 
|<<kommunenummer,«CodeList» Kommunenummer>>
|Profilparametre i tagged values: 
|
defaultCodespace: https://register.geonorge.no/sosi-kodelister/kommunenummer-alle + 
SOSI_navn: KOMM + 
|===
[cols="20,80"]
|===
|*Navn:* 
|*fylkesnummer*
 
|Definisjon: 
|ekstern kodeliste som viser til offisiell nummerering av fylker

Merknad:
Det presiseres at fylkesnummer alltid skal ha 2 siffer, dvs. eventuelt med ledende null. Fylkesnummer benyttes for kopling mot en rekke andre registre som også benytter 2 siffer
 
|Multiplisitet: 
|[1..1]
 
|Type: 
|<<fylkesnummer,«CodeList» Fylkesnummer>>
|Profilparametre i tagged values: 
|
defaultCodespace: https://register.geonorge.no/sosi-kodelister/fylkesnummer-alle + 
SOSI_navn: FYLKESNR + 
|===
[cols="20,80"]
|===
|*Navn:* 
|*landkode*
 
|Definisjon: 
|kode med verdien 'NO', som angir at administrativ enhet er staten Norge, ihht. ISO 3166
 
|Multiplisitet: 
|[1..1]
 
|Type: 
|<<landkode,«Enumeration» Landkode>>
|Profilparametre i tagged values: 
|
SOSI_navn: LANDKODE + 
|===
 
'''
 
[[kommunenummer]]
===== «CodeList» Kommunenummer
*Definisjon:* ekstern kodeliste for kommunenummer.

Merknad: Det presiseres at kommune alltid skal ha 4 sifre, dvs. eventuelt med ledende null. Kommune benyttes for kopling mot en rekke andre registre som også benytter 4 sifre.
 
[discrete]
===== Profilparametre i tagged values
[cols="20,80"]
|===
|asDictionary 
|true
 
|codeList 
|https://register.geonorge.no/sosi-kodelister/kommunenummer-alle
 
|===
 
'''
 
[[fylkesnummer]]
===== «CodeList» Fylkesnummer
*Definisjon:* ekstern kodeliste for kommunenummer.

Merknad: Det presiseres at kommune alltid skal ha 4 sifre, dvs. eventuelt med ledende null. Kommune benyttes for kopling mot en rekke andre registre som også benytter 4 sifre.
 
[discrete]
===== Profilparametre i tagged values
[cols="20,80"]
|===
|asDictionary 
|true
 
|codeList 
|https://register.geonorge.no/sosi-kodelister/fylkesnummer-alle
 
|===
 
'''
 
[[landkode]]
===== «Enumeration» Landkode
*Definisjon:* alfanumerisk kode for nasjonalt nivå / Norge.

Avledet fra "ISO 3166 Codes for the representation of names of countries and their subdivisions"
 
[discrete]
===== Koder i modellen
[cols="25,60,15"]
|===
|*Navn:*: 
|*Definisjon:*
|*Utvekslingsalias:*
 
|Norge: 
|
|NO
 
|===
// End of UML-model
