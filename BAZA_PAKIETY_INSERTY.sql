CREATE TABLE a_f ( 
    aktorzy_id_aktora      INTEGER NOT NULL, 
    filmy_i_seriale_id_f_s INTEGER NOT NULL 
);

ALTER TABLE a_f ADD CONSTRAINT a_f_pk PRIMARY KEY ( aktorzy_id_aktora, 
                                                    filmy_i_seriale_id_f_s );

CREATE TABLE administrator ( 
    id_administratora  INTEGER NOT NULL, 
    imie               VARCHAR2(40 CHAR), 
    nazwisko           VARCHAR2(80 CHAR), 
    nr_telefonu        INTEGER, 
    email              VARCHAR2(80 CHAR), 
    adres_kod_pocztowy VARCHAR2(50 CHAR) NOT NULL, 
    ulica              VARCHAR2(30 CHAR) 
);

ALTER TABLE administrator ADD CONSTRAINT administrator_pk PRIMARY KEY ( id_administratora );

CREATE TABLE adres ( 
    kod_pocztowy VARCHAR2(50 CHAR) NOT NULL, 
    miejscowosc  VARCHAR2(30 CHAR), 
    wojewodztwo  VARCHAR2(30 CHAR) 
);

ALTER TABLE adres ADD CONSTRAINT adres_pk PRIMARY KEY ( kod_pocztowy );

CREATE TABLE aktorzy ( 
    id_aktora        INTEGER NOT NULL, 
    imie             VARCHAR2(40 CHAR), 
    nazwisko         VARCHAR2(80 CHAR), 
    wiek             INTEGER, 
    kraj_pochodzenia VARCHAR2(80 CHAR) 
);

ALTER TABLE aktorzy ADD CONSTRAINT aktorzy_pk PRIMARY KEY ( id_aktora );

CREATE TABLE f_r ( 
    filmy_i_seriale_id_f_s INTEGER NOT NULL, 
    rezyser_id_rezysera    INTEGER NOT NULL 
);

ALTER TABLE f_r ADD CONSTRAINT f_r_pk PRIMARY KEY ( filmy_i_seriale_id_f_s, 
                                                    rezyser_id_rezysera );

CREATE TABLE filmy_i_seriale ( 
    id_f_s                   INTEGER NOT NULL, 
    tytul                    VARCHAR2(60 CHAR), 
    opis                     VARCHAR2(1000 CHAR), 
    cena                     INTEGER, 
    gatunek_id_gatunku       INTEGER NOT NULL, 
    typ_filmu_i_serialu_id_t INTEGER NOT NULL, 
    kraj_produkcji_id_kraju  INTEGER NOT NULL, 
    administrator_id_a       INTEGER NOT NULL, 
    pakiety_id_pakietu       INTEGER NOT NULL,
    ilosc                    INTEGER
);

ALTER TABLE filmy_i_seriale ADD CONSTRAINT filmy_i_seriale_pk PRIMARY KEY ( id_f_s );

CREATE TABLE gatunek ( 
    id_gatunku INTEGER NOT NULL, 
    nazwa      VARCHAR2(100 CHAR) 
);

ALTER TABLE gatunek ADD CONSTRAINT gatunek_pk PRIMARY KEY ( id_gatunku );

CREATE TABLE klient ( 
    id_klienta         INTEGER NOT NULL, 
    imie               VARCHAR2(40 CHAR), 
    nazwisko           VARCHAR2(80 CHAR), 
    wiek               INTEGER, 
    nr_telefonu        INTEGER, 
    email              VARCHAR2(50 CHAR), 
    ulica              VARCHAR2(30 CHAR), 
    adres_kod_pocztowy VARCHAR2(50 CHAR) NOT NULL,
pakiet VARCHAR(40 CHAR)
);

ALTER TABLE klient ADD CONSTRAINT klient_pk PRIMARY KEY ( id_klienta );

CREATE TABLE kraj_produkcji ( 
    id_kraju INTEGER NOT NULL, 
    nazwa    VARCHAR2(80 CHAR) 
);

ALTER TABLE kraj_produkcji ADD CONSTRAINT kraj_produkcji_pk PRIMARY KEY ( id_kraju );

CREATE TABLE pakiety ( 
    id_pakietu INTEGER NOT NULL, 
    nazwa      VARCHAR2(40 CHAR), 
    cena       INTEGER 
);

ALTER TABLE pakiety ADD CONSTRAINT pakiety_pk PRIMARY KEY ( id_pakietu );

CREATE TABLE recenzja_filmu_i_serialu ( 
    id_recenzji            INTEGER NOT NULL, 
    opis                   VARCHAR2(1000 CHAR), 
    klient_id_klienta      INTEGER, 
    filmy_i_seriale_id_f_s INTEGER, 
    ocena                  INTEGER, 
    data_recenzji          DATE 
);

ALTER TABLE recenzja_filmu_i_serialu ADD CONSTRAINT recenzja_filmu_i_serialu_pk PRIMARY KEY ( id_recenzji );

CREATE TABLE rezyser ( 
    id_rezysera      INTEGER NOT NULL, 
    imie             VARCHAR2(40 CHAR), 
    nazwisko         VARCHAR2(80 CHAR), 
    wiek             INTEGER, 
    kraj_pochodzenia VARCHAR2(80 CHAR) 
);

ALTER TABLE rezyser ADD CONSTRAINT rezyser_pk PRIMARY KEY ( id_rezysera );

CREATE TABLE rodzaj_platnosci ( 
    id_platnosci INTEGER NOT NULL, 
    rodzaj       VARCHAR2(30 CHAR) 
);

ALTER TABLE rodzaj_platnosci ADD CONSTRAINT rodzaj_platnosci_pk PRIMARY KEY ( id_platnosci );

CREATE TABLE transakcje ( 
    id_transakcji     INTEGER NOT NULL, 
    umowy_id_umowy    INTEGER, 
    wypozyczenia_id_w INTEGER 
);

CREATE UNIQUE INDEX transakcje__idx ON 
    transakcje ( 
        umowy_id_umowy 
    ASC );

CREATE UNIQUE INDEX transakcje__idxv1 ON 
    transakcje ( 
        wypozyczenia_id_w 
    ASC );

ALTER TABLE transakcje ADD CONSTRAINT transakcje_pk PRIMARY KEY ( id_transakcji );

CREATE TABLE typ_filmu_i_serialu ( 
    id_typow INTEGER NOT NULL, 
    nazwa    VARCHAR2(80 CHAR) 
);

ALTER TABLE typ_filmu_i_serialu ADD CONSTRAINT typ_filmu_i_serialu_pk PRIMARY KEY ( id_typow );

CREATE TABLE umowy ( 
    id_umowy              INTEGER NOT NULL, 
    klient_id_klienta     INTEGER NOT NULL, 
    administrator_id_a    INTEGER NOT NULL, 
    data_zawarcia_umowy   DATE, 
    data_zakoczenia_umowy DATE,
    kwota_koncowa         INTEGER, 
    pakiety_id_pakietu    INTEGER NOT NULL, 
    rodzaj_platnosci_id_p INTEGER NOT NULL,
status VARCHAR2(20 CHAR) 
);

CREATE UNIQUE INDEX umowy__idx ON 
    umowy ( 
        klient_id_klienta 
    ASC );

ALTER TABLE umowy ADD CONSTRAINT umowy_pk PRIMARY KEY ( id_umowy );

CREATE TABLE wypozyczenia ( 
    id_wypozyczenia        INTEGER NOT NULL, 
    klient_id_klienta      INTEGER NOT NULL, 
    administrator_id_ad    INTEGER NOT NULL, 
    filmy_i_seriale_id_f_s INTEGER NOT NULL, 
    data_wypozyczenia      DATE, 
    data_oddania      DATE,
    kwota_koncowa          INTEGER, 
    rodzaj_platnosci_id_p  INTEGER NOT NULL,
    status VARCHAR2(30)
);

CREATE TABLE rezerwacje (
    id_rezerwacji          INTEGER PRIMARY KEY,
    klient_id_klienta      INTEGER NOT NULL,
    filmy_i_seriale_id_f_s INTEGER NOT NULL,
    data_poczatkowa        DATE NOT NULL,
    data_koncowa           DATE NOT NULL,
    FOREIGN KEY (klient_id_klienta) REFERENCES klient (id_klienta),
    FOREIGN KEY (filmy_i_seriale_id_f_s) REFERENCES filmy_i_seriale (id_f_s)
);


ALTER TABLE wypozyczenia ADD CONSTRAINT wypozyczenia_pk PRIMARY KEY ( id_wypozyczenia );

ALTER TABLE a_f 
    ADD CONSTRAINT a_f_aktorzy_fk FOREIGN KEY ( aktorzy_id_aktora ) 
        REFERENCES aktorzy ( id_aktora );

ALTER TABLE a_f 
    ADD CONSTRAINT a_f_filmy_i_seriale_fk FOREIGN KEY ( filmy_i_seriale_id_f_s ) 
        REFERENCES filmy_i_seriale ( id_f_s );

ALTER TABLE administrator 
    ADD CONSTRAINT administrator_a_fk FOREIGN KEY ( adres_kod_pocztowy ) 
        REFERENCES adres ( kod_pocztowy );

ALTER TABLE f_r 
    ADD CONSTRAINT f_r_filmy_i_seriale_fk FOREIGN KEY ( filmy_i_seriale_id_f_s ) 
        REFERENCES filmy_i_seriale ( id_f_s );

ALTER TABLE f_r 
    ADD CONSTRAINT f_r_rezyser_fk FOREIGN KEY ( rezyser_id_rezysera ) 
        REFERENCES rezyser ( id_rezysera );

ALTER TABLE filmy_i_seriale 
    ADD CONSTRAINT filmy_i_seriale_a_fk FOREIGN KEY ( administrator_id_a ) 
        REFERENCES administrator ( id_administratora );

ALTER TABLE filmy_i_seriale 
    ADD CONSTRAINT filmy_i_seriale_g_fk FOREIGN KEY ( gatunek_id_gatunku ) 
        REFERENCES gatunek ( id_gatunku );

ALTER TABLE filmy_i_seriale 
    ADD CONSTRAINT filmy_i_seriale_kp_fk FOREIGN KEY ( kraj_produkcji_id_kraju ) 
        REFERENCES kraj_produkcji ( id_kraju );

ALTER TABLE filmy_i_seriale 
    ADD CONSTRAINT filmy_i_seriale_p_fk FOREIGN KEY ( pakiety_id_pakietu ) 
        REFERENCES pakiety ( id_pakietu );

ALTER TABLE filmy_i_seriale 
    ADD CONSTRAINT filmy_i_seriale_t_fk FOREIGN KEY ( typ_filmu_i_serialu_id_t ) 
        REFERENCES typ_filmu_i_serialu ( id_typow );

ALTER TABLE klient 
    ADD CONSTRAINT klient_adres_fk FOREIGN KEY ( adres_kod_pocztowy ) 
        REFERENCES adres ( kod_pocztowy );

ALTER TABLE recenzja_filmu_i_serialu 
    ADD CONSTRAINT recenzja_f_s_fk FOREIGN KEY ( filmy_i_seriale_id_f_s ) 
        REFERENCES filmy_i_seriale ( id_f_s );

ALTER TABLE recenzja_filmu_i_serialu 
    ADD CONSTRAINT recenzja_f_s_k_fk FOREIGN KEY ( klient_id_klienta ) 
        REFERENCES klient ( id_klienta );

ALTER TABLE transakcje 
    ADD CONSTRAINT transakcje_u_fk FOREIGN KEY ( umowy_id_umowy ) 
        REFERENCES umowy ( id_umowy );

ALTER TABLE transakcje 
    ADD CONSTRAINT transakcje_w_fk FOREIGN KEY ( wypozyczenia_id_w ) 
        REFERENCES wypozyczenia ( id_wypozyczenia );

ALTER TABLE umowy 
    ADD CONSTRAINT umowy_administrator_fk FOREIGN KEY ( administrator_id_a ) 
        REFERENCES administrator ( id_administratora );

ALTER TABLE umowy 
    ADD CONSTRAINT umowy_klient_fk FOREIGN KEY ( klient_id_klienta ) 
        REFERENCES klient ( id_klienta );

ALTER TABLE umowy 
    ADD CONSTRAINT umowy_pakiety_fk FOREIGN KEY ( pakiety_id_pakietu ) 
        REFERENCES pakiety ( id_pakietu );

ALTER TABLE umowy 
    ADD CONSTRAINT umowy_rodzaj_p_fk FOREIGN KEY ( rodzaj_platnosci_id_p ) 
        REFERENCES rodzaj_platnosci ( id_platnosci );

ALTER TABLE wypozyczenia 
    ADD CONSTRAINT wypozyczenia_ad_fk FOREIGN KEY ( administrator_id_ad ) 
        REFERENCES administrator ( id_administratora );

ALTER TABLE wypozyczenia 
    ADD CONSTRAINT wypozyczenia_f_s_fk FOREIGN KEY ( filmy_i_seriale_id_f_s ) 
        REFERENCES filmy_i_seriale ( id_f_s );

ALTER TABLE wypozyczenia 
    ADD CONSTRAINT wypozyczenia_klient_fk FOREIGN KEY ( klient_id_klienta ) 
        REFERENCES klient ( id_klienta );

