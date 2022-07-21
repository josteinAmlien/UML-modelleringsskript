// Start of UML-model
<<<
'''
=== Pakke: Plan-5.0-Utkast
*Definisjon:* modell for planer og planregister i henhold til plan- og bygningsloven av 2008 (pbl.) og pbl. 1985, samt Geodatalovens regler om arealbruk (INSPIRE). 
I og med at eldre reguleringsplaner etter tidligere bygningslovgivning (bl.) fortsatt er juridisk bindende, omfattes disse også av standarden. 

 
[discrete]
==== Profilparametre i tagged values
[cols="20,80"]
|===
|definition 
|""@en 
|SOSI_produktgruppe 
|fagområde 
|===
<<<
'''
==== Pakke: Arealplan
*Definisjon:* inneholder objekttypen arealplan med tilhørende datatyper og assosiasjoner
 
'''
 
.Arealplan
image::diagrammer\Arealplan.png[link=diagrammer\Arealplan.png, alt="Diagram med navn Arealplan som viser UML-klasser beskrevet i teksten nedenfor."]
 
'''
 
.Arealplan kodelister
image::diagrammer\Arealplan kodelister.png[link=diagrammer\Arealplan kodelister.png, alt="Diagram med navn Arealplan kodelister som viser UML-klasser beskrevet i teksten nedenfor."]
 
'''
 
[[arealplan]]
===== «featureType» Arealplan
*Definisjon:* toppobjekt for en arealplan, som Inneholder informasjon om planen som helhet

En arealplan kan være:
regulerings- og bebyggelsesplan ( pbl. 1985 &#167;&#167; 22 og 24 og 28-2,) / 
områderegulering eller detaljregulering ( pbl. 2008 &#167;&#167; 12-1, 12-2 og 12-3)
eller
kommune (-del) plan (pbl. 1985 &#167; 20-4 første ledd, eller pbl. 2008 &#167; 11-5)

 
 
[discrete]
===== Egenskaper
[cols="20,80"]
|===
|*Navn:* 
|*nasjonalArealplanId* 
|Definisjon: 
|landsdekkende entydig og unik identifikasjon for en arealplan (pbl. 1985 &#167; 18, &#167; 20-1 andre og femte ledd og &#167; 22 og &#167; 28-2 / pbl. &#167;&#167; 6-4, 8-1, 9-1, 11-1 og &#167; 12-1, samt kart- og planforskriften &#167; 9 andre og sjette ledd) 
|Multiplisitet: 
|[1..1] 
|Type: 
|<<nasjonalarealplanid, «dataType» NasjonalArealplanId>> 
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
|<<plantype, «Union» Plantype>> 
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
|<<planstatus, «Enumeration» Planstatus>> 
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
|<<omplanbestemmelser, «Enumeration» OmPlanbestemmelser>> 
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
|<<lovreferansetype, «Enumeration» LovreferanseType>> 
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
|<<characterstring, «Union» CharacterString>> 
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
|<<forslagsstillertype, «Enumeration» ForslagsstillerType>> 
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
|<<planhøring, «dataType» Planhøring>> 
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
|<<gm_multisurface, GM_MultiSurface>> 
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
===== Roller
[cols="20,80"]
|===
|*Rollenavn:* 
|*kommentar* 
|Multiplisitet: 
|[0..*] 
|Til klasse 
|<<kommentar, «FeatureType» Kommentar>> 
|===
[cols="20,80"]
|===
|*Rollenavn:* 
|*bestemmelseSamling* 
|Multiplisitet: 
|[0..1] 
|Til klasse: 
|<<reguleringsplanbestemmelser, «featureType» Reguleringsplanbestemmelser>> 
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
|<<rpområde, «featureType» RpOmråde>> 
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
|<<plandokument, «FeatureType» Plandokument>> 
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
|<<kpområde, «featureType» KpOmråde>> 
|===
[cols="20,80"]
|===
|*Rollenavn:* 
|*planbehandling* 
|Multiplisitet: 
|[1..*] 
|Til klasse 
|<<planbehandling, «FeatureType» Planbehandling>> 
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
|<<arealplan, «featureType» Arealplan>> 
|===
 
[discrete]
===== Restriksjoner
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
===== «dataType» Planhøring
*Definisjon:* egenskapssett for å holde rede på versjoner og alternativer for planforslag legges ut til offentlig ettersyn (pbl. &#167; 11-15, &#167; 12-9)
 
 
[discrete]
===== Egenskaper
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
===== «Union» Plantype
*Definisjon:* sammensatt datatype som angir type reguleringsplan eller type kommuneplan
 
 
[discrete]
===== Egenskaper
[cols="20,80"]
|===
|*Navn:* 
|*rpPlantype* 
|Definisjon: 
|type reguleringsplan 
|Multiplisitet: 
|[1..1] 
|Type: 
|<<rpplantype, «Enumeration» RpPlantype>> 
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
|<<kpplantype, «Enumeration» KpPlantype>> 
|===
 
'''
 
