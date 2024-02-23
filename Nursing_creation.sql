-- Table Creation and Population

create table Citta
(
    Nome varchar(40),
    Provincia varchar(40),
    Nazione varchar(40),
    primary key (Nome , Provincia)
);

create table LuoghiProvenienza
(
    Indirizzo varchar(40),
    CittaNome varchar(40),
    CittaProvincia varchar(40),
    primary key (Indirizzo,CittaNome, CittaProvincia),
    foreign key (CittaNome, CittaProvincia) references Citta (Nome, Provincia)
);

create table DomiciliPrivatiDiProvenienza
(
    Indirizzo varchar(40),
    CittaNome varchar(40),
    CittaProvincia varchar(40),
    primary key (Indirizzo,CittaNome, CittaProvincia),
    foreign key (CittaNome, CittaProvincia) references Citta (Nome, Provincia)
);

create table StruttureDiProvenienza
(
    Indirizzo varchar(40),
    CittaNome varchar(40),
    CittaProvincia varchar(40),
    Nome varchar(40),
    DataApertura date,
    CodiceRegionale char(4),
    primary key (Indirizzo,CittaNome, CittaProvincia),
    foreign key (CittaNome, CittaProvincia) references Citta (Nome, Provincia)
);

create table Diete
(
    Tipo varchar(40) primary key
);

create table Ospiti
(
    CF char(16) primary key,
    Nome varchar(40),
    Cognome varchar(40),
    NumeroStanza int,
    LivelloAutosufficienza int,
    CittaNascitaNome varchar(40),
    CittaNascitaProvincia varchar(40),
    DataNascita date,
    DataAccoglienza date,
    LuogoProvenienzaIndirizzo varchar(40),
    LuogoProvenienzaCittaNome varchar(40),
    LuogoProvenienzaCittaProvincia varchar(40),
    foreign key (CittaNascitaNome, CittaNascitaProvincia) references Citta (Nome, Provincia),
    foreign key (LuogoProvenienzaIndirizzo, LuogoProvenienzaCittaNome, LuogoProvenienzaCittaProvincia) references LuoghiProvenienza (Indirizzo, CittaNome, CittaProvincia)
);

create table OspitiDeceduti
(
    CF char(16) primary key references Ospiti(CF),
    DataDecesso date
);

create table OspitiInVita
(
    CF char(16) primary key references Ospiti(CF),
    DietaAttuale varchar(40) references Diete(Tipo),
    DataInizioDieta date,
    Somministrazione varchar(30)
);

create table Ospedali
(
    Nome varchar (60),
    CittaNome varchar(40),
    CittaProvincia varchar(40),
    primary key (Nome, CittaNome, CittaProvincia),
    foreign key (CittaNome, CittaProvincia) references Citta (Nome, Provincia)
);

create table RicoveriAttuali(
 CFOspite char (16) references OspitiInVita (CF),
 NomeOspedale varchar (60),
 CittaOspedaleNome varchar(40),
 CittaOspedaleProvincia varchar(40),
 DataInzioRicovero date,
 primary key (CFOspite, NomeOspedale, CittaOspedaleNome, CittaOspedaleProvincia),
 foreign key (NomeOspedale, CittaOspedaleNome, CittaOspedaleProvincia) references Ospedali (Nome,CittaNome,CittaProvincia)
 );

 create table RicoveriPassati
(
CFOspite char (16) references Ospiti(CF),
 NomeOspedale varchar (60),
 CittaOspedaleNome varchar(40),
 CittaOspedaleProvincia varchar(40),
 DataInizioRicovero date,
 DataDimissioni date, primary key (CFOspite, NomeOspedale, CittaOspedaleNome, CittaOspedaleProvincia,DataInizioRicovero ),
 foreign key (NomeOspedale, CittaOspedaleNome, CittaOspedaleProvincia) references Ospedali (Nome,CittaNome,CittaProvincia)
 );
create table DietePassate
(
    CFOspite char (16) references Ospiti(CF),
    TipoDieta varchar(40),
    DataInizio date,
    DataFine date,
    primary key (CFOspite, TipoDieta, DataInizio),
    foreign key (TipoDieta) references Diete(Tipo)
);