ALTER TABLE wypozyczenia 
    ADD CONSTRAINT wypozyczenia_rp_fk FOREIGN KEY ( rodzaj_platnosci_id_p ) 
        REFERENCES rodzaj_platnosci ( id_platnosci );

CREATE SEQUENCE dept_deptidaktorzy_seq;
BEGIN 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Joaquin','Phoenix','48','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Jack','Nicholson','85','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Leonardo','DiCaprio','48','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Al','Pacino','82','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Clint','Eastwood','92','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Anthony','Hopkins','84','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Daniel','Day-Lewis','65','Wielka Brytania'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Robert','Downey Jr.','57','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Joe','Pesci','79','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Will','Smith','54','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Tom','Hiddleston','41','Wielka Brytania'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Tom','Hanks','66','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Edward','Norton','53','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Johnny','Depp','59','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Christoph','Waltz','66','Austria'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Tom','Hardy','45','Wielka Brytania'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Brad','Pitt','58','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Hugh','Jackman','54','Australia'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Jake','Gyllenhaal','41','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Cillian','Murphy','46','Irlandia'); 
END;
/

BEGIN 
INSERT INTO kraj_produkcji VALUES ('1','Polska'); 
INSERT INTO kraj_produkcji VALUES ('2','Niemcy'); 
INSERT INTO kraj_produkcji VALUES ('3','Francja'); 
INSERT INTO kraj_produkcji VALUES ('4','Wielka Brytania'); 
INSERT INTO kraj_produkcji VALUES ('5','Hiszpania'); 
INSERT INTO kraj_produkcji VALUES ('6','USA'); 
INSERT INTO kraj_produkcji VALUES ('7','Rosja'); 
INSERT INTO kraj_produkcji VALUES ('8','Finlandia'); 
INSERT INTO kraj_produkcji VALUES ('9','Portugalia'); 
INSERT INTO kraj_produkcji VALUES ('10','Turcja'); 
INSERT INTO kraj_produkcji VALUES ('11','Nowa Zelandia'); 
INSERT INTO kraj_produkcji VALUES ('12','Szwajcaria'); 
END;
/

begin  
insert into adres values ('33-230', 'Rzeszow', 'Podkarpackie' ); 
insert into adres values ('33-231', 'Krakow', 'Malopolskie' ); 
insert into adres values ('33-232', 'Warszawa', 'Mazowieckie' ); 
insert into adres values ('33-233', 'Gdansk', 'Podkarpackie' ); 
insert into adres values ('33-234', 'Katowice', 'Slaskie' ); 
insert into adres values ('33-235', 'Kielce', 'Swietokrzyskie' ); 
end;
/

begin 
INSERT INTO administrator VALUES ('1', 'Piotr', 'Pajda', '587567457', 'ppajda@onet.pl', '33-230', 'Szkolna'); 
INSERT INTO administrator VALUES ('2', 'Joanna', 'Mazur', '765887658', 'jmazur@wp.pl', '33-231', 'Promienna'); 
end;
/

CREATE SEQUENCE dept_deptidrezyser_seq;
BEGIN 
INSERT INTO rezyser VALUES (dept_deptidrezyser_seq.NEXTVAL, 'Stanley', 'Kubrick', 54, 'Stany Zjednoczone'  ); 
INSERT INTO rezyser VALUES (dept_deptidrezyser_seq.NEXTVAL, 'James', 'Cameron', 58, 'Kanada'); 
INSERT INTO rezyser VALUES (dept_deptidrezyser_seq.NEXTVAL, 'Jerzy', 'Hoffman', 90, 'Polska'); 
INSERT INTO rezyser VALUES (dept_deptidrezyser_seq.NEXTVAL, 'Quentin', 'Tarantino', 59, 'Stany Zjednoczone'); 
INSERT INTO rezyser VALUES (dept_deptidrezyser_seq.NEXTVAL, 'Wes', 'Anderson', 53, 'Stany Zjednoczone'); 
END;
/

CREATE SEQUENCE dept_deptid_seq;
BEGIN 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Jan', 'Kowlaski', 19, '517928516', 'jkowalski@onet', 'Urocza', '33-230', '' ); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Piotr', 'Kawka', 19, '516753851', 'pkawka@onet', 'Solna', '33-232','' ); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Jadwiga', 'Nowak', 19, '587626881', 'jnowak@onet', 'Wielkopolska', '33-231','' ); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Zuzanna', 'Kijek', 33, '501693279', 'zkijek@onet', 'Partyzantow', '33-235','' ); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Klaudia', 'Hula', 25, '719465578', 'khula@onet', 'Podkarpacka', '33-233', ''); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Waldemar', 'Sroka', 42, '798587436', 'wsroka@onet', 'Ptasia', '33-231', ''); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Pawel', 'Nicpon', 28, '587469875', 'pnicpona@onet', 'Mila', '33-232','' ); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Aleksandra', 'Mila', 17, '953678731', 'amila@onet', 'Wesola', '33-230', ''); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Marcin', 'Ziolko', 31, '467987656', 'mzilko@onet', 'Weteranow', '33-234', ''); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Anna', 'Wesolowska', 39, '678876876', 'awesolowska@onet', 'Sadowa', '33-230','' ); 
END;
/

BEGIN 
INSERT INTO typ_filmu_i_serialu VALUES ('1','Premiera'); 
INSERT INTO typ_filmu_i_serialu VALUES ('2','Nowość'); 
INSERT INTO typ_filmu_i_serialu VALUES ('3','Standard'); 
INSERT INTO typ_filmu_i_serialu VALUES ('4','Klasyk'); 
END;
/

BEGIN 
INSERT INTO gatunek VALUES ('1','Horror'); 
INSERT INTO gatunek VALUES ('2','Akcji'); 
INSERT INTO gatunek VALUES ('3','Western'); 
INSERT INTO gatunek VALUES ('4','Animowany'); 
INSERT INTO gatunek VALUES ('5','Komedia'); 
INSERT INTO gatunek VALUES ('6','Romantyczny'); 
INSERT INTO gatunek VALUES ('7','Dramat'); 
INSERT INTO gatunek VALUES ('8','Fabularny'); 
INSERT INTO gatunek VALUES ('9','Fantasy'); 
INSERT INTO gatunek VALUES ('10','Komedia romantyczna'); 
INSERT INTO gatunek VALUES ('11','Kryminalny'); 
INSERT INTO gatunek VALUES ('12','Przygodowy'); 
END;
/

BEGIN 
INSERT INTO pakiety VALUES ('1','Premium','60'); 
INSERT INTO pakiety VALUES ('2','Gold','40'); 
INSERT INTO pakiety VALUES ('3','Standard','20'); 
END; 
/