[[planstatus]]
===== «Enumeration» Planstatus
*Definisjon:* kodeliste for planens behandling (pbl. 1985 &#167;&#167; 19-4, 20-5, 27-1, 27-2, 28-1 og 28-2) samt planens rettsvirkning (pbl. 1985 &#167;&#167; 19-6, 20-6, 28-2 og 31/pbl. &#167;&#167; 8-3, 8-4, 9-3, 9-4, &#167;&#167; 11-12 til 11-15, og &#167;&#167; 12-8 til 12-12)
 
 
[discrete]
===== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|Planinitiativ 
| 
|0 
|Planlegging igangsatt 
| 
|1 
|Planforslag 
| 
|2 
|Endelig vedtatt arealplan 
| 
|3 
|Opphevet 
| 
|4 
|Utgått/erstattet 
| 
|5 
|Vedtatt plan med utsatt rettsvirkning 
| 
|6 
|Overstyrt 
| 
|8 
|Avvist 
| 
|9 
|Trukket/uaktuelt 
| 
|10 
|===
 
'''
 
[[omplanbestemmelser]]
===== «Enumeration» OmPlanbestemmelser
*Definisjon:* kodeliste for om planen har bestemmelser (pbl. 1985 &#167; 20-4 andre ledd bokstav a til h og &#167; 26 / pbl. &#167;&#167; 11-9, 11-10 og 11-11, samt &#167; 12-7), og hvordan disse i så fall er representert
 
 
[discrete]
===== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|Med bestemmelser som egen tekst 
|Planbestemmelser framgår som egen tekst, men ikke på kartet 
|1 
|Uten bestemmelser 
|Planen har ingen bestemmelser, hverken på kartet eller som egen tekst 
|2 
|Planbestemmelser fremgår kun av kartet 
|Planbestemmelser fremgår kun av kartet (bygghøyder mv.) 
|3 
|Planbestemmelser både kart og tekst 
|Planbestemmelser både på kart og som egen tekst 
|4 
|===
 
'''
 
[[lovreferansetype]]
===== «Enumeration» LovreferanseType
*Definisjon:* kodeliste for hvilken lov planen er vedtatt etter
 
 
[discrete]
===== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|Før BL 1924 
|Før bygningsloven av 1924 
|1 
|BL 1924 
|Bygningsloven av 1924 
|2 
|BL 1965 
|Bygningsloven av 1965 
|3 
|PBL 1985 
|Plan- og bygningsloven av 1985 
|4 
|PBL 1985 eller før 
|Plan- og bygningsloven av 1985 eller før 
|5 
|PBL 2008 
|Plan- og bygningsloven av 2008 
|6 
|===
 
'''
 
[[forslagsstillertype]]
===== «Enumeration» ForslagsstillerType
*Definisjon:* kodeliste for om forslagsstiller er offentlig planmyndighet eller privat
 
 
[discrete]
===== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|offentlig 
| 
|1 
|privat 
| 
|2 
|===
<<<
'''
===== Underpakke: NasjonalArealplanID
*Definisjon:* 
 
'''
 
.Nasjonal ArealplanID
image::diagrammer\Nasjonal ArealplanID.png[link=diagrammer\Nasjonal ArealplanID.png, alt="Diagram som viser den sammensatte datatypen NasjonalArealplanId"]
 
'''
 
[[nasjonalarealplanid]]
===== NasjonalArealplanID::«dataType» NasjonalArealplanId
*Definisjon:* landsdekkende entydig og unik identifikasjon av en arealplan (pbl. &#167;&#167; 6-4, 9-1, og 12-1, samt kart- og planforskriften &#167; 9 andre og sjette ledd).
 
 
[discrete]
====== Egenskaper
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
|<<administrativenhetskode, «Union» AdministrativEnhetskode>> 
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
====== Restriksjoner
[cols="20,80"]
|===
|*Navn:* 
|*maksimalt 16 tegn for planid* 
|Beskrivelse: 
|Det kan anvendes maksimalt 16 tegn for planid
 
|===
 
'''
 
[[administrativenhetskode]]
===== NasjonalArealplanID::«Union» AdministrativEnhetskode
*Definisjon:* entydig identifikasjon av administrativ enhet som kan vedta en arealplan, enten en kommune, et fylke, eller staten
 
 
[discrete]
====== Egenskaper
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
|<<kommunenummer, «CodeList» Kommunenummer>> 
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
|<<fylkesnummer, «CodeList» Fylkesnummer>> 
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
|<<landkode, «Enumeration» Landkode>> 
|Profilparametre i tagged values:  
| 
SOSI_navn: LANDKODE +
|===
 
'''
 
[[kommunenummer]]
===== NasjonalArealplanID::«CodeList» Kommunenummer
*Definisjon:* ekstern kodeliste for kommunenummer.

Merknad: Det presiseres at kommune alltid skal ha 4 sifre, dvs. eventuelt med ledende null. Kommune benyttes for kopling mot en rekke andre registre som også benytter 4 sifre.
 
 
[discrete]
====== Profilparametre i tagged values
[cols="20,80"]
|===
|asDictionary 
|true 
|codeList 
|https://register.geonorge.no/sosi-kodelister/kommunenummer-alle 
|===
 
'''
 
[[fylkesnummer]]
===== NasjonalArealplanID::«CodeList» Fylkesnummer
*Definisjon:* ekstern kodeliste for kommunenummer.

Merknad: Det presiseres at kommune alltid skal ha 4 sifre, dvs. eventuelt med ledende null. Kommune benyttes for kopling mot en rekke andre registre som også benytter 4 sifre.
 
 
[discrete]
====== Profilparametre i tagged values
[cols="20,80"]
|===
|asDictionary 
|true 
|codeList 
|https://register.geonorge.no/sosi-kodelister/fylkesnummer-alle 
|===
 
'''
 
[[landkode]]
===== NasjonalArealplanID::«Enumeration» Landkode
*Definisjon:* alfanumerisk kode for nasjonalt nivå / Norge.

Avledet fra "ISO 3166 Codes for the representation of names of countries and their subdivisions"
 
 
[discrete]
====== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|Norge 
| 
|NO 
|===
<<<
'''
==== Pakke: Plankart felles
*Definisjon:* pakke med klasser som er felles for reguleringsplan og kommuneplan
 
'''
 
.Kartobjekt
image::diagrammer\Kartobjekt.png[link=diagrammer\Kartobjekt.png, alt="Diagram som viser den abstrakte objekttypen Kartobjekt, som omfatter alle typer kartobjekter i en arealplan"]
 
'''
 
.Kodelister og datatpyer
image::diagrammer\Kodelister og datatpyer.png[link=diagrammer\Kodelister og datatpyer.png, alt="Diagram som viser kodelister og datatyper som er felles for begge plantyper, etter begge lover"]
 
'''
 
.Hoveddiagram Påskrift
image::diagrammer\Hoveddiagram Påskrift.png[link=diagrammer\Hoveddiagram Påskrift.png, alt="Diagram som viser objekttypen P&#229;skrift"]
 
'''
 
[[kartobjekt]]
===== _«featureType» Kartobjekt (abstrakt)_
*Definisjon:* Abstrakt supertype som omfatter alle type kartobjekter i en  arealplan.

Den er bærer av assosiasjoner til hhv Arealplanobjektet og til evt. påskrifter.

Produktspesifikasjonene må spesifisere og avgrense hvilke påskrifter som er tillatt for de enkelte type kartobjekter.
 
 
[discrete]
===== Egenskaper
[cols="20,80"]
|===
|*Navn:* 
|*nasjonalArealplanId* 
|Definisjon: 
|landsdekkende entydig og unik identifikasjon for en arealplan (pbl. 1985 &#167; 18, &#167; 20-1 andre og femte ledd og &#167; 22 og &#167; 28-2 / pbl. &#167;&#167; 6-4, 8-1, 9-1, 11-1 og &#167; 12-1, samt kart- og planforskriften &#167; 9 andre og sjette ledd)

Hvert kartobjekt skal ha en referanse til den arealplanen de tilhører. Brukt som koblingsnøkkel fungerer denen egenskapen som en realisering av assosiasjonen til Arealplanobjektet. Forøvrig kan den avledes fra Arealplan 
|Multiplisitet: 
|[0..1] 
|Type: 
|<<nasjonalarealplanid, «dataType» NasjonalArealplanId>> 
|===
 
[discrete]
===== Roller
[cols="20,80"]
|===
|*Rollenavn:* 
|*arealplan* 
|Multiplisitet: 
|[1] 
|Til klasse 
|<<arealplan, «featureType» Arealplan>> 
|===
[cols="20,80"]
|===
|*Rollenavn:* 
|*påskrift* 
|Multiplisitet: 
|[0..*] 
|Til klasse 
|<<påskrift, «featureType» Påskrift>> 
|===
 
[discrete]
===== Arv og realiseringer
[cols="20,80"]
|===
|Subtyper: 
| 
<<rpområde, «featureType» RpOmråde>> +
<<rpregulerthøyde, «featureType» RpRegulertHøyde>> +
<<rpjuridisklinje, «featureType» RpJuridiskLinje>> +
<<rpbestemmelsemidlbygganlegg, «featureType» RpBestemmelseMidlByggAnlegg>> +
<<rpbestemmelseområde, «FeatureType» RpBestemmelseOmråde>> +
<<rpgrense, «featureType» RpGrense>> +
<<rparealformålområde, «FeatureType» RpArealformålOmråde>> +
<<rpbestemmelseregterreng, «featureType» RpBestemmelseRegTerreng>> +
<<rpjuridiskpunkt, «featureType» RpJuridiskPunkt>> +
<<rphensynsone, «featureType» RpHensynSone>> +
<<rpformålgrense, «featureType» RpFormålGrense>> +
<<rphandlingområde, «featureType» RpHandlingOmråde>> +
<<rbrekkefølgeområde, «featureType» RbRekkefølgeOmråde>> +
<<rbfornyelseområde, «featureType» RbFornyelseOmråde>> +
<<rbrestriksjonområde, «featureType» RbRestriksjonOmråde>> +
<<rbbevaringområde, «featureType» RbBevaringOmråde>> +
<<rbfareområde, «featureType» RbFareOmråde>> +
<<rbformålområde, «featureType» RbFormålOmråde>> +
<<kpsamferdselpunkt, «featureType» KpSamferdselPunkt>> +
<<kpsamferdsellinje, «featureType» KpSamferdselLinje>> +
<<kpretningslinjeområde, «featureType» KpRetningslinjeOmråde>> +
<<kprestriksjonområde, «featureType» KpRestriksjonOmråde>> +
<<kparealbrukområde, «featureType» KpArealbrukOmråde>> +
<<kparealgrense, «featureType» KpArealGrense>> +
<<kparealformålområde, «featureType» KpArealformålOmråde>> +
<<kpgrense, «featureType» KpGrense>> +
<<kphensynsone, «featureType» KpHensynSone>> +
<<kpjuridisklinje, «featureType» KpJuridiskLinje>> +
<<kpinfrastrukturlinje, «featureType» KpInfrastrukturLinje>> +
<<kpregulerthøyde, «featureType» KpRegulertHøyde>> +
<<kpbestemmelseområde, «featureType» KpBestemmelseOmråde>> +
<<påskrift, «featureType» Påskrift>> +
<<kpområde, «featureType» KpOmråde>> +
|===
 
'''
 
[[påskrift]]
===== «featureType» Påskrift
*Definisjon:* supplerende tekst til 
regulerings- og bebyggelsesplan (pbl. 1985 &#167;&#167; 25 og 26 og 28-2) / områderegulering og detaljregulering (pbl. &#167;&#167; 12-2, 12-3, 12-5 og 12-7)
eller til 
kommune (-del) plan (pbl. 1985 &#167; 20-4 første ledd, eller pbl. &#167; 11-7 andre ledd)

 
 
[discrete]
===== Egenskaper
[cols="20,80"]
|===
|*Navn:* 
|*tekststreng* 
|Definisjon: 
|påskriftens tekstlige innhold
 
|Multiplisitet: 
|[1..1] 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/CharacterString[CharacterString] 
|===
[cols="20,80"]
|===
|*Navn:* 
|*påskriftType* 
|Definisjon: 
|hva påskriften i plankartet omhandler.

Det må være samsvar mellom denne egenskapen og det kartobjektet som påskriften refererer til. 
|Multiplisitet: 
|[0..1] 
|Type: 
|<<påskrifttype, «Enumeration» PåskriftType>> 
|Profilparametre i tagged values:  
| 
SOSI_navn: RPPÅSKRIFTTYPE +
|===
[cols="20,80"]
|===
|*Navn:* 
|*posisjon* 
|Definisjon: 
|representasjonspunkt som knytter påskriften geometrisk til et annet kartobjekt.

Svarer til 1. koordinat fra SOSI-formatets .TEKST-geometri 
|Multiplisitet: 
|[0..1] 
|Type: 
|<<gm_point, GM_Point>> 
|===
[cols="20,80"]
|===
|*Navn:* 
|*tekstplassering* 
|Definisjon: 
|plassering av påskriften, representert ved punkt eller linje

Svarer til koordinat nr 2 og utover fra SOSI-formatets .TEKST-geometri. Den første koordinaten representerer tekstens startpunkt, ved bunnlinja av teksten. Dersom det er brukt punktgeometri, følger teksten vannrett ut fra startpunktet. Dersom det er brukt linjegeometri, følger teksten denne linja ut fra startpunktet.




 
|Multiplisitet: 
|[0..1] 
|Type: 
|<<gm_primitive, «dataType» GM_Primitive>> 
|===
[cols="20,80"]
|===
|*Navn:* 
|*formatering* 
|Definisjon: 
|hvordan påskriften skal formateres
Svarer til presentasjonsegenskapene i SOSI-formatets .TEKST-geometri

 
|Multiplisitet: 
|[0..1] 
|Type: 
|<<tekstformatering, «dataType» Tekstformatering>> 
|===
 
[discrete]
===== Arv og realiseringer
[cols="20,80"]
|===
|Supertype:  
|<<kartobjekt, «featureType» Kartobjekt>> 
|===
 
'''
 
[[utnytting]]
===== «dataType» Utnytting
*Definisjon:* grad av utnytting (pbl. 1985 &#167;&#167; 20-4 annet ledd bokstav b, 26 første ledd og forskrift TEK kap III, pbl. &#167; 12-7 første ledd nr 5 og TEK17 kap. 5)
 
 
[discrete]
===== Egenskaper
[cols="20,80"]
|===
|*Navn:* 
|*utnyttingstype* 
|Definisjon: 
|type grad av utnytting (pbl. 1985 &#167;&#167; 20-4 annet ledd bokstav b, 26 første ledd og forskrift TEK kap. III) 
|Multiplisitet: 
|[1..1] 
|Type: 
|<<utnyttingstype, «Enumeration» Utnyttingstype>> 
|Profilparametre i tagged values:  
| 
SOSI_navn: UTNTYP +
|===
[cols="20,80"]
|===
|*Navn:* 
|*utnyttingstall* 
|Definisjon: 
|tallverdi for grad av utnytting (pbl. 1985 &#167;&#167; 20-4 annet ledd bokstav b, 26 første ledd og forskrift TEK kap. III) 
|Multiplisitet: 
|[0..1] 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/Integer[Integer] 
|Profilparametre i tagged values:  
| 
SOSI_navn: UTNTALL +
|===
[cols="20,80"]
|===
|*Navn:* 
|*utnyttingstall_minimum* 
|Definisjon: 
|tallverdi for minste utnyttingsgrad (pbl. &#167;12-7 første ledd nr 5 og TEK10 kap 5 ) 
|Multiplisitet: 
|[0..1] 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/Integer[Integer] 
|Profilparametre i tagged values:  
| 
SOSI_navn: UTNTALL_MIN +
|===
 
[discrete]
===== Restriksjoner
[cols="20,80"]
|===
|*Navn:* 
|*Bruk av utnyttingstall* 
|Beskrivelse: 
|/* utnyttingstall og utnyttingstall_minimum skal ikke brukes for utnyttingstype 10 og 11, men er påkrevd for alle andre utnyttingstyper  */

INV: (utnyttingstype = 10 OR utnyttingstype = 11) XOR (utnyttingstall.nonEmpty() OR utnyttingstall_minimum.nonEmpty() )
 
|===
 
[discrete]
===== Restriksjoner
[cols="20,80"]
|===
|*Navn:* 
|*Utnyttingstype for nyere planer* 
|Beskrivelse: 
|For planer etter gjeldende pbl er utnyttingstype begrensa til (10, 11, 15, 16, 17, 18) 
|===
 
'''
 
[[vertikallag]]
===== «dataType» Vertikallag
*Definisjon:* egenskaper for å identifisere, plassere og skille mellom vertikale lag i samme vertikalnivå
 
 
[discrete]
===== Egenskaper
[cols="20,80"]
|===
|*Navn:* 
|*lag* 
|Definisjon: 
|identifiserer vertikallag innen samme vertikalnivå. 
Brukes der det er flere planområder innen ett vertikalnivå 
|Multiplisitet: 
|[1..1] 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/CharacterString[CharacterString] 
|===
[cols="20,80"]
|===
|*Navn:* 
|*referansehøyde* 
|Definisjon: 
|nærmere spesifikasjon av høydenivået for et vertikallag 
 
|Multiplisitet: 
|[0..1] 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/Real[Real] 
|===
 
'''
 
[[påskrifttype]]
===== «Enumeration» PåskriftType
*Definisjon:* kode for å angi hva påskrift/nødvendig tekst i plankartet omhandler 
Lagt til suoertypene Kartobjekt og Påskrift
 
 
[discrete]
===== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|arealformål 
|Arealformål 
|1 
|feltnavn 
|Feltnavn 
|2 
|areal 
|Areal 
|3 
|planId 
|PlanId 
|4 
|utnytting 
|Utnytting 
|5 
|målsetting 
|Målsetting 
|6 
|radius 
|Radius 
|7 
|kotehøyde 
|Kotehøyde 
|8 
|plantilbehør 
|Plantilbehør 
|9 
|===
 
'''
 
[[utnyttingstype]]
===== «Enumeration» Utnyttingstype
*Definisjon:* kodeliste for type utnyttingsgrad (pbl. 1985 &#167;&#167; 20-4 annet ledd bokstav b, 26 første ledd og forskrift TEK kap. III, pbl. &#167;12-7 første ledd nr 5 og TEK17 kap. 5)

 
 
[discrete]
===== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|BYA-87 
|Tillatt bebygd areal i prosent etter byggeforskrift 1987 
|1 
|BRA-87 
|Tillatt bruksareal i kvm etter byggeforskrift 1987 
|2 
|TU 
|Tillatt tomteutnyttelse i prosent 
|3 
|U 
|Tillatt grad av utnytting (byggeforskrift 1985 og tidligere) 
|4 
|F 
|Tillatt flateutnyttelse i prosent 
|5 
|BGA 
|Brutto gulvareal (BGA i kvm) 
|6 
|BFA 
|Bebygd flate (BFA i kvm) 
|7 
|Ikke tillatt å bebygge 
| 
|10 
|Ikke tillatt med ytterligere bebyggelse 
| 
|11 
|%-BYA-97 
|Tillatt bebygd areal i prosent etter byggeforskrift 1997 
|12 
|T-BRA 
|Tillatt bruksareal i kvm etter byggeforskrift 1997 
|13 
|%-TU 
|Prosent tomteutnyttelse etter byggeforskrift 1997 
|14 
|BYA 
|Bebygd areal i kvm etter TEK 2007/TEK17 
|15 
|%-BYA 
|Bebygd areal i prosent etter TEK 2007/TEK17 
|16 
|BRA 
|Bruksareal i kvm etter TEK 2007/TEK17 
|17 
|%-BRA 
|Prosent bruksareal etter TEK 2007/TEK17 
|18 
|===
 
'''
 
[[vertikalnivå]]
===== «Enumeration» Vertikalnivå
*Definisjon:* kodeliste for planområdets beliggenhet i forhold til jordoverflaten (pbl. &#167; 19-1 sjette ledd, &#167; 20-1 andre og femte ledd og &#167; 22 og &#167; 28-2)
 
 
[discrete]
===== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|Under grunnen (tunnel) 
|Under bakken, f.eks. tunnel. 
|1 
|På grunnen/vannoverflate 
|På bakken eller på vannoverflata 
|2 
|Over grunnen (bru) 
|Over bakken, f.eks. bru. 
|3 
|På bunnen (vann/sjø) 
|På bunnen av sjø eller innsjø 
|4 
|I vannsøylen 
|I vannsøylen 
|5 
|===
 
'''
 
[[eierformtype]]
===== «Enumeration» EierformType
*Definisjon:* kodeliste for eierform.
Eierform henviser til planbestemmelse om arealet skal brukes av det offentlige, eller være fellesarealer for flere eiendommer (pbl. &#167; 11-10 nr. 3 og &#167; 12-7 nr. 14)
 
 
[discrete]
===== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|offentlig 
| 
|1 
|felles 
| 
|2 
|annen eierform 
|Hverken hjemlet i pbl. &#167; 11-10 nr. 3 eller &#167; 12-7 nr. 14. Brukes som default verdi for arealer som ikke har kodeverdi 1 eller 2. 
|3 
|===
<<<
'''
===== Underpakke: Pbl2008
*Definisjon:* pakke med klasser som er felles for reguleringsplan og kommuneplan, men spesifikke for pbl2008
 
'''
 
.HensynSone kodelister
image::diagrammer\HensynSone kodelister.png[link=diagrammer\HensynSone kodelister.png, alt="Diagram som viser kodelister for hensysnsoner"]
 
'''
 
.HøydeFraPlanbestemmelse
image::diagrammer\HøydeFraPlanbestemmelse.png[link=diagrammer\HøydeFraPlanbestemmelse.png, alt="Diagram som viser den sammensatte datatypen h&#248;ydeFraPlanbestemmelse"]
 
'''
 
[[høydefraplanbestemmelse]]
===== Pbl2008::«dataType» HøydeFraPlanbestemmelse
*Definisjon:* regulert høyde gitt i planbestemmelser (bestemmelse om utforming illustrert på kart, pbl. &#167; 12-7 nr. 1)
 
 
[discrete]
====== Egenskaper
[cols="20,80"]
|===
|*Navn:* 
|*regulerthøyde* 
|Definisjon: 
|tall for kotehøyde eller høyde over terreng ved bestemmelse om regulert høyde 
|Multiplisitet: 
|[1..1] 
|Type: 
|http://skjema.geonorge.no/SOSI/basistype/Real[Real] 
|Profilparametre i tagged values:  
| 
SOSI_navn: REGULERTHØYDE +
|===
[cols="20,80"]
|===
|*Navn:* 
|*typeHøyde* 
|Definisjon: 
|egenskap som angir hva planbestemmelsen regulerer høyden av 
|Multiplisitet: 
|[0..1] 
|Type: 
|<<typehøyde, «Enumeration» TypeHøyde>> 
|===
[cols="20,80"]
|===
|*Navn:* 
|*høydereferansesystem* 
|Definisjon: 
|referansesystem som høydeverdiene refererer til. 

Offisielt høydereferansesystem i Norge er NN2000, men eldre planer kan ha brukt et eldre høydereferansesystem 
 
|Multiplisitet: 
|[0..1] 
|Type: 
|<<høydereferansesystem, «codeList» Høydereferansesystem>> 
|Profilparametre i tagged values:  
| 
SOSI_navn: HØYDE-REF +
|===
[cols="20,80"]
|===
|*Navn:* 
|*terrengreferanse* 
|Definisjon: 
|referanseflate som er utgangspunktet for å angi høyde over terreng. 

Kan bare brukes for gesimshøyde og mønehøyde
 
|Multiplisitet: 
|[0..1] 
|Type: 
|<<terrengreferanse, «Enumeration» Terrengreferanse>> 
|===
 
[discrete]
====== Restriksjoner
[cols="20,80"]
|===
|*Navn:* 
|*Betingelse for bruk av terrengreferanse* 
|Beskrivelse: 
|Terrengreferanse kan brukes i steden for høydereferansesystem dersom typeHøyde er gesims- eller mønehøyde.

INV: ( høydereferansesystem-&gt;nonEmpty() AND terrengreferanse-&gt;isEmpty() )
OR ( terrengreferanse-&gt;nonEmpty() AND  høydereferansesystem-&gt;isEmpty() 
AND typehøyde-&gt;nonEmpty() AND (typeHøyde = 'TH' OR typeHøyde = 'PH')   )

 
|===
 
'''
 
[[typehøyde]]
===== Pbl2008::«Enumeration» TypeHøyde
*Definisjon:* koder som angir hva slags høyde som er regulert 
 
 
[discrete]
====== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|gesimshøyde 
| 
|GH 
|mønehøyde 
| 
|MH 
|terrenghøyde 
| 
|TH 
|planeringshøyde 
| 
|PH 
|===
 
'''
 
[[terrengreferanse]]
===== Pbl2008::«Enumeration» Terrengreferanse
*Definisjon:* liste over type terrengoverflate som kan være utgangspunkt for å angi høyde over terreng
 
 
[discrete]
====== Profilparametre i tagged values
[cols="20,80"]
|===
|asDictionary 
|false 
|SOSI_datatype 
|T 
|SOSI_lengde 
|6 
|SOSI_navn 
|HØYDE-REF 
|===
 
[discrete]
====== Koder i modellen
[cols="20,80"]
|===
|*Navn:* 
|*Definisjon:* 
|ferdigPlanertTerreng 
| 
|gatenivå 
| 
|eksistrendeTerreng 
| 
|===
 
'''
 
[[kpsikringsonetype]]
===== Pbl2008::«Enumeration» KpSikringSoneType
*Definisjon:* kode for sikring i hensynsone for sikring i kommuneplan (pbl. &#167; 11-8, tredje ledd bokstav a)
 
 
[discrete]
====== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|Nedslagsfelt drikkevann 
| 
|110 
|Område for grunnvannsforsyning 
| 
|120 
|Byggeforbud rundt veg, bane og flyplass 
| 
|130 
|Andre sikringssoner 
| 
|190 
|===
 
'''
 
[[rpsikringsonetype]]
===== Pbl2008::«Enumeration» RpSikringSoneType
*Definisjon:* kode for sikring i hensynsone for sikring i reguleringsplan (pbl. &#167; 12-6, jf. &#167; 11-8 tredje ledd bokstav a)
 
 
[discrete]
====== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|Nedslagsfelt drikkevann 
| 
|110 
|Område for grunnvannsforsyning 
| 
|120 
|Byggeforbud rundt veg, bane og flyplass 
| 
|130 
|Andre sikringssoner 
| 
|190 
|Frisikt 
|Frisiktsone ihht vegloven 
|140 
|===
 
'''
 
[[støysonetype]]
===== Pbl2008::«Enumeration» StøySoneType
*Definisjon:* kode for støy i hensynsone for støy (pbl. &#167; 11-8, tredje ledd bokstav a)
 
 
[discrete]
====== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|Rød sone 
|Rød sone iht. T-1442 
|210 
|Gul sone 
|Gul sone iht. T-1442 
|220 
|Grønn sone 
|Grønn sone iht. T-1442 
|230 
|Andre støysoner 
|Andre støysoner 
|290 
|===
 
'''
 
[[faresonetype]]
===== Pbl2008::«Enumeration» FareSoneType
*Definisjon:* kode for fare i hensynssone for fare (pbl. &#167; 11-8, tredje ledd bokstav a)
 
 
[discrete]
====== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|Ras- og skredfare 
| 
|310 
|Flomfare 
| 
|320 
|Radon 
| 
|330 
|Brann-/eksplosjonsfare 
| 
|350 
|Skytebane 
| 
|360 
|Høyspenningsanlegg (inkl høyspentkabler) 
| 
|370 
|Sone for militær virksomhet 
| 
|380 
|Annen fare 
| 
|390 
|===
 
'''
 
[[infrastruktursonetype]]
===== Pbl2008::«Enumeration» InfrastrukturSoneType
*Definisjon:* kode for infrastrukturkrav i hensynsone for infrastruktur (pbl. &#167; 11-8, tredje ledd bokstav b)
 
 
[discrete]
====== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|Krav vedrørende infrastruktur 
| 
|410 
|Rekkefølgekrav infrastruktur 
| 
|430 
|Rekkefølgekrav samfunnservice 
| 
|440 
|Rekkefølgekrav grønnstruktur 
| 
|450 
|===
 
'''
 
[[angitthensynsonetype]]
===== Pbl2008::«Enumeration» AngittHensynSoneType
*Definisjon:* kode for angitt hensyn i hensynssone for nærmere angitt hensyn  (11-8 tredje ledd bokstav c)
 
 
[discrete]
====== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|Hensyn landbruk 
| 
|510 
|Hensyn reindrift 
| 
|520 
|Hensyn friluftsliv 
| 
|530 
|Hensyn grønnstruktur 
| 
|540 
|Hensyn landskap 
| 
|550 
|Bevaring naturmiljø 
| 
|560 
|Bevaring kulturmiljø 
| 
|570 
|Randområder til verneområde 
|Randområder til nasjonalpark/landskapsvernområde 
|580 
|Sikring av mineralressurser 
|hensynssone for sikring av mineralressurser 
|590 
|===
 
'''
 
[[båndleggingsonetype]]
===== Pbl2008::«Enumeration» BåndleggingSoneType
*Definisjon:* kode for båndlegging i hensynssone for båndlegging (pbl. &#167; 11-8 tredje ledd bokstav d)
 
 
[discrete]
====== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|Båndlegging for regulering etter pbl. 
| 
|710 
|Båndlegging etter naturvernloven 
|Båndlegging etter lov om naturvern 
|720 
|Båndlegging etter kulturminneloven 
|Båndlegging etter lov om kulturminner 
|730 
|Båndlegging etter markaloven 
|Båndlegging etter lov om naturområder i Oslo og nærliggende kommuner (markalovn) 
|735 
|Båndlegging etter andre lover 
| 
|740 
|Båndlegging etter vegloven 
|Båndlegging i henhold til avkjøringsklasser etter vegloven 
|750 
|Båndlegging - generalisert (utgått) 
|Ikke tillatt brukt på planer vedtatt iht. SOSI 4.5 eller nyere 
|700 
|===
 
'''
 
[[gjennomføringsonetype]]
===== Pbl2008::«Enumeration» GjennomføringSoneType
*Definisjon:* kode for gjennomføringsvirkemidler i gjennomføringssone (pbl. &#167; 11-8 tredje ledd bokstav e andre ledd)
 
 
[discrete]
====== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|Krav om felles planlegging 
| 
|810 
|Omforming 
| 
|820 
|Fornyelse 
| 
|830 
|Krav om felles planlegging, omforming og fornyelse - generalisert (utgått) 
|Ikke tillatt brukt på planer vedtatt iht. SOSI 4.5 eller nyere 
|800 
|===
 
'''
 
[[detaljeringsonetype]]
===== Pbl2008::«Enumeration» DetaljeringSoneType
*Definisjon:* kode for detaljering i detaljeringssone - videreføring av gjeldende reguleringsplan (pbl. &#167; 11-8 tredje ledd bokstav f)
 
 
[discrete]
====== Koder i modellen
[cols="25,60,15"]
|===
|*Kodenavn:* 
|*Definisjon:* 
|*Utvekslingsalias:* 
|Reguleringsplan skal fortsatt gjelde 
| 
|910 
|Reguleringsplan skal fortsatt gjelde - generalisert (utgått) 
|Ikke tillatt brukt på planer vedtatt iht. SOSI 4.5 eller nyere 
|900 
|===
// End of UML-model