insert into Citta values
('Trieste', 'Trieste', 'Italia'),
('Este', 'Padova', 'Italia'),
('Codroipo', 'Udine', 'Italia');

insert into LuoghiProvenienza values
('Via Foralnini 131', 'Trieste', 'Trieste'),
('Via Carducci 42', 'Este', 'Padova'),
('Via Marchesetti 37', 'Trieste', 'Trieste');

insert into DomiciliPrivatiDiProvenienza values
('Via Foralnini 131', 'Trieste', 'Trieste'),
('Via Carducci 42', 'Este', 'Padova');

insert into StruttureDiProvenienza values
('Via Marchesetti 37', 'Trieste', 'Trieste', 'Casa Serena', '01-MAY-1987', '0001');

insert into Diete values
('Regolare'),
('Ipoglicidica'),
('Iposodica'),
('Ipoproteica'),
('Vegetariana');

insert into Ospiti values
('RVSNVK90B07I122X', 'Ettore', 'Siciliano', 34, 1, 'Trieste', 'Trieste', '10-MAY-1950', '12-MAY-2020', 'Via Foralnini 131', 'Trieste', 'Trieste'),
('DXLSPM52A02G600G', 'Arsenio', 'Lo Duca', 21, 2, 'Este', 'Padova', '7-FEB-1942', '13-MAY-2022', 'Via Carducci 42', 'Este', 'Padova'),
('ZBTFQF51L65F174I', 'Dorotea', 'Lombardi', 12, 3, 'Codroipo', 'Udine', '8-JUL-1932', '14-JUN-2022', 'Via Marchesetti 37', 'Trieste', 'Trieste'),
('JCVHSS97E48B744F', 'Ettore', 'Cociani', 34, 3, 'Trieste', 'Trieste', '1-MAY-1950', '8-MAY-2005', 'Via Foralnini 131', 'Trieste', 'Trieste');

insert into OspitiDeceduti values
('RVSNVK90B07I122X', '5-MAY-2022'),
('JCVHSS97E48B744F', '7-MAY-2022');

insert into OspitiInVita values
('DXLSPM52A02G600G', 'Regolare', '29-JUN-2022', 'Frullata'),
('ZBTFQF51L65F174I', 'Vegetariana', '24-JUN-2022', 'Intera');

insert into Ospedali values
('Ospedale di Cattinara', 'Trieste', 'Trieste'),
('Ospedale Maggiore', 'Trieste', 'Trieste');

insert into RicoveriAttuali values
('DXLSPM52A02G600G', 'Ospedale di Cattinara', 'Trieste', 'Trieste', '7-DEC-2022');

insert into RicoveriPassati values
('DXLSPM52A02G600G', 'Ospedale Maggiore', 'Trieste', 'Trieste', '7-DEC-2002', '7-FEB-2003'),
('RVSNVK90B07I122X', 'Ospedale di Cattinara', 'Trieste', 'Trieste', '7-NOV-2005', '3-FEB-2006');

insert into DietePassate values
('RVSNVK90B07I122X', 'Ipoproteica', '10-MAY-2021', '10-OCT-2021'),
('DXLSPM52A02G600G', 'Iposodica', '7-FEB-2004', '23-OCT-2021'),
('ZBTFQF51L65F174I', 'Regolare', '17-MAY-2004', '23-JUN-2020');

create table Parenti
(
    CF char(16) primary key,
    Nome varchar(40),
    Cognome varchar(40),
    DataNascita date,
    NumeroDiTelefono varchar(20),
    CittaResidenzaNome varchar(40),
    CittaResidenzaProvincia varchar(40),
    foreign key (CittaResidenzaNome, CittaResidenzaProvincia) references Citta (Nome, Provincia)
);

create table Parentele
(
    CFOspite char(16),
    CFParente char(16),
    Grado varchar(30),
    primary key (CFOspite, CFParente)
);

create table Visite
(
    CFParente char(16) references Parenti (CF),
    CFOspite char(16) references Ospiti (CF),
    PortinaioControllo char(16),
    Data date,
    Orainizio time,
    primary key (CFParente, CFOspite, Data)
);