begin 
insert into filmy_i_seriale values('1','Skazanie na Shawkshank', 
'Adaptacja opowiadania Stephena Kinga.  
Niesłusznie skazany na dożywocie bankier,  
stara się przetrwać w brutalnym, więziennym świecie.', 
20,'7','4','6','2','3',3); 
insert into filmy_i_seriale values('2','Nietykalni', 
'Sparaliżowany milioner zatrudnia do opieki młodego  
chłopaka z przedmieścia, który właśnie wyszedł z więzienia.', 
20,'7','4','3','2','2',2); 
insert into filmy_i_seriale values('3','Avatar Istota wody', 
'Pandorę znów napada wroga korporacja w poszukiwaniu cennych minerałów. 
Jack i Neytiri wraz z rodziną zmuszeni są opuścić wioskę i  
szukać pomocy u innych plemion zamieszkujących planetę.',30,'9','1','6','1','1',1); 
insert into filmy_i_seriale values('4','Usmiechnij sie','Po tym,  
jak dr Rose Carter bierze udział w traumatycznym zdarzeniu z udziałem pacjentki, 
wokół niej zaczynają dziać się niewytłumaczalne rzeczy',30,'1','1','6','1','1',4); 
end;
/

begin  
insert into rodzaj_platnosci values ('1', 'blik');  
insert into rodzaj_platnosci values ('2', 'karta');  
insert into rodzaj_platnosci values ('3', 'przelew'); 
end;
/

begin 
CREATE TABLE a_f ( 
    aktorzy_id_aktora      INTEGER NOT NULL, 
    filmy_i_seriale_id_f_s INTEGER NOT NULL 
);

ALTER TABLE a_f ADD CONSTRAINT a_f_pk PRIMARY KEY ( aktorzy_id_aktora, 
                                                    filmy_i_seriale_id_f_s );

CREATE TABLE administrator ( 
    id_administratora  INTEGER NOT NULL, 
    imie               VARCHAR2(40 CHAR), 
    nazwisko           VARCHAR2(80 CHAR), 
    nr_telefonu        INTEGER, 
    email              VARCHAR2(80 CHAR), 
    adres_kod_pocztowy VARCHAR2(50 CHAR) NOT NULL, 
    ulica              VARCHAR2(30 CHAR) 
);

ALTER TABLE administrator ADD CONSTRAINT administrator_pk PRIMARY KEY ( id_administratora );

CREATE TABLE adres ( 
    kod_pocztowy VARCHAR2(50 CHAR) NOT NULL, 
    miejscowosc  VARCHAR2(30 CHAR), 
    wojewodztwo  VARCHAR2(30 CHAR) 
);

ALTER TABLE adres ADD CONSTRAINT adres_pk PRIMARY KEY ( kod_pocztowy );

CREATE TABLE aktorzy ( 
    id_aktora        INTEGER NOT NULL, 
    imie             VARCHAR2(40 CHAR), 
    nazwisko         VARCHAR2(80 CHAR), 
    wiek             INTEGER, 
    kraj_pochodzenia VARCHAR2(80 CHAR) 
);

ALTER TABLE aktorzy ADD CONSTRAINT aktorzy_pk PRIMARY KEY ( id_aktora );

CREATE TABLE f_r ( 
    filmy_i_seriale_id_f_s INTEGER NOT NULL, 
    rezyser_id_rezysera    INTEGER NOT NULL 
);

ALTER TABLE f_r ADD CONSTRAINT f_r_pk PRIMARY KEY ( filmy_i_seriale_id_f_s, 
                                                    rezyser_id_rezysera );

CREATE TABLE filmy_i_seriale ( 
    id_f_s                   INTEGER NOT NULL, 
    tytul                    VARCHAR2(60 CHAR), 
    opis                     VARCHAR2(1000 CHAR), 
    cena                     INTEGER, 
    gatunek_id_gatunku       INTEGER NOT NULL, 
    typ_filmu_i_serialu_id_t INTEGER NOT NULL, 
    kraj_produkcji_id_kraju  INTEGER NOT NULL, 
    administrator_id_a       INTEGER NOT NULL, 
    pakiety_id_pakietu       INTEGER NOT NULL,
    ilosc                    INTEGER
);

ALTER TABLE filmy_i_seriale ADD CONSTRAINT filmy_i_seriale_pk PRIMARY KEY ( id_f_s );

CREATE TABLE gatunek ( 
    id_gatunku INTEGER NOT NULL, 
    nazwa      VARCHAR2(100 CHAR) 
);

ALTER TABLE gatunek ADD CONSTRAINT gatunek_pk PRIMARY KEY ( id_gatunku );

CREATE TABLE klient ( 
    id_klienta         INTEGER NOT NULL, 
    imie               VARCHAR2(40 CHAR), 
    nazwisko           VARCHAR2(80 CHAR), 
    wiek               INTEGER, 
    nr_telefonu        INTEGER, 
    email              VARCHAR2(50 CHAR), 
    ulica              VARCHAR2(30 CHAR), 
    adres_kod_pocztowy VARCHAR2(50 CHAR) NOT NULL,
pakiet VARCHAR(40 CHAR)
);

ALTER TABLE klient ADD CONSTRAINT klient_pk PRIMARY KEY ( id_klienta );

CREATE TABLE kraj_produkcji ( 
    id_kraju INTEGER NOT NULL, 
    nazwa    VARCHAR2(80 CHAR) 
);

ALTER TABLE kraj_produkcji ADD CONSTRAINT kraj_produkcji_pk PRIMARY KEY ( id_kraju );

CREATE TABLE pakiety ( 
    id_pakietu INTEGER NOT NULL, 
    nazwa      VARCHAR2(40 CHAR), 
    cena       INTEGER 
);

ALTER TABLE pakiety ADD CONSTRAINT pakiety_pk PRIMARY KEY ( id_pakietu );

CREATE TABLE recenzja_filmu_i_serialu ( 
    id_recenzji            INTEGER NOT NULL, 
    opis                   VARCHAR2(1000 CHAR), 
    klient_id_klienta      INTEGER, 
    filmy_i_seriale_id_f_s INTEGER, 
    ocena                  INTEGER, 
    data_recenzji          DATE 
);

ALTER TABLE recenzja_filmu_i_serialu ADD CONSTRAINT recenzja_filmu_i_serialu_pk PRIMARY KEY ( id_recenzji );

CREATE TABLE rezyser ( 
    id_rezysera      INTEGER NOT NULL, 
    imie             VARCHAR2(40 CHAR), 
    nazwisko         VARCHAR2(80 CHAR), 
    wiek             INTEGER, 
    kraj_pochodzenia VARCHAR2(80 CHAR) 
);

ALTER TABLE rezyser ADD CONSTRAINT rezyser_pk PRIMARY KEY ( id_rezysera );

CREATE TABLE rodzaj_platnosci ( 
    id_platnosci INTEGER NOT NULL, 
    rodzaj       VARCHAR2(30 CHAR) 
);

ALTER TABLE rodzaj_platnosci ADD CONSTRAINT rodzaj_platnosci_pk PRIMARY KEY ( id_platnosci );

CREATE TABLE transakcje ( 
    id_transakcji     INTEGER NOT NULL, 
    umowy_id_umowy    INTEGER, 
    wypozyczenia_id_w INTEGER 
);

CREATE UNIQUE INDEX transakcje__idx ON 
    transakcje ( 
        umowy_id_umowy 
    ASC );

CREATE UNIQUE INDEX transakcje__idxv1 ON 
    transakcje ( 
        wypozyczenia_id_w 
    ASC );

ALTER TABLE transakcje ADD CONSTRAINT transakcje_pk PRIMARY KEY ( id_transakcji );

CREATE TABLE typ_filmu_i_serialu ( 
    id_typow INTEGER NOT NULL, 
    nazwa    VARCHAR2(80 CHAR) 
);

ALTER TABLE typ_filmu_i_serialu ADD CONSTRAINT typ_filmu_i_serialu_pk PRIMARY KEY ( id_typow );

CREATE TABLE umowy ( 
    id_umowy              INTEGER NOT NULL, 
    klient_id_klienta     INTEGER NOT NULL, 
    administrator_id_a    INTEGER NOT NULL, 
    data_zawarcia_umowy   DATE, 
    data_zakoczenia_umowy DATE,
    kwota_koncowa         INTEGER, 
    pakiety_id_pakietu    INTEGER NOT NULL, 
    rodzaj_platnosci_id_p INTEGER NOT NULL,
status VARCHAR2(20 CHAR) 
);

CREATE UNIQUE INDEX umowy__idx ON 
    umowy ( 
        klient_id_klienta 
    ASC );

ALTER TABLE umowy ADD CONSTRAINT umowy_pk PRIMARY KEY ( id_umowy );

CREATE TABLE wypozyczenia ( 
    id_wypozyczenia        INTEGER NOT NULL, 
    klient_id_klienta      INTEGER NOT NULL, 
    administrator_id_ad    INTEGER NOT NULL, 
    filmy_i_seriale_id_f_s INTEGER NOT NULL, 
    data_wypozyczenia      DATE, 
    data_oddania      DATE,
    kwota_koncowa          INTEGER, 
    rodzaj_platnosci_id_p  INTEGER NOT NULL,
    status VARCHAR2(30)
);

CREATE TABLE rezerwacje (
    id_rezerwacji          INTEGER PRIMARY KEY,
    klient_id_klienta      INTEGER NOT NULL,
    filmy_i_seriale_id_f_s INTEGER NOT NULL,
    data_poczatkowa        DATE NOT NULL,
    data_koncowa           DATE NOT NULL,
    FOREIGN KEY (klient_id_klienta) REFERENCES klient (id_klienta),
    FOREIGN KEY (filmy_i_seriale_id_f_s) REFERENCES filmy_i_seriale (id_f_s)
);


ALTER TABLE wypozyczenia ADD CONSTRAINT wypozyczenia_pk PRIMARY KEY ( id_wypozyczenia );

ALTER TABLE a_f 
    ADD CONSTRAINT a_f_aktorzy_fk FOREIGN KEY ( aktorzy_id_aktora ) 
        REFERENCES aktorzy ( id_aktora );

ALTER TABLE a_f 
    ADD CONSTRAINT a_f_filmy_i_seriale_fk FOREIGN KEY ( filmy_i_seriale_id_f_s ) 
        REFERENCES filmy_i_seriale ( id_f_s );

ALTER TABLE administrator 
    ADD CONSTRAINT administrator_a_fk FOREIGN KEY ( adres_kod_pocztowy ) 
        REFERENCES adres ( kod_pocztowy );

ALTER TABLE f_r 
    ADD CONSTRAINT f_r_filmy_i_seriale_fk FOREIGN KEY ( filmy_i_seriale_id_f_s ) 
        REFERENCES filmy_i_seriale ( id_f_s );

ALTER TABLE f_r 
    ADD CONSTRAINT f_r_rezyser_fk FOREIGN KEY ( rezyser_id_rezysera ) 
        REFERENCES rezyser ( id_rezysera );

ALTER TABLE filmy_i_seriale 
    ADD CONSTRAINT filmy_i_seriale_a_fk FOREIGN KEY ( administrator_id_a ) 
        REFERENCES administrator ( id_administratora );

ALTER TABLE filmy_i_seriale 
    ADD CONSTRAINT filmy_i_seriale_g_fk FOREIGN KEY ( gatunek_id_gatunku ) 
        REFERENCES gatunek ( id_gatunku );

ALTER TABLE filmy_i_seriale 
    ADD CONSTRAINT filmy_i_seriale_kp_fk FOREIGN KEY ( kraj_produkcji_id_kraju ) 
        REFERENCES kraj_produkcji ( id_kraju );

ALTER TABLE filmy_i_seriale 
    ADD CONSTRAINT filmy_i_seriale_p_fk FOREIGN KEY ( pakiety_id_pakietu ) 
        REFERENCES pakiety ( id_pakietu );

ALTER TABLE filmy_i_seriale 
    ADD CONSTRAINT filmy_i_seriale_t_fk FOREIGN KEY ( typ_filmu_i_serialu_id_t ) 
        REFERENCES typ_filmu_i_serialu ( id_typow );

ALTER TABLE klient 
    ADD CONSTRAINT klient_adres_fk FOREIGN KEY ( adres_kod_pocztowy ) 
        REFERENCES adres ( kod_pocztowy );

ALTER TABLE recenzja_filmu_i_serialu 
    ADD CONSTRAINT recenzja_f_s_fk FOREIGN KEY ( filmy_i_seriale_id_f_s ) 
        REFERENCES filmy_i_seriale ( id_f_s );

ALTER TABLE recenzja_filmu_i_serialu 
    ADD CONSTRAINT recenzja_f_s_k_fk FOREIGN KEY ( klient_id_klienta ) 
        REFERENCES klient ( id_klienta );

ALTER TABLE transakcje 
    ADD CONSTRAINT transakcje_u_fk FOREIGN KEY ( umowy_id_umowy ) 
        REFERENCES umowy ( id_umowy );

ALTER TABLE transakcje 
    ADD CONSTRAINT transakcje_w_fk FOREIGN KEY ( wypozyczenia_id_w ) 
        REFERENCES wypozyczenia ( id_wypozyczenia );

ALTER TABLE umowy 
    ADD CONSTRAINT umowy_administrator_fk FOREIGN KEY ( administrator_id_a ) 
        REFERENCES administrator ( id_administratora );

ALTER TABLE umowy 
    ADD CONSTRAINT umowy_klient_fk FOREIGN KEY ( klient_id_klienta ) 
        REFERENCES klient ( id_klienta );

ALTER TABLE umowy 
    ADD CONSTRAINT umowy_pakiety_fk FOREIGN KEY ( pakiety_id_pakietu ) 
        REFERENCES pakiety ( id_pakietu );

ALTER TABLE umowy 
    ADD CONSTRAINT umowy_rodzaj_p_fk FOREIGN KEY ( rodzaj_platnosci_id_p ) 
        REFERENCES rodzaj_platnosci ( id_platnosci );

ALTER TABLE wypozyczenia 
    ADD CONSTRAINT wypozyczenia_ad_fk FOREIGN KEY ( administrator_id_ad ) 
        REFERENCES administrator ( id_administratora );

ALTER TABLE wypozyczenia 
    ADD CONSTRAINT wypozyczenia_f_s_fk FOREIGN KEY ( filmy_i_seriale_id_f_s ) 
        REFERENCES filmy_i_seriale ( id_f_s );

ALTER TABLE wypozyczenia 
    ADD CONSTRAINT wypozyczenia_klient_fk FOREIGN KEY ( klient_id_klienta ) 
        REFERENCES klient ( id_klienta );

ALTER TABLE wypozyczenia 
    ADD CONSTRAINT wypozyczenia_rp_fk FOREIGN KEY ( rodzaj_platnosci_id_p ) 
        REFERENCES rodzaj_platnosci ( id_platnosci );

CREATE SEQUENCE dept_deptidaktorzy_seq;
BEGIN 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Joaquin','Phoenix','48','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Jack','Nicholson','85','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Leonardo','DiCaprio','48','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Al','Pacino','82','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Clint','Eastwood','92','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Anthony','Hopkins','84','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Daniel','Day-Lewis','65','Wielka Brytania'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Robert','Downey Jr.','57','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Joe','Pesci','79','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Will','Smith','54','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Tom','Hiddleston','41','Wielka Brytania'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Tom','Hanks','66','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Edward','Norton','53','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Johnny','Depp','59','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Christoph','Waltz','66','Austria'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Tom','Hardy','45','Wielka Brytania'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Brad','Pitt','58','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Hugh','Jackman','54','Australia'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Jake','Gyllenhaal','41','USA'); 
INSERT INTO aktorzy VALUES (dept_deptidaktorzy_seq.NEXTVAL,'Cillian','Murphy','46','Irlandia'); 
END;
/

BEGIN 
INSERT INTO kraj_produkcji VALUES ('1','Polska'); 
INSERT INTO kraj_produkcji VALUES ('2','Niemcy'); 
INSERT INTO kraj_produkcji VALUES ('3','Francja'); 
INSERT INTO kraj_produkcji VALUES ('4','Wielka Brytania'); 
INSERT INTO kraj_produkcji VALUES ('5','Hiszpania'); 
INSERT INTO kraj_produkcji VALUES ('6','USA'); 
INSERT INTO kraj_produkcji VALUES ('7','Rosja'); 
INSERT INTO kraj_produkcji VALUES ('8','Finlandia'); 
INSERT INTO kraj_produkcji VALUES ('9','Portugalia'); 
INSERT INTO kraj_produkcji VALUES ('10','Turcja'); 
INSERT INTO kraj_produkcji VALUES ('11','Nowa Zelandia'); 
INSERT INTO kraj_produkcji VALUES ('12','Szwajcaria'); 
END;
/

begin  
insert into adres values ('33-230', 'Rzeszow', 'Podkarpackie' ); 
insert into adres values ('33-231', 'Krakow', 'Malopolskie' ); 
insert into adres values ('33-232', 'Warszawa', 'Mazowieckie' ); 
insert into adres values ('33-233', 'Gdansk', 'Podkarpackie' ); 
insert into adres values ('33-234', 'Katowice', 'Slaskie' ); 
insert into adres values ('33-235', 'Kielce', 'Swietokrzyskie' ); 
end;
/

begin 
INSERT INTO administrator VALUES ('1', 'Piotr', 'Pajda', '587567457', 'ppajda@onet.pl', '33-230', 'Szkolna'); 
INSERT INTO administrator VALUES ('2', 'Joanna', 'Mazur', '765887658', 'jmazur@wp.pl', '33-231', 'Promienna'); 
end;
/

CREATE SEQUENCE dept_deptidrezyser_seq;
BEGIN 
INSERT INTO rezyser VALUES (dept_deptidrezyser_seq.NEXTVAL, 'Stanley', 'Kubrick', 54, 'Stany Zjednoczone'  ); 
INSERT INTO rezyser VALUES (dept_deptidrezyser_seq.NEXTVAL, 'James', 'Cameron', 58, 'Kanada'); 
INSERT INTO rezyser VALUES (dept_deptidrezyser_seq.NEXTVAL, 'Jerzy', 'Hoffman', 90, 'Polska'); 
INSERT INTO rezyser VALUES (dept_deptidrezyser_seq.NEXTVAL, 'Quentin', 'Tarantino', 59, 'Stany Zjednoczone'); 
INSERT INTO rezyser VALUES (dept_deptidrezyser_seq.NEXTVAL, 'Wes', 'Anderson', 53, 'Stany Zjednoczone'); 
END;
/

CREATE SEQUENCE dept_deptid_seq;
BEGIN 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Jan', 'Kowlaski', 19, '517928516', 'jkowalski@onet', 'Urocza', '33-230', '' ); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Piotr', 'Kawka', 19, '516753851', 'pkawka@onet', 'Solna', '33-232','' ); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Jadwiga', 'Nowak', 19, '587626881', 'jnowak@onet', 'Wielkopolska', '33-231','' ); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Zuzanna', 'Kijek', 33, '501693279', 'zkijek@onet', 'Partyzantow', '33-235','' ); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Klaudia', 'Hula', 25, '719465578', 'khula@onet', 'Podkarpacka', '33-233', ''); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Waldemar', 'Sroka', 42, '798587436', 'wsroka@onet', 'Ptasia', '33-231', ''); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Pawel', 'Nicpon', 28, '587469875', 'pnicpona@onet', 'Mila', '33-232','' ); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Aleksandra', 'Mila', 17, '953678731', 'amila@onet', 'Wesola', '33-230', ''); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Marcin', 'Ziolko', 31, '467987656', 'mzilko@onet', 'Weteranow', '33-234', ''); 
INSERT INTO klient VALUES (dept_deptid_seq.NEXTVAL, 'Anna', 'Wesolowska', 39, '678876876', 'awesolowska@onet', 'Sadowa', '33-230','' ); 
END;
/

BEGIN 
INSERT INTO typ_filmu_i_serialu VALUES ('1','Premiera'); 
INSERT INTO typ_filmu_i_serialu VALUES ('2','Nowość'); 
INSERT INTO typ_filmu_i_serialu VALUES ('3','Standard'); 
INSERT INTO typ_filmu_i_serialu VALUES ('4','Klasyk'); 
END;
/

