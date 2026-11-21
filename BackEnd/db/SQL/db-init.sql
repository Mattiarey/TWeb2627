/* Tables */
CREATE TABLE SOCIETA (
    id_societa INTEGER NOT NULL,
    nome INTEGER NOT NULL,
    provincia INTEGER,
    regione_provenienza INTEGER,
    nazione_provenienza INTEGER,
    email_referente INTEGER,
    telefono_referente INTEGER,
    PRIMARY KEY (id_societa)
);
CREATE TABLE CATEGORIA (
    id_categoria INTEGER NOT NULL,
    formato_gioco INTEGER NOT NULL,
    tipo_categoria INTEGER NOT NULL,
    PRIMARY KEY (id_categoria)
);
CREATE TABLE TORNEO (
    id_torneo INTEGER NOT NULL,
    nome INTEGER NOT NULL,
    data_inizio INTEGER NOT NULL,
    data_fine INTEGER NOT NULL,
    luogo INTEGER NOT NULL,
    giornate_giocate INTEGER NOT NULL,
    PRIMARY KEY (id_torneo)
);
CREATE TABLE GIOCATORE (
    id_persona INTEGER NOT NULL,
    data_nascita INTEGER NOT NULL,
    nome INTEGER NOT NULL,
    cognome INTEGER NOT NULL,
    PRIMARY KEY (id_persona)
);
CREATE TABLE GENITORE (
    id_persona INTEGER NOT NULL,
    nome INTEGER NOT NULL,
    cognome INTEGER NOT NULL,
    PRIMARY KEY (id_persona)
);
CREATE TABLE HOTEL (
    id_hotel INTEGER NOT NULL,
    nome INTEGER NOT NULL,
    indirizzo INTEGER NOT NULL,
    distanza INTEGER NOT NULL,
    telefono INTEGER,
    email INTEGER,
    PRIMARY KEY (id_hotel)
);
CREATE TABLE SQUADRA (
    id_squadra INTEGER NOT NULL,
    nome INTEGER NOT NULL,
    SOCIETA_id_societa INTEGER NOT NULL,
    CATEGORIA_id_categoria INTEGER NOT NULL,
    PRIMARY KEY (id_squadra),
    FOREIGN KEY (SOCIETA_id_societa) REFERENCES SOCIETA (id_societa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (CATEGORIA_id_categoria) REFERENCES CATEGORIA (id_categoria)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
CREATE TABLE ISCRIZIONE (
    id_iscrizione INTEGER NOT NULL,
    data_iscrizione INTEGER NOT NULL,
    stato INTEGER NOT NULL,
    num_giocatori_previsti INTEGER,
    num_accompagnatori_previsti INTEGER,
    note INTEGER,
    SQUADRA_id_squadra INTEGER NOT NULL,
    TORNEO_id_torneo INTEGER NOT NULL,
    HOTEL_id_hotel INTEGER,
    PRIMARY KEY (id_iscrizione),
    FOREIGN KEY (SQUADRA_id_squadra) REFERENCES SQUADRA (id_squadra)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (TORNEO_id_torneo) REFERENCES TORNEO (id_torneo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (HOTEL_id_hotel) REFERENCES HOTEL (id_hotel)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
CREATE TABLE TARIFFA (
    id_tariffa INTEGER NOT NULL,
    costo INTEGER NOT NULL,
    descrizione INTEGER NOT NULL,
    TORNEO_id_torneo INTEGER NOT NULL,
    PRIMARY KEY (id_tariffa),
    FOREIGN KEY (TORNEO_id_torneo) REFERENCES TORNEO (id_torneo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
CREATE TABLE PARTECIPAZIONE (
    id_partecipazione INTEGER NOT NULL,
    ISCRIZIONE_id_iscrizione INTEGER NOT NULL,
    GIOCATORE_id_persona INTEGER NOT NULL,
    TARIFFA_id_tariffa INTEGER NOT NULL,
    STANZA_id_stanza INTEGER,
    data_inizio INTEGER,
    data_fine INTEGER,
    PRIMARY KEY (id_partecipazione),
    FOREIGN KEY (ISCRIZIONE_id_iscrizione) REFERENCES ISCRIZIONE (id_iscrizione)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (GIOCATORE_id_persona) REFERENCES GIOCATORE (id_persona)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (TARIFFA_id_tariffa) REFERENCES TARIFFA (id_tariffa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (STANZA_id_stanza) REFERENCES STANZA (id_stanza)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
CREATE TABLE DISPONIBILITA_CAMERE (
    id_disponibilita INTEGER NOT NULL,
    tipologia_camera INTEGER NOT NULL,
    quantita_disponibile INTEGER NOT NULL,
    HOTEL_id_hotel INTEGER NOT NULL,
    TORNEO_id_torneo INTEGER NOT NULL,
    PRIMARY KEY (id_disponibilita),
    FOREIGN KEY (HOTEL_id_hotel) REFERENCES HOTEL (id_hotel)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (TORNEO_id_torneo) REFERENCES TORNEO (id_torneo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
CREATE TABLE ASSEGNAZIONE_CAMERE (
    id_assegnazione INTEGER NOT NULL,
    tipologia_camera INTEGER NOT NULL,
    quantita_assegnata INTEGER NOT NULL,
    ISCRIZIONE_id_iscrizione INTEGER NOT NULL,
    HOTEL_id_hotel INTEGER NOT NULL,
    PRIMARY KEY (id_assegnazione),
    FOREIGN KEY (ISCRIZIONE_id_iscrizione) REFERENCES ISCRIZIONE (id_iscrizione)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (HOTEL_id_hotel) REFERENCES HOTEL (id_hotel)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
CREATE TABLE STANZA (
    id_stanza INTEGER NOT NULL,
    numero INTEGER NOT NULL,
    posti_letto INTEGER NOT NULL,
    HOTEL_id_hotel INTEGER NOT NULL,
    PRIMARY KEY (id_stanza),
    FOREIGN KEY (HOTEL_id_hotel) REFERENCES HOTEL (id_hotel)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
CREATE TABLE OCCUPARE_GENITORE (
    GENITORE_id_persona INTEGER NOT NULL,
    STANZA_id_stanza INTEGER NOT NULL,
    data_inizio INTEGER NOT NULL,
    data_fine INTEGER NOT NULL,
    PRIMARY KEY (GENITORE_id_persona, STANZA_id_stanza),
    FOREIGN KEY (GENITORE_id_persona) REFERENCES GENITORE (id_persona)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (STANZA_id_stanza) REFERENCES STANZA (id_stanza)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);