insert into Parenti values
('FLNYDF98T68A825A', 'Rosalia', 'Marcelo', '19-MAR-2002', '0351 1278023', 'Trieste', 'Trieste'),
('YLTFFH56C25L048S', 'Manuela', 'Bruno', '26-OCT-1982', '0358 3849175', 'Trieste', 'Trieste'),
('VLBXVR31E50G041B', 'Lidia', 'Gallo', '16-JUN-1982', '0324 5871722', 'Trieste', 'Trieste'),
('SFQTBM62E63C879M', 'Artemisia', 'Trentini', '16-DEC-1999', '0317 7605808', 'Este', 'Padova'),
('ZBLTVA42S51B262Y', 'Alcide', 'Esposito', '19-MAR-2002', '0340 2327004', 'Este', 'Padova'),
('ZLCFZF71L49L342Q', 'Ubaldo', 'Esposito', '26-OCT-1982', '0318 3531293', 'Este', 'Padova');

insert into Parentele values
('RVSNVK90B07I122X', 'FLNYDF98T68A825A', 'nipote'),
('RVSNVK90B07I122X', 'YLTFFH56C25L048S', 'figlia'),
('DXLSPM52A02G600G', 'VLBXVR31E50G041B', 'nipote'),
('DXLSPM52A02G600G', 'SFQTBM62E63C879M', 'figlia'),
('ZBTFQF51L65F174I', 'ZBLTVA42S51B262Y', 'genero'),
('ZBTFQF51L65F174I', 'ZLCFZF71L49L342Q', 'genero');

insert into Visite values
('VLBXVR31E50G041B', 'DXLSPM52A02G600G', 'TSDRMR81M31F441U', '13-JAN-2023', '13:15:12'),
('VLBXVR31E50G041B', 'DXLSPM52A02G600G', 'TSDRMR81M31F441U', '07-DEC-2021', '17:15:12'),
('VLBXVR31E50G041B', 'DXLSPM52A02G600G', 'TSDRMR81M31F441U', '11-JAN-2023', '13:15:11');
 
create table Lavoratori
(
    CF char(16) primary key,
    Nome varchar(40),
    Cognome varchar(40),
    DataNascita date,
    CittaResidenzaNome varchar(40),
    CittaResidenzaProvincia varchar(40),
    foreign key (CittaResidenzaNome, CittaResidenzaProvincia) references Citta (Nome, Provincia)
);

create table Medici
(
    CF char(16) primary key references Lavoratori(CF),
    NumeroOrdine char(4),
    DataIscrizioneOrdine date
);

create table Dipendenti
(
    CF char(16) primary key references Lavoratori(CF),
    TipoContratto varchar(40)
);

create table Infermieri
(
    CF char(16) primary key references Dipendenti(CF),
    NumeroAlbo char(4),
    DataIscrizioneAlbo date
);

create table Fisioterapisti
(
    CF char(16) primary key references Dipendenti(CF),
    NumeroAlbo char(4),
    DataIscrizioneAlbo date
);

create table OSS
(
    CF char(16) primary key references Dipendenti(CF)
);

create table DipendentiAmministrativi
(
    CF char(16) primary key references Dipendenti(CF)
);

create table Portinai
(
    CF char(16) primary key references Dipendenti(CF)
);

insert into Lavoratori values
('XRZQWQ36A26F680X', 'Dimitri', 'Conti', '5-12-1987', 'Trieste', 'Trieste'),
('SFCRFR52L06E952I', 'Clizia', 'Padovano', '29-MAY-1952', 'Trieste', 'Trieste'),
('JEOPHG66H51L809M', 'Viviano', 'Panicucci', '7-JUL-1984', 'Trieste', 'Trieste'),
('PDDTCZ54A50D043X', 'Adamo', 'Costa', '8-NOV-1988', 'Trieste', 'Trieste'),
('GPACGL62D08E336B', 'Alcide', 'Lo Duca', '24-OCT-2001', 'Trieste', 'Trieste'),
('NGVHVS83R49F016S', 'Cosimo', 'Pisano', '12-JUL-1993', 'Este', 'Padova'),
('VSSRDC79M15L347H', 'Amedeo', 'De Luca', '18-MAY-1956', 'Este', 'Padova'),
('PGZPZB90R65B672R', 'Silvia', 'Lori', '1-JUN-1997', 'Este', 'Padova'),
('NBRGKJ37D18A704J', 'Gioacchino', 'Iadanza', '22-MAY-1978', 'Este', 'Padova'),
('YVGZMD57D42I164J', 'Maria Pia', 'Marino', '10-JUL-1953', 'Codroipo', 'Udine'),
('XXJFZV44T62E372X', 'Felice', 'Bianchi' ,'21-SEP-1947','Codroipo','Udine'),
('SBFPHF39S25B437G', 'Isidora', 'Russo' ,'11-APR-1988','Codroipo','Udine'),
('VFFVWR70T47C629Y', 'Livia' ,'Napolitani', '17-APR-1987','Codroipo','Udine');