BEGIN 
INSERT INTO gatunek VALUES ('1','Horror'); 
INSERT INTO gatunek VALUES ('2','Akcji'); 
INSERT INTO gatunek VALUES ('3','Western'); 
INSERT INTO gatunek VALUES ('4','Animowany'); 
INSERT INTO gatunek VALUES ('5','Komedia'); 
INSERT INTO gatunek VALUES ('6','Romantyczny'); 
INSERT INTO gatunek VALUES ('7','Dramat'); 
INSERT INTO gatunek VALUES ('8','Fabularny'); 
INSERT INTO gatunek VALUES ('9','Fantasy'); 
INSERT INTO gatunek VALUES ('10','Komedia romantyczna'); 
INSERT INTO gatunek VALUES ('11','Kryminalny'); 
INSERT INTO gatunek VALUES ('12','Przygodowy'); 
END;
/

BEGIN 
INSERT INTO pakiety VALUES ('1','Premium','60'); 
INSERT INTO pakiety VALUES ('2','Gold','40'); 
INSERT INTO pakiety VALUES ('3','Standard','20'); 
END; 
/

begin 
insert into filmy_i_seriale values('1','Skazanie na Shawkshank', 
'Adaptacja opowiadania Stephena Kinga.  
Niesłusznie skazany na dożywocie bankier,  
stara się przetrwać w brutalnym, więziennym świecie.', 
20,'7','4','6','2','3',3); 
insert into filmy_i_seriale values('2','Nietykalni', 
'Sparaliżowany milioner zatrudnia do opieki młodego  
chłopaka z przedmieścia, który właśnie wyszedł z więzienia.', 
20,'7','4','3','2','2',2); 
insert into filmy_i_seriale values('3','Avatar Istota wody', 
'Pandorę znów napada wroga korporacja w poszukiwaniu cennych minerałów. 
Jack i Neytiri wraz z rodziną zmuszeni są opuścić wioskę i  
szukać pomocy u innych plemion zamieszkujących planetę.',30,'9','1','6','1','1',1); 
insert into filmy_i_seriale values('4','Usmiechnij sie','Po tym,  
jak dr Rose Carter bierze udział w traumatycznym zdarzeniu z udziałem pacjentki, 
wokół niej zaczynają dziać się niewytłumaczalne rzeczy',30,'1','1','6','1','1',4); 
end;
/

begin  
insert into rodzaj_platnosci values ('1', 'blik');  
insert into rodzaj_platnosci values ('2', 'karta');  
insert into rodzaj_platnosci values ('3', 'przelew'); 
end;
/

begin 
insert into umowy values('1','1','1','12/28/2022','12/28/2023',60,'1','1',''); 
insert into umowy values('2','5','2','01/12/2022','02/12/2022',60,'1','1',''); 
insert into umowy values('3','8','1','02/19/2022','03/19/2022',20,'3','2',''); 
insert into umowy values('4','9','2','01/28/2022','02/28/2022',60,'1','3',''); 
insert into umowy values('5','4','2','12/14/2022','01/14/2023',60,'1','1',''); 
insert into umowy values('6','10','2','07/10/2022','09/10/2022',20,'3','2',''); 
insert into umowy values('7','7','1','03/28/2020','04/28/2020',40,'2','3',''); 
insert into umowy values('8','6','1','04/01/2020','05/01/2020',60,'1','2',''); 
end;
/

begin 
insert into wypozyczenia values('1','1','1','1','12/28/2022','12/30/2022',20,'1','ODDANE'); 
insert into wypozyczenia values('2','5','2','3','01/12/2022','01/28/2022',30,'1','ODDANE'); 
insert into wypozyczenia values('3','8','1','2','02/19/2022','12/28/2022',20,'2','ODDANE'); 
insert into wypozyczenia values('4','9','2','3','01/28/2022','12/20/2022',30,'3','ODDANE'); 
insert into wypozyczenia values('5','4','2','4','12/14/2022','12/15/2022',30,'1','ODDANE'); 
insert into wypozyczenia values('6','10','2','4','07/10/2022','07/15/2022',30,'2','ODDANE'); 
insert into wypozyczenia values('7','7','1','4','03/28/2020','12/30/2020',30,'3','ODDANE'); 
insert into wypozyczenia values('8','6','1','1','04/01/2020','04/28/2020',20,'2','ODDANE'); 
insert into wypozyczenia values('9','6','1','1','04/01/2020','04/05/2020',20,'2','ODDANE'); 
end;
/

begin 
insert into a_f values('1','1'); 
insert into a_f values('1','2'); 
insert into a_f values('1','3'); 
insert into a_f values('3','1'); 
insert into a_f values('5','2'); 
insert into a_f values('19','2'); 
insert into a_f values('20','1'); 
insert into a_f values('8','4'); 
insert into a_f values('10','4'); 
insert into a_f values('4','4'); 
insert into a_f values('17','4'); 
insert into a_f values('12','3'); 
insert into a_f values('13','2'); 
insert into a_f values('11','3'); 
insert into a_f values('4','3'); 
insert into a_f values('14','2'); 
insert into a_f values('12','1'); 
end;
/

begin 
insert into f_r values('1','1'); 
insert into f_r values('2','2'); 
insert into f_r values('3','1'); 
insert into f_r values('4','1'); 
insert into f_r values('1','5'); 
insert into f_r values('2','4'); 
end;
/

CREATE SEQUENCE dept_deptidtransakcje_seq;
begin 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'1',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'2',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','1'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'3',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','2'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'4',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'5',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'6',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','3'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'7',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','4'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'8',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','5'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','6'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','7'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','8'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','9'); 
end;
/
    
BEGIN
INSERT INTO recenzja_filmu_i_serialu VALUES ('1', 'Polecam', '2', '1', '4', '12/28/2022');
INSERT INTO recenzja_filmu_i_serialu VALUES ('2', 'Bardzo fakny film', '5', '3', '5', '12/26/2022');
INSERT INTO recenzja_filmu_i_serialu VALUES ('3', 'Super!!', '2', '3', '4', '12/12/2022');
INSERT INTO recenzja_filmu_i_serialu VALUES ('4', 'Tragedia', '1', '1', '2', '11/10/2022');
INSERT INTO recenzja_filmu_i_serialu VALUES ('5', 'Swietnie', '3', '1', '5', '12/17/2022');
INSERT INTO recenzja_filmu_i_serialu VALUES ('6', 'Okropne', '10', '2', '1', '11/13/2022');
END;
/
    CREATE SEQUENCE rezerw
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
/************************** pakiety *************************************/
/* STATYSTYKA */
CREATE OR REPLACE PACKAGE STATYSTYKA IS
FUNCTION zarobki_z_wypozyczen RETURN INTEGER;
FUNCTION zarobki_z_pakietow RETURN INTEGER;
FUNCTION zarobki_z_wypozyczen_miesiac(data_start DATE, data_koniec DATE) RETURN INTEGER;  
FUNCTION zarobki_z_pakietow_miesiac(data_start DATE, data_koniec DATE) RETURN INTEGER;
FUNCTION srednia_ocena_filmu(id_filmuU NUMBER) RETURN NUMBER;
PROCEDURE raport_ogolny;
PROCEDURE raport_miesieczny;
PROCEDURE ranking_filmow_i_seriali;
END;
/
CREATE OR REPLACE PACKAGE BODY STATYSTYKA AS
/* zarobki_z_wypozyczen */
FUNCTION zarobki_z_wypozyczen RETURN INTEGER IS
    zarobki INTEGER;
BEGIN
    SELECT SUM(kwota_koncowa)
    INTO zarobki
    FROM wypozyczenia;
    RETURN zarobki;
END zarobki_z_wypozyczen;
/* zarobki_z_pakietow */
FUNCTION zarobki_z_pakietow RETURN INTEGER IS
zarobki INTEGER;
BEGIN
SELECT SUM(kwota_koncowa)
INTO zarobki
FROM umowy;
RETURN zarobki;
END zarobki_z_pakietow;
/* zarobki_z_wypozyczen_miesiac */
FUNCTION zarobki_z_wypozyczen_miesiac(data_start DATE, data_koniec DATE) RETURN INTEGER IS 
    zarobki INTEGER; 
BEGIN 
    SELECT SUM(kwota_koncowa) 
    INTO zarobki 
    FROM wypozyczenia 
    WHERE data_wypozyczenia BETWEEN data_start AND data_koniec; 
    RETURN COALESCE(zarobki, 0); 
END zarobki_z_wypozyczen_miesiac; 
/* zarobki_z_pakietow_miesiac */
FUNCTION zarobki_z_pakietow_miesiac(data_start DATE, data_koniec DATE) RETURN INTEGER IS 
    zarobki INTEGER; 
BEGIN 
    SELECT SUM(kwota_koncowa) 
    INTO zarobki 
    FROM umowy 
    WHERE data_zawarcia_umowy BETWEEN data_start AND data_koniec; 
    RETURN COALESCE(zarobki, 0); 
END zarobki_z_pakietow_miesiac; 
/* srednia_ocena_filmu */
FUNCTION srednia_ocena_filmu(id_filmuU NUMBER) RETURN NUMBER IS
    srednia_ocena NUMBER;
BEGIN
    SELECT AVG(ocena)
    INTO srednia_ocena
    FROM recenzja_filmu_i_serialu
    WHERE filmy_i_seriale_id_f_s = id_filmuU;
    RETURN srednia_ocena;
END srednia_ocena_filmu;
/* raport_ogolny */
PROCEDURE raport_ogolny IS
    zarobki_wypozyczenia INTEGER;
    zarobki_pakiety INTEGER;
BEGIN
    zarobki_wypozyczenia := zarobki_z_wypozyczen();
    zarobki_pakiety := zarobki_z_pakietow();
    
    DBMS_OUTPUT.PUT_LINE('Raport o zarobkach:');
    DBMS_OUTPUT.PUT_LINE('Zarobki z wypozyczen: ' || zarobki_wypozyczenia);
    DBMS_OUTPUT.PUT_LINE('Zarobki z pakietow: ' || zarobki_pakiety);
    DBMS_OUTPUT.PUT_LINE('Calkowite zarobki: ' || (zarobki_wypozyczenia + zarobki_pakiety));
END Raport_ogolny;
/* raport_miesieczny */
PROCEDURE raport_miesieczny IS
    poczatkowa_data DATE;
    koncowa_data DATE;
    miesiac_poczatek DATE;
    miesiac_koniec DATE;
    zar_wyp INTEGER;
    zar_pak INTEGER;
BEGIN
    poczatkowa_data := TO_DATE('2022-01-01', 'YYYY-MM-DD');
    koncowa_data := TO_DATE('2022-12-31', 'YYYY-MM-DD');

    DBMS_OUTPUT.PUT_LINE('RAPORT O ZAROBKACH MIESIECZNYCH:');
    DBMS_OUTPUT.PUT_LINE('xxxxxxxxxxxxxxxxxxxxxx');
    FOR i IN 1..12 LOOP
        miesiac_poczatek := ADD_MONTHS(poczatkowa_data, i - 1);
        miesiac_koniec := LAST_DAY(miesiac_poczatek);
        
        zar_wyp :=  zarobki_z_wypozyczen_miesiac(miesiac_poczatek, miesiac_koniec);
        zar_pak :=  zarobki_z_pakietow_miesiac(miesiac_poczatek, miesiac_koniec);

        DBMS_OUTPUT.PUT_LINE('Miesiac: ' || TO_CHAR(miesiac_poczatek, 'MM/YYYY'));
        DBMS_OUTPUT.PUT_LINE('Zarobki z wypozyczen: ' || zar_wyp);
        DBMS_OUTPUT.PUT_LINE('Zarobki z pakietow: ' || zar_pak);
        DBMS_OUTPUT.PUT_LINE('Calkowite zarobki: ' || (zar_wyp + zar_pak));
        DBMS_OUTPUT.PUT_LINE('xxxxxxxxxxxxxxxxxxxxxx');
    END LOOP;
END raport_miesieczny;
/* ranking_filmow_i_seriali */
PROCEDURE ranking_filmow_i_seriali IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Ranking filmów:');
    DBMS_OUTPUT.PUT_LINE('xxxxxxxxxxxxxxxx');
    FOR film IN (SELECT f.tytul, COALESCE(TO_CHAR(srednia_ocena_filmu(f.id_f_s)), 'Film nie został jeszcze oceniony') AS srednia_ocena
                     FROM filmy_i_seriale f
                     ORDER BY TO_NUMBER(srednia_ocena_filmu(f.id_f_s)) DESC) LOOP
        DBMS_OUTPUT.PUT_LINE(film.tytul || ' - Średnia ocena: ' || film.srednia_ocena);
    END LOOP;
END ranking_filmow_i_seriali;
END;
/
/**** klient_obsluga ****/
CREATE OR REPLACE PACKAGE KLIENT_OBSLUGA IS
FUNCTION obsluga_liczby(str VARCHAR2) RETURN BOOLEAN;
FUNCTION obsluga_litery(str VARCHAR2) RETURN BOOLEAN;
FUNCTION obsluga_symbole(str VARCHAR2) RETURN BOOLEAN;
FUNCTION czy_dostepny(p_id_filmu NUMBER) RETURN BOOLEAN;
FUNCTION czy_pakiet_premium(p_id_klienta NUMBER) RETURN BOOLEAN;
PROCEDURE DodajKlienta( 
    imieU VARCHAR2, 
    nazwiskoU VARCHAR2, 
    wiekU INTEGER, 
    nr_telefonuU INTEGER, 
    emailU VARCHAR2, 
    ulicaU VARCHAR2, 
    adres_kod_pocztowyU VARCHAR2);
PROCEDURE wypozycz(
    id_klientaU IN INTEGER,
    id_filmuU IN INTEGER,
    rezerwacjaU IN INTEGER DEFAULT 0,
    platnosc in integer);
END;
/
CREATE OR REPLACE PACKAGE BODY KLIENT_OBSLUGA AS
/* OBSLUGA_LICZBY */
FUNCTION obsluga_liczby(str VARCHAR2) RETURN BOOLEAN IS
BEGIN
    FOR i IN 1..LENGTH(str) LOOP
        IF ASCII(SUBSTR(str, i, 1)) BETWEEN ASCII('0') AND ASCII('9') THEN
            RETURN TRUE;
        END IF;
    END LOOP;
    RETURN FALSE;
END obsluga_liczby;
/* OBSLUGA_LTERY */
FUNCTION obsluga_litery(str VARCHAR2) RETURN BOOLEAN IS
BEGIN
    FOR i IN 1..LENGTH(str) LOOP
        IF ASCII(SUBSTR(str, i, 1)) BETWEEN ASCII('A') AND ASCII('Z')
           OR ASCII(SUBSTR(str, i, 1)) BETWEEN ASCII('a') AND ASCII('z') THEN
            RETURN TRUE;
        END IF;
    END LOOP;
    RETURN FALSE;
END obsluga_litery;
/* OBSLUGA_SYMBOLE */
FUNCTION obsluga_symbole(str VARCHAR2) RETURN BOOLEAN IS
BEGIN
    FOR i IN 1..LENGTH(str) LOOP
        IF SUBSTR(str, i, 1) = '@' THEN
            RETURN TRUE;
        END IF;
    END LOOP;
    RETURN FALSE;
END obsluga_symbole;
/* CZY_DOSTEPNY */
FUNCTION czy_dostepny(p_id_filmu NUMBER) RETURN BOOLEAN IS
    v_ilosc NUMBER;
BEGIN
    SELECT ilosc INTO v_ilosc
    FROM filmy_i_seriale
    WHERE id_f_s = p_id_filmu;

    RETURN v_ilosc > 0;
END czy_dostepny;
/* CZY_PAKIET_PREMIUM */
FUNCTION czy_pakiet_premium(p_id_klienta NUMBER) RETURN BOOLEAN IS
pakietU VARCHAR2(40);
BEGIN
    SELECT pakiet INTO pakietU
    FROM klient
    WHERE id_klienta = p_id_klienta;

    RETURN pakietU = 'Premium';
END czy_pakiet_premium;
/* DODAJKLIENTA */
PROCEDURE DodajKlienta( 
    imieU VARCHAR2, 
    nazwiskoU VARCHAR2, 
    wiekU INTEGER, 
    nr_telefonuU INTEGER, 
    emailU VARCHAR2, 
    ulicaU VARCHAR2, 
    adres_kod_pocztowyU VARCHAR2 ) IS 
    brak_imienia EXCEPTION;
    brak_nazwiska EXCEPTION;
    brak_wieku EXCEPTION;
    brak_numeru EXCEPTION;
    brak_emailu EXCEPTION;
    brak_ulicy EXCEPTION;

    adres_id VARCHAR2(50); 
    max_klient_id NUMBER; 
BEGIN 
    IF (imieU IS NULL) OR obsluga_liczby(imieU)  THEN
        RAISE brak_imienia;
    ELSIF nazwiskoU IS NULL OR obsluga_liczby(nazwiskoU) THEN
        RAISE brak_nazwiska;
    ELSIF wiekU IS NULL OR obsluga_litery(wiekU) OR obsluga_symbole(wiekU) THEN
        RAISE brak_wieku;
    ELSIF nr_telefonuU IS NULL OR obsluga_litery(nr_telefonuU) OR obsluga_symbole(nr_telefonuU) THEN
        RAISE brak_numeru;
	ELSIF emailU IS NULL OR NOT obsluga_symbole(emailU) THEN
        RAISE brak_emailu;
	ELSIF ulicaU IS NULL THEN
        RAISE brak_ulicy;
    ELSE
        SELECT kod_pocztowy INTO adres_id FROM adres WHERE kod_pocztowy = adres_kod_pocztowyU; 
        SELECT MAX(id_klienta) INTO max_klient_id FROM klient; 
        INSERT INTO klient (id_klienta, imie, nazwisko, wiek, nr_telefonu, email, ulica, adres_kod_pocztowy) 
        VALUES (max_klient_id + 1, imieU, nazwiskoU, wiekU, nr_telefonuU, emailU, ulicaU, adres_kod_pocztowyU); 
        DBMS_OUTPUT.PUT_LINE('Klient dodany pomyślnie.'); 
    END IF;

EXCEPTION 
    WHEN brak_imienia THEN
    	DBMS_OUTPUT.PUT_LINE('Nie wprowadzono imienia lub wprowadzono niedozwolone znaki. Uzupełnij dane.'); 
	WHEN brak_nazwiska THEN
    	DBMS_OUTPUT.PUT_LINE('Nie wprowadzono nazwiska lub wprowadzono niedozwolone znaki. Uzupełnij dane.'); 
	WHEN brak_wieku THEN
    	DBMS_OUTPUT.PUT_LINE('Nie wprowadzono wieku lub wprowadzono niedozwolone znaki. Uzupełnij dane.'); 
	WHEN brak_numeru THEN
    	DBMS_OUTPUT.PUT_LINE('Nie wprowadzono numeru telefonu lub wprowadzono niedozwolone znaki. Uzupełnij dane.'); 
	WHEN brak_emailu THEN
    	DBMS_OUTPUT.PUT_LINE('Nie wprowadzono adresu e-mail lub jest nieprawidłowy. Uzupełnij dane.'); 
	WHEN brak_ulicy THEN
    	DBMS_OUTPUT.PUT_LINE('Nie wprowadzono ulicy w adresie lub wprowadzono niedozwolone znaki. Uzupełnij dane.'); 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Podany kod pocztowy nie istnieje w tabeli adres.'); 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Wystąpił błąd podczas dodawania klienta'); 
END DodajKlienta;
/* WYPOZYCZ */
PROCEDURE wypozycz(
    id_klientaU IN INTEGER,
    id_filmuU IN INTEGER,
    rezerwacjaU IN INTEGER DEFAULT 0,
    platnosc in integer
) IS
    ilosc_dniU NUMBER := 7;
    cenaU NUMBER;
    data_wypU DATE;
    data_oddU DATE;
    data_zakU DATE;
    data_rezU DATE;
    pakietU VARCHAR2(40);
    stan_filmuU INTEGER;
    data_koncowaU DATE;
    wypozyczenia_idU INTEGER;
zla_platnosc exception;
rez_blad exception;
zly_klient exception;
zly_film exception;
BEGIN
IF platnosc NOT IN (1, 2, 3) THEN
    RAISE zla_platnosc;
ELSIF rezerwacjaU NOT IN (0,1) THEN
    RAISE rez_blad;
ELSIF id_klientaU is NULL or id_klientaU = 0 then
    RAISE zly_klient;
ELSIF id_filmuU is NULL or id_filmuU = 0 then
    RAISE zly_film;
ELSE
    IF czy_dostepny(id_filmuU) THEN
        SELECT ilosc INTO stan_filmuU
        FROM filmy_i_seriale
        WHERE id_f_s = id_filmuU;

        IF czy_pakiet_premium(id_klientaU) THEN
            SELECT CASE
                       WHEN ilosc_dniU > (SELECT MONTHS_BETWEEN(u.data_zakoczenia_umowy, SYSDATE) + 1
                                          FROM umowy u
                                          WHERE u.klient_id_klienta = id_klientaU
                                            AND SYSDATE BETWEEN u.data_zawarcia_umowy AND u.data_zakoczenia_umowy)
                           THEN (SELECT MONTHS_BETWEEN(u.data_zakoczenia_umowy, SYSDATE) + 1
                                 FROM umowy u
                                 WHERE u.klient_id_klienta = id_klientaU
                                   AND SYSDATE BETWEEN u.data_zawarcia_umowy AND u.data_zakoczenia_umowy)
                       ELSE ilosc_dniU
                   END
            INTO ilosc_dniU
            FROM dual;
            cenaU := 0;
        ELSE
            SELECT cena INTO cenaU
            FROM filmy_i_seriale
            WHERE id_f_s = id_filmuU;
        END IF;

        data_wypU := SYSDATE;
        data_oddU := SYSDATE + ilosc_dniU;

        UPDATE filmy_i_seriale
        SET ilosc = stan_filmuU - 1
        WHERE id_f_s = id_filmuU;

        SELECT MAX(id_wypozyczenia) + 1 INTO wypozyczenia_idU
        FROM wypozyczenia;

        INSERT INTO wypozyczenia (id_wypozyczenia, klient_id_klienta, administrator_id_ad, filmy_i_seriale_id_f_s, data_wypozyczenia, data_oddania, kwota_koncowa, rodzaj_platnosci_id_p, status)
        VALUES (wypozyczenia_idU, id_klientaU, 1, id_filmuU, data_wypU, data_oddU, cenaU, platnosc, 'W TRAKCIE');
        DBMS_OUTPUT.PUT_LINE('Film wypożyczony! Data oddania: ' || TO_CHAR(data_oddU, 'DD.MM.YYYY'));
    ELSE
        IF rezerwacjaU = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Wpadnij kiedy indziej!');

            SELECT MAX(data_koncowa) INTO data_zakU
            FROM rezerwacje
            WHERE filmy_i_seriale_id_f_s = id_filmuU
              AND data_koncowa IS NOT NULL;

            SELECT MAX(data_oddania) INTO data_oddU
            FROM wypozyczenia
            WHERE filmy_i_seriale_id_f_s = id_filmuU;
            IF data_zakU IS NOT NULL AND data_zakU > data_oddU THEN
                DBMS_OUTPUT.PUT_LINE('Ostatnia rezerwacja zakończona dnia: ' || TO_CHAR(data_zakU, 'DD.MM.YYYY'));
            ELSE
                DBMS_OUTPUT.PUT_LINE('Ostatnie wypożyczenie zakończone dnia: ' || TO_CHAR(data_oddU, 'DD.MM.YYYY'));
            END IF;
        ELSIF rezerwacjaU = 1 THEN

            SELECT MAX(data_koncowa) INTO data_zakU
            FROM rezerwacje
            WHERE filmy_i_seriale_id_f_s = id_filmuU
              AND data_koncowa IS NOT NULL;

            SELECT MAX(data_oddania) INTO data_oddU
            FROM wypozyczenia
            WHERE filmy_i_seriale_id_f_s = id_filmuU;

            IF data_zakU IS NOT NULL AND data_zakU > data_oddU THEN
                data_rezU := data_zakU + 1;
            ELSIF data_oddU IS NOT NULL THEN
                data_rezU := data_oddU + 1;
            ELSE
                data_rezU := SYSDATE + 1;
            END IF;
            data_koncowaU := data_rezU + 7;

            SELECT MAX(id_rezerwacji) + 1 INTO wypozyczenia_idU
            FROM rezerwacje;

            INSERT INTO rezerwacje (id_rezerwacji, klient_id_klienta, filmy_i_seriale_id_f_s, data_poczatkowa, data_koncowa)
            VALUES (rezerw.NEXTVAL, id_klientaU, id_filmuU, data_rezU, data_koncowaU);
            DBMS_OUTPUT.PUT_LINE('Film zarezerwowany do ' || TO_CHAR(data_koncowaU, 'DD.MM.YYYY'));
        END IF;
    END IF;
END IF;
EXCEPTION
WHEN zla_platnosc THEN
    DBMS_OUTPUT.PUT_LINE('zla platnosc');
    RETURN;
WHEN rez_blad THEN
    DBMS_OUTPUT.PUT_LINE('Zle okreslenie rezerwacji! Jezeli chcesz zarezerwowac przy wypozyczeniu wpisz 1, jezeli nie wpisz 0!');
    RETURN;
when zly_klient then 
        DBMS_OUTPUT.PUT_LINE('Niepoprawne id uzytkownika');
    RETURN;
when zly_film then 
        DBMS_OUTPUT.PUT_LINE('Niepoprawne id filmu');
    RETURN;
when OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Cos poszlo nie tak! Sprawdz wpisane dane!');
    RETURN;
END wypozycz;
END;
/

/**** ADMINISTRACJA ****/
CREATE OR REPLACE PACKAGE ADMINISTRACJA IS
FUNCTION czy_umowa_aktywna(id_umowyU IN INTEGER) RETURN BOOLEAN;
FUNCTION czy_aktywna(id_umowyU IN INTEGER) RETURN BOOLEAN;
PROCEDURE aktualizacja_status_umowy;
PROCEDURE pakiety_klient;
PROCEDURE oddaj (id_wypozyczeniaU IN INTEGER);
END;
/
CREATE OR REPLACE PACKAGE BODY ADMINISTRACJA AS
/* CZY_UMOWA_AKTYWNA */
FUNCTION czy_umowa_aktywna(id_umowyU IN INTEGER) RETURN BOOLEAN IS
    data_zakonczenia DATE;
BEGIN
    SELECT data_zakoczenia_umowy INTO data_zakonczenia
    FROM umowy
    WHERE id_umowy = id_umowyU;
    IF data_zakonczenia IS NULL OR data_zakonczenia > SYSDATE THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/* CZY_AKTYWNA */
FUNCTION czy_aktywna(id_umowyU IN INTEGER) RETURN BOOLEAN IS
    data_zawarcia_umowy umowy.data_zawarcia_umowy%TYPE;
    aktualna_data DATE;
    roznica NUMBER;
BEGIN
    SELECT data_zawarcia_umowy INTO data_zawarcia_umowy
    FROM umowy
    WHERE id_umowy = id_umowyU;
    aktualna_data := SYSDATE;
    roznica := aktualna_data - data_zawarcia_umowy;
    IF roznica >= 30 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/* AKTUALIZACJA_STATUS_UMOWY */
PROCEDURE aktualizacja_status_umowy IS
    CURSOR umowy_cursor IS
        SELECT *
        FROM umowy;
    umowa umowy%ROWTYPE;
BEGIN
    FOR umowa_rec IN umowy_cursor LOOP
        umowa := umowa_rec;

        IF czy_aktywna(umowa.id_umowy) THEN
            UPDATE umowy
            SET status = 'NIEAKTYWNA'
            WHERE id_umowy = umowa.id_umowy;

            DBMS_OUTPUT.PUT_LINE('Status umowy o ID ' || umowa.id_umowy || ' został zaktualizowany na NIEAKTYWNA.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Nie minęło jeszcze 30 dni od zawarcia umowy o ID ' || umowa.id_umowy);
        END IF;
    END LOOP;
END;
/* PAKIET_KLIENT */
PROCEDURE pakiety_klient AS
    id_umowy umowy.id_umowy%TYPE;
    id_klientaU umowy.klient_id_klienta%TYPE;
    rodzaj_umowy umowy.rodzaj_platnosci_id_p%TYPE;
BEGIN
    FOR umowa IN (SELECT * FROM umowy) LOOP
        id_umowy := umowa.id_umowy;
        id_klientaU := umowa.klient_id_klienta;
        rodzaj_umowy := umowa.rodzaj_platnosci_id_p;
        IF czy_umowa_aktywna(id_umowy) THEN
            UPDATE klient
            SET pakiet = CASE
                            WHEN rodzaj_umowy = 1 THEN 'Podstawowy'
                            WHEN rodzaj_umowy = 2 THEN 'Standardowy'
                            WHEN rodzaj_umowy = 3 THEN 'Premium'
                            ELSE 'Brak'
                         END
            WHERE id_klienta = id_klientaU;
        ELSE
            DBMS_OUTPUT.PUT_LINE('BRAK AKTYWNEJ UMOWY DLA KLIENTA O ID: ' || id_klientaU);
        END IF;
    END LOOP;
END pakiety_klient;
/* ODDAJ */
PROCEDURE oddaj (
    id_wypozyczeniaU IN INTEGER
) IS
    statusU           VARCHAR2(40);
    data_wypozyczeniaU DATE;
    data_dzisiejszaU DATE := SYSDATE;
    cenaU             INTEGER;
    stan_filmuU       INTEGER;
    rezerwacja_idU    INTEGER;
    stan_premiumU     VARCHAR2(10);
    ilosc_dniU        INTEGER;
    data_oddaniaU     DATE;
    id_klientaU       INTEGER;
    nowe_id_wypozyczeniaU INTEGER;
	rekord rezerwacje%ROWTYPE;
	i NUMBER:=0;
	max_id_wypozyczenia INTEGER;
        
	TYPE rezerwacje_historia IS TABLE OF rezerwacje%ROWTYPE;
	rezerwacja rezerwacje_historia:=rezerwacje_historia();
	zle_id_wypozyczenia exception;
BEGIN
SELECT MAX(id_wypozyczenia) INTO max_id_wypozyczenia FROM wypozyczenia;
IF id_wypozyczeniaU > max_id_wypozyczenia THEN
    RAISE zle_id_wypozyczenia;
ELSE
    SELECT status, data_wypozyczenia, klient_id_klienta
    INTO statusU, data_wypozyczeniaU, id_klientaU
    FROM wypozyczenia
    WHERE id_wypozyczenia = id_wypozyczeniaU;

    IF statusU = 'W TRAKCIE' THEN
        IF data_dzisiejszaU- data_wypozyczeniaU > 7 THEN
            UPDATE wypozyczenia
            SET status = 'ODDANE'
            WHERE id_wypozyczenia = id_wypozyczeniaU;

            SELECT MIN(id_rezerwacji)
            INTO rezerwacja_idU
            FROM rezerwacje
            WHERE filmy_i_seriale_id_f_s = (
                SELECT filmy_i_seriale_id_f_s
                FROM wypozyczenia
                WHERE id_wypozyczenia = id_wypozyczeniaU
            );

            IF rezerwacja_idU IS NOT NULL THEN
                SELECT klient_id_klienta, filmy_i_seriale_id_f_s
                INTO id_klientaU, stan_filmuU
                FROM rezerwacje
                WHERE id_rezerwacji = rezerwacja_idU;
                FOR rekord IN (SELECT * FROM rezerwacje WHERE id_rezerwacji = rezerwacja_idU) LOOP
                 i:=i+1;
                 rezerwacja.EXTEND;
                 rezerwacja(i):=rekord;
                END LOOP;

                DELETE FROM rezerwacje WHERE id_rezerwacji = rezerwacja_idU;

                FOR i IN 1..rezerwacja.COUNT LOOP
                            DBMS_OUTPUT.PUT_LINE('ID Rezerwacji: ' || rezerwacja(i).id_rezerwacji);
                          	DBMS_OUTPUT.PUT_LINE('ID Klienta: ' || rezerwacja(i).klient_id_klienta);
                            DBMS_OUTPUT.PUT_LINE('ID filmu lub serialu: ' || rezerwacja(i).FILMY_I_SERIALE_ID_F_S) ;
                            DBMS_OUTPUT.PUT_LINE('Data poczatkowa: ' || rezerwacja(i).DATA_POCZATKOWA );
                            DBMS_OUTPUT.PUT_LINE('Data koncowa: ' || rezerwacja(i).DATA_KONCOWA);
                        END LOOP;

                SELECT cena
                INTO cenaU
                FROM filmy_i_seriale
                WHERE id_f_s = stan_filmuU;

                SELECT pakiet
                INTO stan_premiumU
                FROM klient
                WHERE id_klienta = id_klientaU;

                IF stan_premiumU = 'PREMIUM' THEN
                    cenaU := 0;

                    SELECT u.DATA_ZAKOCZENIA_UMOWY - SYSDATE
                    INTO ilosc_dniU
                    FROM umowy u
                    JOIN klient k ON u.klient_id_klienta = k.id_klienta
                    WHERE k.id_klienta = id_klientaU;

                    IF ilosc_dniU < 7 THEN
                        data_oddaniaU := SYSDATE + ilosc_dniU;
                    ELSE
                        data_oddaniaU := SYSDATE + 7;
                    END IF;
                ELSE
                    data_oddaniaU := SYSDATE + 7;
                END IF;

                SELECT MAX(id_wypozyczenia) + 1
                INTO nowe_id_wypozyczeniaU
                FROM wypozyczenia;

                INSERT INTO wypozyczenia (id_wypozyczenia, klient_id_klienta, filmy_i_seriale_id_f_s, administrator_id_ad, data_wypozyczenia, data_oddania, kwota_koncowa, rodzaj_platnosci_id_p, status)
                VALUES (nowe_id_wypozyczeniaU, id_klientaU, stan_filmuU, 1, SYSDATE, data_oddaniaU, cenaU, 2, 'W TRAKCIE');
            ELSE
                UPDATE filmy_i_seriale
                SET ilosc = ilosc + 1
                WHERE id_f_s = (
                    SELECT filmy_i_seriale_id_f_s
                    FROM wypozyczenia
                    WHERE id_wypozyczenia = id_wypozyczeniaU
                );
            END IF;
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Film nie jest wypożyczony.');
    END IF;
END IF;
EXCEPTION
WHEN zle_id_wypozyczenia THEN
    DBMS_OUTPUT.PUT_LINE('Zle id wypozyczenia');
    RETURN;
END oddaj;
END;
/

end;
/

begin 
insert into wypozyczenia values('1','1','1','1','12/28/2022','12/30/2022',20,'1','ODDANE'); 
insert into wypozyczenia values('2','5','2','3','01/12/2022','01/28/2022',30,'1','ODDANE'); 
insert into wypozyczenia values('3','8','1','2','02/19/2022','12/28/2022',20,'2','ODDANE'); 
insert into wypozyczenia values('4','9','2','3','01/28/2022','12/20/2022',30,'3','ODDANE'); 
insert into wypozyczenia values('5','4','2','4','12/14/2022','12/15/2022',30,'1','ODDANE'); 
insert into wypozyczenia values('6','10','2','4','07/10/2022','07/15/2022',30,'2','ODDANE'); 
insert into wypozyczenia values('7','7','1','4','03/28/2020','12/30/2020',30,'3','ODDANE'); 
insert into wypozyczenia values('8','6','1','1','04/01/2020','04/28/2020',20,'2','ODDANE'); 
insert into wypozyczenia values('9','6','1','1','04/01/2020','04/05/2020',20,'2','ODDANE'); 
end;
/


begin 
insert into a_f values('1','1'); 
insert into a_f values('1','2'); 
insert into a_f values('1','3'); 
insert into a_f values('3','1'); 
insert into a_f values('5','2'); 
insert into a_f values('19','2'); 
insert into a_f values('20','1'); 
insert into a_f values('8','4'); 
insert into a_f values('10','4'); 
insert into a_f values('4','4'); 
insert into a_f values('17','4'); 
insert into a_f values('12','3'); 
insert into a_f values('13','2'); 
insert into a_f values('11','3'); 
insert into a_f values('4','3'); 
insert into a_f values('14','2'); 
insert into a_f values('12','1'); 
end;
/

begin 
insert into f_r values('1','1'); 
insert into f_r values('2','2'); 
insert into f_r values('3','1'); 
insert into f_r values('4','1'); 
insert into f_r values('1','5'); 
insert into f_r values('2','4'); 
end;
/

CREATE SEQUENCE dept_deptidtransakcje_seq;
begin 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'1',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'2',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','1'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'3',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','2'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'4',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'5',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'6',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','3'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'7',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','4'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'8',''); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','5'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','6'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','7'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','8'); 
insert into transakcje values(dept_deptidtransakcje_seq.NEXTVAL,'','9'); 
end;
/
    
