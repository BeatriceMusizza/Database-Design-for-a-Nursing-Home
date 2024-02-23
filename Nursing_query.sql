-- Query 1

select nome,cognome
from ospiti
where extract (month from datanascita) = 2

-- Query 2

select count(ospiti.CF) as OspitiAccoltiNel2022, count(ospitideceduti.CF) as OspitiDecedutiNel2022
from ospiti natural join ospitideceduti
where EXTRACT (YEAR from CURRENT_date)-extract (year from dataaccoglienza)=1
or EXTRACT (YEAR from CURRENT_date)-extract (year from datadecesso)=1

-- Query 2.2

select count(*) as OspitiAccoltiNel2022
from ospiti
where CURRENT_date dataaccoglienza < 365
select count(*) as OspitiDecedutiNel2022
from ospitideceduti
where CURRENT_date datadecesso < 365

-- Query 3
--Per i sanissimi trovare gli ospiti per i quali non esiste neanche una diagnosi con collegata --una prescrizione.

select cf, nome,cognome
from ospiti
where cf not in (select cfospite
from ricoveriattuali) and cf not in (select cfospite
from ricoveripassati) and cf not in (select ospite
from diagnosi natural join prescrizionifarmaci)

-- Query 4

select distinct ospite1.cf,ospite1.nome,ospite1.cognome 
from ospiti as ospite1 cross join ospiti as ospite2 
where ospite1.numerostanza=ospite2.numerostanza
and ospite1.cf!=ospite2.cf and ospite1.nome=ospite2.nome

-- Query 5

--Si cercano gli ospiti il cui ultimo tampone ha avuto esito positivo.
select cf,nome,cognome
from ospiti join tamponieffettuatiospiti as t1 on CF=Ospite where data=(select max(data)
from tamponieffettuatiospiti
where t1.ospite=tamponieffettuatiospiti.ospite)
and esito

-- Query 6

select distinct nome,cognome,numeroditelefono 
from parenti join visite on CF=CFParente
where current_date - data <15

-- Query Medico 
select ospiti.nome as nomeospite, ospiti.cognome as cognomeospite, ospite as cfospite, medico as cfmedico from rapportimedici join medici on medico=medici.cf
join ospiti on ospite=ospiti.cf
where (medico,ospite) not in (select medico,ospite
from visitemediche
where current_date- data < 30)

-- Query Infermiere 1
--Cerchiamo tutti i farmaci attualmente prescritti
--con la cadenza prevista e lultima volta in cui
--sono stati somministrati, in modo che si possa
--verificare se il momento di unaltra somministrazione.

select nome,cognome,codicefarmaco, ora AS oraultimasomministrazione, data AS dataultimasomministrazione, cadenza from ospiti join diagnosi on cf=ospite
natural join prescrizionifarmaci natural join somministrazionefarmaci as s1 where prescrizionifarmaci.attiva
and data= (select max(data)
from somministrazionefarmaci
   where s1.codicefarmaco=somministrazionefarmaci.codicefarmaco)

-- Query Infermiere 2

select Ospiti.cf, ospiti.nome, ospiti.cognome
from TamponiEffettuatiOspiti join ospiti on ospite=cf
where current_date-data >30

-- Query OSS

select cf,nome,cognome,codicemansione
from ComposizionePiani join PianiAssistenza on CodicePiano=Codice
join Ospiti on ospite=cf join mansioni on Codicemansione=mansioni.codice where mese='Gennaio'
and (mansioni.cadenza='giornaliera')
and (mansioni.codice,ospite) not in (select codicemansione,ospite
from prestazioni join mansioni on codicemansione=codice and cadenza='giornaliera'
where data=current_date or (current_date-data=1
and extract (hour from current_time) - extract (hour from ora)<0))
or (mansioni.cadenza='settimanale'
and (mansioni.codice,ospite) not in (select codicemansione,ospite
from prestazioni
join mansioni on codicemansione=codice and cadenza='settimanale'
where current_date-data < 31))