insert into Medici values
('XRZQWQ36A26F680X', '4329', '5-DEC-1999'),
('SFCRFR52L06E952I', '4738', '21-MAY-1995');

insert into Dipendenti values
('JEOPHG66H51L809M', 'Determinato'),
('PDDTCZ54A50D043X', 'Indeterminato'),
('GPACGL62D08E336B', 'Determinato'),
('NGVHVS83R49F016S', 'Determinato'),
('VSSRDC79M15L347H', 'Indeterminato'),
('PGZPZB90R65B672R', 'Indeterminato'),
('NBRGKJ37D18A704J', 'Indeterminato'),
('YVGZMD57D42I164J', 'Indeterminato'),
('XXJFZV44T62E372X', 'Indeterminato'),
('SBFPHF39S25B437G', 'Indeterminato'),
('VFFVWR70T47C629Y', 'Indeterminato');

insert into Infermieri values
('JEOPHG66H51L809M', '4329', '21-MAY-1995'),
('PDDTCZ54A50D043X', '4738', '5-MAY-1998');

insert into Fisioterapisti values
('GPACGL62D08E336B', '3214', '21-MAY-2005'),
('NGVHVS83R49F016S', '7689', '21-MAY-2001');

insert into OSS values
('VSSRDC79M15L347H'),
('PGZPZB90R65B672R');

insert into DipendentiAmministrativi values
('NBRGKJ37D18A704J'),
('YVGZMD57D42I164J');

insert into Portinai values
('XXJFZV44T62E372X'),
('SBFPHF39S25B437G'),
('VFFVWR70T47C629Y');
create table RapportiMedici
(
  Medico char(16) references Medici(CF),
  Ospite char(16) references Ospiti(CF),
  primary key (Medico,Ospite)
);

create table VisiteMediche
(
  Medico char(16) references Medici(CF),
  Ospite char(16) references Ospiti(CF),
  Data date,
  foreign key (Medico,Ospite) references RapportiMedici (Medico,Ospite),
  primary key (Medico,Ospite,Data)
);

create table Diagnosi
(
  NumeroReferto char(4) primary key,
  ParteDelCorpo varchar(30),
  Medico char(16),
  Ospite char(16),
  DataVisita date,
  foreign key (Medico,Ospite,DataVisita) references VisiteMediche(Medico,Ospite,Data)
);

create table PrescrizioniFarmaci
(
  NumeroReferto char(4) references Diagnosi(NumeroReferto),
  CodiceFarmaco char(6),
  Quantitativo varchar(30),
  Cadenza varchar(30),
  Tipo varchar(30),
  Attiva bool,
  primary key(NumeroReferto,CodiceFarmaco)
);

create table DosiVaccinoOspiti
(
  Medico char(16) references Medici(CF),
  Ospite char(16) references Ospiti(CF),
  NumeroDose int,
  Data date,
  primary key (Medico, Ospite, NumeroDose)
);

create table DosiVaccinoLavoratori
(
  Medico char(16) references Medici(CF),
  Lavoratore char(16),
  NumeroDose int,
  Data date,
  primary key (Medico, Lavoratore, NumeroDose)
);

insert into RapportiMedici values
('XRZQWQ36A26F680X', 'RVSNVK90B07I122X'),
('SFCRFR52L06E952I', 'DXLSPM52A02G600G'),
('SFCRFR52L06E952I', 'ZBTFQF51L65F174I');