BEGIN
INSERT INTO recenzja_filmu_i_serialu VALUES ('1', 'Polecam', '2', '1', '4', '12/28/2022');
INSERT INTO recenzja_filmu_i_serialu VALUES ('2', 'Bardzo fakny film', '5', '3', '5', '12/26/2022');
INSERT INTO recenzja_filmu_i_serialu VALUES ('3', 'Super!!', '2', '3', '4', '12/12/2022');
INSERT INTO recenzja_filmu_i_serialu VALUES ('4', 'Tragedia', '1', '1', '2', '11/10/2022');
INSERT INTO recenzja_filmu_i_serialu VALUES ('5', 'Swietnie', '3', '1', '5', '12/17/2022');
INSERT INTO recenzja_filmu_i_serialu VALUES ('6', 'Okropne', '10', '2', '1', '11/13/2022');
END;
/

    CREATE SEQUENCE rezerw
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

/* ADMINISTRACJA */
create or replace package "ADMINISTRACJA" as
FUNCTION czy_umowa_aktywna(id_umowyU IN INTEGER) RETURN BOOLEAN;
FUNCTION czy_aktywna(id_umowyU IN INTEGER) RETURN BOOLEAN;
PROCEDURE aktualizacja_status_umowy;
PROCEDURE pakiety_klient;
PROCEDURE oddaj (id_wypozyczeniaU IN INTEGER);
end "ADMINISTRACJA";
/
create or replace package body "ADMINISTRACJA" as
/* CZY_UMOWA_AKTYWNA */
FUNCTION czy_umowa_aktywna(id_umowyU IN INTEGER) RETURN BOOLEAN IS
    data_zakonczenia DATE;
BEGIN
    SELECT data_zakoczenia_umowy INTO data_zakonczenia
    FROM umowy
    WHERE id_umowy = id_umowyU;
    IF data_zakonczenia IS NULL OR data_zakonczenia > SYSDATE THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/* CZY_AKTYWNA */
FUNCTION czy_aktywna(id_umowyU IN INTEGER) RETURN BOOLEAN IS
    data_zawarcia_umowy umowy.data_zawarcia_umowy%TYPE;
    aktualna_data DATE;
    roznica NUMBER;
BEGIN
    SELECT data_zawarcia_umowy INTO data_zawarcia_umowy
    FROM umowy
    WHERE id_umowy = id_umowyU;
    aktualna_data := SYSDATE;
    roznica := aktualna_data - data_zawarcia_umowy;
    IF roznica >= 30 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/* AKTUALIZACJA_STATUS_UMOWY */
PROCEDURE aktualizacja_status_umowy IS
    CURSOR umowy_cursor IS
        SELECT *
        FROM umowy;
    umowa umowy%ROWTYPE;
BEGIN
    FOR umowa_rec IN umowy_cursor LOOP
        umowa := umowa_rec;

        IF czy_aktywna(umowa.id_umowy) THEN
            UPDATE umowy
            SET status = 'NIEAKTYWNA'
            WHERE id_umowy = umowa.id_umowy;

            DBMS_OUTPUT.PUT_LINE('Status umowy o ID ' || umowa.id_umowy || ' został zaktualizowany na NIEAKTYWNA.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Nie minęło jeszcze 30 dni od zawarcia umowy o ID ' || umowa.id_umowy);
        END IF;
    END LOOP;