insert into VisiteMediche values
('XRZQWQ36A26F680X', 'RVSNVK90B07I122X', '19-MAR-2022'),
('XRZQWQ36A26F680X', 'RVSNVK90B07I122X', '26-DEC-2022'),
('XRZQWQ36A26F680X', 'RVSNVK90B07I122X', '19-JAN-2022'),
('SFCRFR52L06E952I', 'DXLSPM52A02G600G', '16-JAN-2023'),
('SFCRFR52L06E952I', 'DXLSPM52A02G600G', '17-APR-2021'),
('SFCRFR52L06E952I', 'ZBTFQF51L65F174I', '19-MAR-2022');

insert into Diagnosi values
('1010', 'bracciodx', 'XRZQWQ36A26F680X', 'RVSNVK90B07I122X', '19-MAR-2022'),
('1011', 'bracciosx', 'XRZQWQ36A26F680X', 'RVSNVK90B07I122X', '19-MAR-2022'),
('1012', 'gambadx', 'XRZQWQ36A26F680X', 'RVSNVK90B07I122X', '19-MAR-2022'),
('1013', 'gambasx', 'SFCRFR52L06E952I', 'DXLSPM52A02G600G', '16-JAN-2023'),
('1014', 'torace', 'SFCRFR52L06E952I', 'DXLSPM52A02G600G', '17-APR-2021'),
('1015', 'piededx', 'SFCRFR52L06E952I', 'ZBTFQF51L65F174I', '19-MAR-2022');

insert into PrescrizioniFarmaci values
('1010', '3456', '3 gr', '6 ore', 'fisso', true),
('1010', '5678', '6 gr', '3 ore', 'condizionato', true),
('1010', '1234', '7 gr', '2 ore', 'fisso', true),
('1013', '6789', '10 gr', '9 ore', 'condizionato', true),
('1014', '3256', '3 gr', '10 ore', 'fisso', true);

insert into DosiVaccinoOspiti values
('XRZQWQ36A26F680X', 'RVSNVK90B07I122X', 1, '17-MAY-2022'),
('XRZQWQ36A26F680X', 'RVSNVK90B07I122X', 2, '17-JUN-2022'),
('XRZQWQ36A26F680X', 'RVSNVK90B07I122X', 3, '17-DEC-2022'),
('SFCRFR52L06E952I', 'DXLSPM52A02G600G', 1, '7-MAY-2022'),
('SFCRFR52L06E952I', 'DXLSPM52A02G600G', 2, '17-JUN-2022'),
('SFCRFR52L06E952I', 'DXLSPM52A02G600G', 3, '3-DEC-2022');

insert into DosiVaccinoLavoratori values
('XRZQWQ36A26F680X', 'XRZQWQ36A26F680X', 1, '17-MAY-2022'),
('XRZQWQ36A26F680X', 'SFCRFR52L06E952I', 2, '17-JUN-2022'),
('XRZQWQ36A26F680X', 'JEOPHG66H51L809M', 3, '17-DEC-2022'),
('SFCRFR52L06E952I', 'PDDTCZ54A50D043X', 1, '7-MAY-2022'),
('SFCRFR52L06E952I', 'PDDTCZ54A50D043X', 2, '17-JUN-2022'),
('SFCRFR52L06E952I', 'PDDTCZ54A50D043X', 3, '3-DEC-2022'),
('SFCRFR52L06E952I', 'YVGZMD57D42I164J', 2, '3-DEC-2022');

create table SomministrazioneFarmaci
(NumeroReferto char(4),
 CodiceFarmaco char(4),
 Infermiere char(16) references Infermieri(CF),
 Data date,
 Ora time,
 foreign key (NumeroReferto, CodiceFarmaco) references PrescrizioniFarmaci(NumeroReferto, CodiceFarmaco),
 primary key (Infermiere, Data, Ora));

create table TamponiEffettuatiLavoratori
(Infermiere char(16) references Infermieri(CF),
 Lavoratore char(16) references Lavoratori(CF),
 Data date,
 Esito varchar(20),
 primary key (Infermiere, Lavoratore, Data));

create table TamponiEffettuatiOspiti
(Infermiere char(16) references Infermieri(CF),
 Ospite char(16) references Ospiti(CF),
 Data date,
 Esito varchar(20),
 primary key (Infermiere, Ospite, Data));

create table PianiAssistenza
(Codice char(4) primary key,
 Mese char(20),
 Anno int,
 Ospite char(16) references Ospiti(CF));

create table StesurePiani
(Infermiere char(16) references Infermieri(CF),
 CodicePiano char(4) references PianiAssistenza(Codice),
 primary key (Infermiere, CodicePiano));

create table Mansioni
(Codice char(4) primary key,
 Cadenza varchar(30),
 Tipo varchar(30),
 ParteDelCorpo varchar(30),
 Parametro varchar(30));

create table ComposizionePiani
(CodicePiano char(4) references PianiAssistenza(Codice),
 CodiceMansione char(4) references Mansioni(Codice),
 primary key (CodicePiano, CodiceMansione));

create table Prestazioni
(CodiceMansione char(4) references Mansioni(Codice),
 OSS char(16) references OSS(CF),
 Ospite char(16) references Ospiti(CF),
 Data date,
 Ora time,
 Tipo varchar(30),
 Valore varchar(30),
 primary key (OSS, Data, Ora));

insert into SomministrazioneFarmaci values
('1010', '3456', 'JEOPHG66H51L809M', '13-JAN-2023', '17:10:22'),
('1010', '3456', 'JEOPHG66H51L809M', '14-JAN-2023', '18:10:22'),
('1010', '3456', 'JEOPHG66H51L809M', '13-JAN-2023', '17:01:22'),
('1010', '5678', 'PDDTCZ54A50D043X', '15-JAN-2023', '4:10:25'),
('1014', '3256', 'PDDTCZ54A50D043X', '13-JAN-2023', '7:10:22');

insert into TamponiEffettuatiLavoratori values
('JEOPHG66H51L809M', 'XRZQWQ36A26F680X', '14-JAN-2023', false),
('JEOPHG66H51L809M', 'SFCRFR52L06E952I', '14-JAN-2023', false),
('JEOPHG66H51L809M', 'JEOPHG66H51L809M', '15-JAN-2023', false);

insert into TamponiEffettuatiOspiti values
('JEOPHG66H51L809M', 'DXLSPM52A02G600G', '14-DEC-2022', false),
('JEOPHG66H51L809M', 'DXLSPM52A02G600G', '14-JAN-2023', true),
('JEOPHG66H51L809M', 'ZBTFQF51L65F174I', '7-DEC-2022', false),
('JEOPHG66H51L809M', 'ZBTFQF51L65F174I', '15-JAN-2023', false);

insert into PianiAssistenza values
('2345', 'Gennaio', 2023, 'DXLSPM52A02G600G'),
('2346', 'Dicembre', 2022, 'DXLSPM52A02G600G'),
('2347', 'Dicembre', 2022, 'ZBTFQF51L65F174I'),
('2348', 'Gennaio', 2023, 'ZBTFQF51L65F174I');

insert into StesurePiani values
('JEOPHG66H51L809M', '2345'),
('JEOPHG66H51L809M', '2346'),
('JEOPHG66H51L809M', '2347'),
('JEOPHG66H51L809M', '2348');

insert into Mansioni values
('0001', 'giornaliera', 'misurazione', null, 'pressione'),
('0002', 'giornaliera', 'medicazione', 'piede dx', null),
('0003', 'giornaliera', 'medicazione', 'piede sx', null),
('0004', 'giornaliera', 'medicazione', 'mano dx', null),
('0005', 'settimanale', 'medicazione', 'mano dx', null);

insert into ComposizionePiani values
('2345', '0001'),
('2345', '0002'),
('2346', '0001'),
('2347', '0001'),
('2348', '0002'),
('2345', '0005'),
('2348', '0005');

insert into Prestazioni values
('0001', 'VSSRDC79M15L347H', 'DXLSPM52A02G600G', '13-JAN-2023', '7:10:22', 'misurazione', '97'),
('0002', 'VSSRDC79M15L347H', 'DXLSPM52A02G600G', '13-JAN-2023', '17:10:22', 'medicazione', null),
('0002', 'VSSRDC79M15L347H', 'DXLSPM52A02G600G', '14-JAN-2023', '7:10:22', 'medicazione', null),
('0002', 'VSSRDC79M15L347H', 'ZBTFQF51L65F174I', '14-JAN-2023', '7:45:22', 'medicazione', null),
('0002','PGZPZB90R65B672R','ZBTFQF51L65F174I','13-JAN-2023','7:10:22','medicazione',null),
('0002','PGZPZB90R65B672R','ZBTFQF51L65F174I','12-JAN-2023','6:10:22','medicazione',null),
('0005','PGZPZB90R65B672R','DXLSPM52A02G600G','16-DEC-2022','6:10:22','medicazione',null),
('0005','PGZPZB90R65B672R', 'ZBTFQF51L65F174I','12-DEC-2022','6:10:22','medicazione',null);