END;
/* PAKIET_KLIENT */
PROCEDURE pakiety_klient AS
    id_umowy umowy.id_umowy%TYPE;
    id_klientaU umowy.klient_id_klienta%TYPE;
    rodzaj_umowy umowy.rodzaj_platnosci_id_p%TYPE;
BEGIN
    FOR umowa IN (SELECT * FROM umowy) LOOP
        id_umowy := umowa.id_umowy;
        id_klientaU := umowa.klient_id_klienta;
        rodzaj_umowy := umowa.rodzaj_platnosci_id_p;
        IF czy_umowa_aktywna(id_umowy) THEN
            UPDATE klient
            SET pakiet = CASE
                            WHEN rodzaj_umowy = 1 THEN 'Podstawowy'
                            WHEN rodzaj_umowy = 2 THEN 'Standardowy'
                            WHEN rodzaj_umowy = 3 THEN 'Premium'
                            ELSE 'Brak'
                         END
            WHERE id_klienta = id_klientaU;
        ELSE
            DBMS_OUTPUT.PUT_LINE('BRAK AKTYWNEJ UMOWY DLA KLIENTA O ID: ' || id_klientaU);
        END IF;
    END LOOP;
END pakiety_klient;
/* ODDAJ */
PROCEDURE oddaj (
    id_wypozyczeniaU IN INTEGER
) IS
    statusU           VARCHAR2(40);
    data_wypozyczeniaU DATE;
    data_dzisiejszaU DATE := SYSDATE;
    cenaU             INTEGER;
    stan_filmuU       INTEGER;
    rezerwacja_idU    INTEGER;
    stan_premiumU     VARCHAR2(10);
    ilosc_dniU        INTEGER;
    data_oddaniaU     DATE;
    id_klientaU       INTEGER;
    nowe_id_wypozyczeniaU INTEGER;
	rekord rezerwacje%ROWTYPE;
	i NUMBER:=0;
	max_id_wypozyczenia INTEGER;
        
	TYPE rezerwacje_historia IS TABLE OF rezerwacje%ROWTYPE;
	rezerwacja rezerwacje_historia:=rezerwacje_historia();
	zle_id_wypozyczenia exception;
BEGIN
SELECT MAX(id_wypozyczenia) INTO max_id_wypozyczenia FROM wypozyczenia;
IF id_wypozyczeniaU > max_id_wypozyczenia THEN
    RAISE zle_id_wypozyczenia;
ELSE
    SELECT status, data_wypozyczenia, klient_id_klienta
    INTO statusU, data_wypozyczeniaU, id_klientaU
    FROM wypozyczenia
    WHERE id_wypozyczenia = id_wypozyczeniaU;

    IF statusU = 'W TRAKCIE' THEN
        IF data_dzisiejszaU- data_wypozyczeniaU > 7 THEN
            UPDATE wypozyczenia
            SET status = 'ODDANE'
            WHERE id_wypozyczenia = id_wypozyczeniaU;

            SELECT MIN(id_rezerwacji)
            INTO rezerwacja_idU
            FROM rezerwacje
            WHERE filmy_i_seriale_id_f_s = (
                SELECT filmy_i_seriale_id_f_s
                FROM wypozyczenia
                WHERE id_wypozyczenia = id_wypozyczeniaU
            );

            IF rezerwacja_idU IS NOT NULL THEN
                SELECT klient_id_klienta, filmy_i_seriale_id_f_s
                INTO id_klientaU, stan_filmuU
                FROM rezerwacje
                WHERE id_rezerwacji = rezerwacja_idU;
                FOR rekord IN (SELECT * FROM rezerwacje WHERE id_rezerwacji = rezerwacja_idU) LOOP
                 i:=i+1;
                 rezerwacja.EXTEND;
                 rezerwacja(i):=rekord;
                END LOOP;

                DELETE FROM rezerwacje WHERE id_rezerwacji = rezerwacja_idU;

                FOR i IN 1..rezerwacja.COUNT LOOP
                            DBMS_OUTPUT.PUT_LINE('ID Rezerwacji: ' || rezerwacja(i).id_rezerwacji);
                          	DBMS_OUTPUT.PUT_LINE('ID Klienta: ' || rezerwacja(i).klient_id_klienta);
                            DBMS_OUTPUT.PUT_LINE('ID filmu lub serialu: ' || rezerwacja(i).FILMY_I_SERIALE_ID_F_S) ;
                            DBMS_OUTPUT.PUT_LINE('Data poczatkowa: ' || rezerwacja(i).DATA_POCZATKOWA );
                            DBMS_OUTPUT.PUT_LINE('Data koncowa: ' || rezerwacja(i).DATA_KONCOWA);
                        END LOOP;

                SELECT cena
                INTO cenaU
                FROM filmy_i_seriale
                WHERE id_f_s = stan_filmuU;

                SELECT pakiet
                INTO stan_premiumU
                FROM klient
                WHERE id_klienta = id_klientaU;

                IF stan_premiumU = 'PREMIUM' THEN
                    cenaU := 0;

                    SELECT u.DATA_ZAKOCZENIA_UMOWY - SYSDATE
                    INTO ilosc_dniU
                    FROM umowy u
                    JOIN klient k ON u.klient_id_klienta = k.id_klienta
                    WHERE k.id_klienta = id_klientaU;

                    IF ilosc_dniU < 7 THEN
                        data_oddaniaU := SYSDATE + ilosc_dniU;
                    ELSE
                        data_oddaniaU := SYSDATE + 7;
                    END IF;
                ELSE
                    data_oddaniaU := SYSDATE + 7;
                END IF;

                SELECT MAX(id_wypozyczenia) + 1
                INTO nowe_id_wypozyczeniaU
                FROM wypozyczenia;

                INSERT INTO wypozyczenia (id_wypozyczenia, klient_id_klienta, filmy_i_seriale_id_f_s, administrator_id_ad, data_wypozyczenia, data_oddania, kwota_koncowa, rodzaj_platnosci_id_p, status)
                VALUES (nowe_id_wypozyczeniaU, id_klientaU, stan_filmuU, 1, SYSDATE, data_oddaniaU, cenaU, 2, 'W TRAKCIE');
            ELSE
                UPDATE filmy_i_seriale
                SET ilosc = ilosc + 1
                WHERE id_f_s = (
                    SELECT filmy_i_seriale_id_f_s
                    FROM wypozyczenia
                    WHERE id_wypozyczenia = id_wypozyczeniaU
                );
            END IF;
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Film nie jest wypożyczony.');
    END IF;
END IF;
EXCEPTION
WHEN zle_id_wypozyczenia THEN
    DBMS_OUTPUT.PUT_LINE('Zle id wypozyczenia');
    RETURN;
END oddaj;
end "ADMINISTRACJA";
/

/* KLIENT_OBSLUGA */
create or replace package "KLIENT_OBSLUGA" as
FUNCTION obsluga_liczby(str VARCHAR2) RETURN BOOLEAN;
FUNCTION obsluga_litery(str VARCHAR2) RETURN BOOLEAN;
FUNCTION obsluga_symbole(str VARCHAR2) RETURN BOOLEAN;
FUNCTION czy_dostepny(p_id_filmu NUMBER) RETURN BOOLEAN;
FUNCTION czy_pakiet_premium(p_id_klienta NUMBER) RETURN BOOLEAN;
PROCEDURE DodajKlienta( 
    imieU VARCHAR2, 
    nazwiskoU VARCHAR2, 
    wiekU INTEGER, 
    nr_telefonuU INTEGER, 
    emailU VARCHAR2, 
    ulicaU VARCHAR2, 
    adres_kod_pocztowyU VARCHAR2);
PROCEDURE wypozycz(
    id_klientaU IN INTEGER,
    id_filmuU IN INTEGER,
    rezerwacjaU IN INTEGER DEFAULT 0,
    platnosc in integer);
end "KLIENT_OBSLUGA";
/
create or replace package body "KLIENT_OBSLUGA" as
/* OBSLUGA_LICZBY */
FUNCTION obsluga_liczby(str VARCHAR2) RETURN BOOLEAN IS
BEGIN
    FOR i IN 1..LENGTH(str) LOOP
        IF ASCII(SUBSTR(str, i, 1)) BETWEEN ASCII('0') AND ASCII('9') THEN
            RETURN TRUE;
        END IF;
    END LOOP;
    RETURN FALSE;
END obsluga_liczby;
/* OBSLUGA_LTERY */
FUNCTION obsluga_litery(str VARCHAR2) RETURN BOOLEAN IS
BEGIN
    FOR i IN 1..LENGTH(str) LOOP
        IF ASCII(SUBSTR(str, i, 1)) BETWEEN ASCII('A') AND ASCII('Z')
           OR ASCII(SUBSTR(str, i, 1)) BETWEEN ASCII('a') AND ASCII('z') THEN
            RETURN TRUE;
        END IF;
    END LOOP;
    RETURN FALSE;
END obsluga_litery;
/* OBSLUGA_SYMBOLE */
FUNCTION obsluga_symbole(str VARCHAR2) RETURN BOOLEAN IS
BEGIN
    FOR i IN 1..LENGTH(str) LOOP
        IF SUBSTR(str, i, 1) = '@' THEN
            RETURN TRUE;
        END IF;
    END LOOP;
    RETURN FALSE;
END obsluga_symbole;
/* CZY_DOSTEPNY */
FUNCTION czy_dostepny(p_id_filmu NUMBER) RETURN BOOLEAN IS
    v_ilosc NUMBER;
BEGIN
    SELECT ilosc INTO v_ilosc
    FROM filmy_i_seriale
    WHERE id_f_s = p_id_filmu;

    RETURN v_ilosc > 0;
END czy_dostepny;
/* CZY_PAKIET_PREMIUM */
FUNCTION czy_pakiet_premium(p_id_klienta NUMBER) RETURN BOOLEAN IS
pakietU VARCHAR2(40);
BEGIN
    SELECT pakiet INTO pakietU
    FROM klient
    WHERE id_klienta = p_id_klienta;

    RETURN pakietU = 'Premium';
END czy_pakiet_premium;
/* DODAJKLIENTA */
PROCEDURE DodajKlienta( 
    imieU VARCHAR2, 
    nazwiskoU VARCHAR2, 
    wiekU INTEGER, 
    nr_telefonuU INTEGER, 
    emailU VARCHAR2, 
    ulicaU VARCHAR2, 
    adres_kod_pocztowyU VARCHAR2 ) IS 
    brak_imienia EXCEPTION;
    brak_nazwiska EXCEPTION;
    brak_wieku EXCEPTION;
    brak_numeru EXCEPTION;
    brak_emailu EXCEPTION;
    brak_ulicy EXCEPTION;

    adres_id VARCHAR2(50); 
    max_klient_id NUMBER; 
BEGIN 
    IF (imieU IS NULL) OR obsluga_liczby(imieU)  THEN
        RAISE brak_imienia;
    ELSIF nazwiskoU IS NULL OR obsluga_liczby(nazwiskoU) THEN
        RAISE brak_nazwiska;
    ELSIF wiekU IS NULL OR obsluga_litery(wiekU) OR obsluga_symbole(wiekU) THEN
        RAISE brak_wieku;
    ELSIF nr_telefonuU IS NULL OR obsluga_litery(nr_telefonuU) OR obsluga_symbole(nr_telefonuU) THEN
        RAISE brak_numeru;
	ELSIF emailU IS NULL OR NOT obsluga_symbole(emailU) THEN
        RAISE brak_emailu;
	ELSIF ulicaU IS NULL THEN
        RAISE brak_ulicy;
    ELSE
        SELECT kod_pocztowy INTO adres_id FROM adres WHERE kod_pocztowy = adres_kod_pocztowyU; 
        SELECT MAX(id_klienta) INTO max_klient_id FROM klient; 
        INSERT INTO klient (id_klienta, imie, nazwisko, wiek, nr_telefonu, email, ulica, adres_kod_pocztowy) 
        VALUES (max_klient_id + 1, imieU, nazwiskoU, wiekU, nr_telefonuU, emailU, ulicaU, adres_kod_pocztowyU); 
        DBMS_OUTPUT.PUT_LINE('Klient dodany pomyślnie.'); 
    END IF;