create table StoricoAssegnazioneAusili
(Codice char(4),
 Contratto varchar(20),
 DataAssegnazione date,
 DataFine date,
 Tipo varchar(60),
 Fisioterapista char(16) references Fisioterapisti(CF),
 Ospite char(16) references Ospiti(CF),
 primary key (Codice, DataAssegnazione, Ospite));

create table AssegnazioneAusiliAttuali
(Codice char(4),
 Contratto varchar(20),
 DataAssegnazione date,
 Tipo varchar(60),
 Fisioterapista char(16) references Fisioterapisti(CF),
 Ospite char(16) references OspitiInVita(CF),
 primary key (Codice, DataAssegnazione, Ospite));

insert into StoricoAssegnazioneAusili values
('0001', 'di propietà', '14-JAN-2022', '13-JAN-2023', 'carrozzina', 'GPACGL62D08E336B', 'DXLSPM52A02G600G'),
('0002', 'di propietà', '14-JAN-2021', '13-JAN-2023', 'deaumbolatore', 'GPACGL62D08E336B', 'DXLSPM52A02G600G'),
('0001', 'di propietà', '7-DEC-2022', '12-JAN-2023', 'carrozzina', 'GPACGL62D08E336B', 'DXLSPM52A02G600G');

insert into AssegnazioneAusiliAttuali values
('0001', 'di propietà', '14-JAN-2023', 'carrozzina', 'GPACGL62D08E336B', 'DXLSPM52A02G600G'),
('0602', 'comodato', '14-JAN-2023', 'deaumbolatore', 'GPACGL62D08E336B', 'DXLSPM52A02G600G'),
('4567', 'di propietà', '14-JAN-2023', 'carrozzina', 'GPACGL62D08E336B', 'ZBTFQF51L65F174I');

create table Pagamenti
(Data date,
 Ospite char(16) references Ospiti(CF),
 NumeroFattura char(4),
 Importo int,
 DipendenteAmministrativo char(16) references DipendentiAmministrativi(CF));

insert into Pagamenti values
('14-JAN-2023', 'DXLSPM52A02G600G', '4567', 1987, 'NBRGKJ37D18A704J'),
('14-DEC-2022', 'DXLSPM52A02G600G', '4533', 1987, 'NBRGKJ37D18A704J'),
('14-NOV-2022', 'DXLSPM52A02G600G', '4566', 1987, 'NBRGKJ37D18A704J'),
('14-OCT-2022', 'DXLSPM52A02G600G', '4562', 1987, 'NBRGKJ37D18A704J'),
('14-JAN-2023', 'ZBTFQF51L65F174I', '4567', 1456, 'YVGZMD57D42I164J'),
('14-DEC-2022', 'ZBTFQF51L65F174I', '4533', 1234, 'NBRGKJ37D18A704J'),
('14-NOV-2022', 'ZBTFQF51L65F174I', '4566', 1456, 'YVGZMD57D42I164J'),
('14-OCT-2022', 'ZBTFQF51L65F174I', '4562', 1345, 'NBRGKJ37D18A704J'),
('14-JAN-2021', 'RVSNVK90B07I122X', '2566', 675, 'NBRGKJ37D18A704J'),
('14-DEC-2021', 'RVSNVK90B07I122X', '2533', 876, 'NBRGKJ37D18A704J'),
('14-NOV-2021', 'RVSNVK90B07I122X', '2566', 987, 'NBRGKJ37D18A704J'),
('14-OCT-2020', 'JCVHSS97E48B744F', '2562', 1987, 'NBRGKJ37D18A704J'),
('14-JAN-2020', 'JCVHSS97E48B744F', '2567', 1456, 'YVGZMD57D42I164J'),
('14-DEC-2020', 'JCVHSS97E48B744F', '2533', 1234, 'NBRGKJ37D18A704J');