EXCEPTION 
    WHEN brak_imienia THEN
    	DBMS_OUTPUT.PUT_LINE('Nie wprowadzono imienia lub wprowadzono niedozwolone znaki. Uzupełnij dane.'); 
	WHEN brak_nazwiska THEN
    	DBMS_OUTPUT.PUT_LINE('Nie wprowadzono nazwiska lub wprowadzono niedozwolone znaki. Uzupełnij dane.'); 
	WHEN brak_wieku THEN
    	DBMS_OUTPUT.PUT_LINE('Nie wprowadzono wieku lub wprowadzono niedozwolone znaki. Uzupełnij dane.'); 
	WHEN brak_numeru THEN
    	DBMS_OUTPUT.PUT_LINE('Nie wprowadzono numeru telefonu lub wprowadzono niedozwolone znaki. Uzupełnij dane.'); 
	WHEN brak_emailu THEN
    	DBMS_OUTPUT.PUT_LINE('Nie wprowadzono adresu e-mail lub jest nieprawidłowy. Uzupełnij dane.'); 
	WHEN brak_ulicy THEN
    	DBMS_OUTPUT.PUT_LINE('Nie wprowadzono ulicy w adresie lub wprowadzono niedozwolone znaki. Uzupełnij dane.'); 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Podany kod pocztowy nie istnieje w tabeli adres.'); 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Wystąpił błąd podczas dodawania klienta'); 
END DodajKlienta;
/* WYPOZYCZ */
PROCEDURE wypozycz(
    id_klientaU IN INTEGER,
    id_filmuU IN INTEGER,
    rezerwacjaU IN INTEGER DEFAULT 0,
    platnosc in integer
) IS
    ilosc_dniU NUMBER := 7;
    cenaU NUMBER;
    data_wypU DATE;
    data_oddU DATE;
    data_zakU DATE;
    data_rezU DATE;
    pakietU VARCHAR2(40);
    stan_filmuU INTEGER;
    data_koncowaU DATE;
    wypozyczenia_idU INTEGER;
zla_platnosc exception;
rez_blad exception;
zly_klient exception;
zly_film exception;
BEGIN
IF platnosc NOT IN (1, 2, 3) THEN
    RAISE zla_platnosc;
ELSIF rezerwacjaU NOT IN (0,1) THEN
    RAISE rez_blad;
ELSIF id_klientaU is NULL or id_klientaU = 0 then
    RAISE zly_klient;
ELSIF id_filmuU is NULL or id_filmuU = 0 then
    RAISE zly_film;
ELSE
    IF czy_dostepny(id_filmuU) THEN
        SELECT ilosc INTO stan_filmuU
        FROM filmy_i_seriale
        WHERE id_f_s = id_filmuU;

        IF czy_pakiet_premium(id_klientaU) THEN
            SELECT CASE
                       WHEN ilosc_dniU > (SELECT MONTHS_BETWEEN(u.data_zakoczenia_umowy, SYSDATE) + 1
                                          FROM umowy u
                                          WHERE u.klient_id_klienta = id_klientaU
                                            AND SYSDATE BETWEEN u.data_zawarcia_umowy AND u.data_zakoczenia_umowy)
                           THEN (SELECT MONTHS_BETWEEN(u.data_zakoczenia_umowy, SYSDATE) + 1
                                 FROM umowy u
                                 WHERE u.klient_id_klienta = id_klientaU
                                   AND SYSDATE BETWEEN u.data_zawarcia_umowy AND u.data_zakoczenia_umowy)
                       ELSE ilosc_dniU
                   END
            INTO ilosc_dniU
            FROM dual;
            cenaU := 0;
        ELSE
            SELECT cena INTO cenaU
            FROM filmy_i_seriale
            WHERE id_f_s = id_filmuU;
        END IF;

        data_wypU := SYSDATE;
        data_oddU := SYSDATE + ilosc_dniU;

        UPDATE filmy_i_seriale
        SET ilosc = stan_filmuU - 1
        WHERE id_f_s = id_filmuU;

        SELECT MAX(id_wypozyczenia) + 1 INTO wypozyczenia_idU
        FROM wypozyczenia;

        INSERT INTO wypozyczenia (id_wypozyczenia, klient_id_klienta, administrator_id_ad, filmy_i_seriale_id_f_s, data_wypozyczenia, data_oddania, kwota_koncowa, rodzaj_platnosci_id_p, status)
        VALUES (wypozyczenia_idU, id_klientaU, 1, id_filmuU, data_wypU, data_oddU, cenaU, platnosc, 'W TRAKCIE');
        DBMS_OUTPUT.PUT_LINE('Film wypożyczony! Data oddania: ' || TO_CHAR(data_oddU, 'DD.MM.YYYY'));
    ELSE
        IF rezerwacjaU = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Wpadnij kiedy indziej!');

            SELECT MAX(data_koncowa) INTO data_zakU
            FROM rezerwacje
            WHERE filmy_i_seriale_id_f_s = id_filmuU
              AND data_koncowa IS NOT NULL;

            SELECT MAX(data_oddania) INTO data_oddU
            FROM wypozyczenia
            WHERE filmy_i_seriale_id_f_s = id_filmuU;
            IF data_zakU IS NOT NULL AND data_zakU > data_oddU THEN
                DBMS_OUTPUT.PUT_LINE('Ostatnia rezerwacja zakończona dnia: ' || TO_CHAR(data_zakU, 'DD.MM.YYYY'));
            ELSE
                DBMS_OUTPUT.PUT_LINE('Ostatnie wypożyczenie zakończone dnia: ' || TO_CHAR(data_oddU, 'DD.MM.YYYY'));
            END IF;
        ELSIF rezerwacjaU = 1 THEN

            SELECT MAX(data_koncowa) INTO data_zakU
            FROM rezerwacje
            WHERE filmy_i_seriale_id_f_s = id_filmuU
              AND data_koncowa IS NOT NULL;

            SELECT MAX(data_oddania) INTO data_oddU
            FROM wypozyczenia
            WHERE filmy_i_seriale_id_f_s = id_filmuU;

            IF data_zakU IS NOT NULL AND data_zakU > data_oddU THEN
                data_rezU := data_zakU + 1;
            ELSIF data_oddU IS NOT NULL THEN
                data_rezU := data_oddU + 1;
            ELSE
                data_rezU := SYSDATE + 1;
            END IF;
            data_koncowaU := data_rezU + 7;

            SELECT MAX(id_rezerwacji) + 1 INTO wypozyczenia_idU
            FROM rezerwacje;

            INSERT INTO rezerwacje (id_rezerwacji, klient_id_klienta, filmy_i_seriale_id_f_s, data_poczatkowa, data_koncowa)
            VALUES (rezerw.NEXTVAL, id_klientaU, id_filmuU, data_rezU, data_koncowaU);
            DBMS_OUTPUT.PUT_LINE('Film zarezerwowany do ' || TO_CHAR(data_koncowaU, 'DD.MM.YYYY'));
        END IF;
    END IF;
END IF;
EXCEPTION
WHEN zla_platnosc THEN
    DBMS_OUTPUT.PUT_LINE('zla platnosc');
    RETURN;
WHEN rez_blad THEN
    DBMS_OUTPUT.PUT_LINE('Zle okreslenie rezerwacji! Jezeli chcesz zarezerwowac przy wypozyczeniu wpisz 1, jezeli nie wpisz 0!');
    RETURN;
when zly_klient then 
        DBMS_OUTPUT.PUT_LINE('Niepoprawne id uzytkownika');
    RETURN;
when zly_film then 
        DBMS_OUTPUT.PUT_LINE('Niepoprawne id filmu');
    RETURN;
when OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Cos poszlo nie tak! Sprawdz wpisane dane!');
    RETURN;
END wypozycz;
end "KLIENT_OBSLUGA";
/

/* STATYSTYKA */
create or replace package "STATYSTYKA" as
FUNCTION zarobki_z_wypozyczen RETURN INTEGER;
FUNCTION zarobki_z_pakietow RETURN INTEGER;
FUNCTION zarobki_z_wypozyczen_miesiac(data_start DATE, data_koniec DATE) RETURN INTEGER;  
FUNCTION zarobki_z_pakietow_miesiac(data_start DATE, data_koniec DATE) RETURN INTEGER;
FUNCTION srednia_ocena_filmu(id_filmuU NUMBER) RETURN NUMBER;
PROCEDURE raport_ogolny;
PROCEDURE raport_miesieczny;
PROCEDURE ranking_filmow_i_seriali;
end "STATYSTYKA";
/
create or replace package body "STATYSTYKA" as
/* zarobki_z_wypozyczen */
FUNCTION zarobki_z_wypozyczen RETURN INTEGER IS
    zarobki INTEGER;
BEGIN
    SELECT SUM(kwota_koncowa)
    INTO zarobki
    FROM wypozyczenia;
    RETURN zarobki;
END zarobki_z_wypozyczen;
/* zarobki_z_pakietow */
FUNCTION zarobki_z_pakietow RETURN INTEGER IS
zarobki INTEGER;
BEGIN
SELECT SUM(kwota_koncowa)
INTO zarobki
FROM umowy;
RETURN zarobki;
END zarobki_z_pakietow;
/* zarobki_z_wypozyczen_miesiac */
FUNCTION zarobki_z_wypozyczen_miesiac(data_start DATE, data_koniec DATE) RETURN INTEGER IS 
    zarobki INTEGER; 
BEGIN 
    SELECT SUM(kwota_koncowa) 
    INTO zarobki 
    FROM wypozyczenia 
    WHERE data_wypozyczenia BETWEEN data_start AND data_koniec; 
    RETURN COALESCE(zarobki, 0); 
END zarobki_z_wypozyczen_miesiac; 
/* zarobki_z_pakietow_miesiac */
FUNCTION zarobki_z_pakietow_miesiac(data_start DATE, data_koniec DATE) RETURN INTEGER IS 
    zarobki INTEGER; 
BEGIN 
    SELECT SUM(kwota_koncowa) 
    INTO zarobki 
    FROM umowy 
    WHERE data_zawarcia_umowy BETWEEN data_start AND data_koniec; 
    RETURN COALESCE(zarobki, 0); 
END zarobki_z_pakietow_miesiac; 
/* srednia_ocena_filmu */
FUNCTION srednia_ocena_filmu(id_filmuU NUMBER) RETURN NUMBER IS
    srednia_ocena NUMBER;
BEGIN
    SELECT AVG(ocena)
    INTO srednia_ocena
    FROM recenzja_filmu_i_serialu
    WHERE filmy_i_seriale_id_f_s = id_filmuU;
    RETURN srednia_ocena;
END srednia_ocena_filmu;
/* raport_ogolny */
PROCEDURE raport_ogolny IS
    zarobki_wypozyczenia INTEGER;
    zarobki_pakiety INTEGER;
BEGIN
    zarobki_wypozyczenia := zarobki_z_wypozyczen();
    zarobki_pakiety := zarobki_z_pakietow();
    
    DBMS_OUTPUT.PUT_LINE('Raport o zarobkach:');
    DBMS_OUTPUT.PUT_LINE('Zarobki z wypozyczen: ' || zarobki_wypozyczenia);
    DBMS_OUTPUT.PUT_LINE('Zarobki z pakietow: ' || zarobki_pakiety);
    DBMS_OUTPUT.PUT_LINE('Calkowite zarobki: ' || (zarobki_wypozyczenia + zarobki_pakiety));
END Raport_ogolny;
/* raport_miesieczny */
PROCEDURE raport_miesieczny IS
    poczatkowa_data DATE;
    koncowa_data DATE;
    miesiac_poczatek DATE;
    miesiac_koniec DATE;
    zar_wyp INTEGER;
    zar_pak INTEGER;
BEGIN
    poczatkowa_data := TO_DATE('2022-01-01', 'YYYY-MM-DD');
    koncowa_data := TO_DATE('2022-12-31', 'YYYY-MM-DD');

    DBMS_OUTPUT.PUT_LINE('RAPORT O ZAROBKACH MIESIECZNYCH:');
    DBMS_OUTPUT.PUT_LINE('xxxxxxxxxxxxxxxxxxxxxx');
    FOR i IN 1..12 LOOP
        miesiac_poczatek := ADD_MONTHS(poczatkowa_data, i - 1);
        miesiac_koniec := LAST_DAY(miesiac_poczatek);
        
        zar_wyp :=  zarobki_z_wypozyczen_miesiac(miesiac_poczatek, miesiac_koniec);
        zar_pak :=  zarobki_z_pakietow_miesiac(miesiac_poczatek, miesiac_koniec);

        DBMS_OUTPUT.PUT_LINE('Miesiac: ' || TO_CHAR(miesiac_poczatek, 'MM/YYYY'));
        DBMS_OUTPUT.PUT_LINE('Zarobki z wypozyczen: ' || zar_wyp);
        DBMS_OUTPUT.PUT_LINE('Zarobki z pakietow: ' || zar_pak);
        DBMS_OUTPUT.PUT_LINE('Calkowite zarobki: ' || (zar_wyp + zar_pak));
        DBMS_OUTPUT.PUT_LINE('xxxxxxxxxxxxxxxxxxxxxx');
    END LOOP;
END raport_miesieczny;
/* ranking_filmow_i_seriali */
PROCEDURE ranking_filmow_i_seriali IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Ranking filmów:');
    DBMS_OUTPUT.PUT_LINE('xxxxxxxxxxxxxxxx');
    FOR film IN (SELECT f.tytul, COALESCE(TO_CHAR(srednia_ocena_filmu(f.id_f_s)), 'Film nie został jeszcze oceniony') AS srednia_ocena
                     FROM filmy_i_seriale f
                     ORDER BY TO_NUMBER(srednia_ocena_filmu(f.id_f_s)) DESC) LOOP
        DBMS_OUTPUT.PUT_LINE(film.tytul || ' - Średnia ocena: ' || film.srednia_ocena);
    END LOOP;
END ranking_filmow_i_seriali;
end "STATYSTYKA";
/