# Gestore dei tornei
Di Ughetto Luca e Rey Mattia

### Appunti presi
Il torneo parte da una brochure
Si mandano gli inviti alle società (che contengono le squadre) e ogni società pubblicizzano la brochure dentro alle proprie squadre
Nella brochure c'è nome, data e categorie
14-19 giovanile + scuola calcio, 2 tornei

Settore giovanile 11v11, gli altr sono meno
C'è da gestire anch eil catering per i tizi
2 giorni di torneo (sabato mattina e fine domenica), le squadre arrivano il giorno prima. Quindi 2 notti per forza

Gestione tariffe con formula a roulette. Soldi pagati e da pagare. Creazione automatica del rendiconto. Sconti manuali
Gestione dell'hotel è fondamentale (+30 hotel). La prenotazione avviene molto prima rispetto al torneo
Le squadre vengono messe dentro un hotel in modo da riempire al meglio senza spezzarle. Bisogna comunque che si possano spostare le squadre a mano e segnare piano piano dentro a un hotel al posto di un altro
Mostrare magari la distanze dal campo e tenere le richieste

Ogni informazione e ogni dato deve essere eventualmente modificabile a mano: squadra nell'hotel, sconto, ecc... Quindi bisogna poter prevedere delle eccezioni

Serve una pagina con le squadre divise per categoria.
Non tutte le squadre per forza dormono

Realizzazione del calendario (maybe)
divisione tra mattino e pomeriggio
6-7 partite. Di sicuro 4 al sabato e giocano anche la domenica
solo le prime 18 giocano contro le professioniste. Alcune di questa fase finale giocano comunque il sabato

Per fare un calendario: provincie e regioni diverse si scontrano per quanto possibile, anche al pomeriggio. Nei primi due gironi
Idealmente bisognerebbe bilanciare il numero di partite tra il sabato e la domenica. Non va troppo bene che siano 6 il sabato e 2 la domenica


Adesione -> questionario provvisorio -> questionario definitivo -> incastrare le persone nell'hotel (scegliere a monte il tipo di camere) -> risposta con l'hotel -> si spostano le squadre per accontentare -> rooming list

Rooming list

## Base di dati
### Glossario dei termini

| Termine | Descrizione | Sinonimi | Collegamenti |
| :--- | :--- | :--- | :--- |
|brochure|viene inviata alle società per invitarle|x|torneo|
|torneo|unità di tempo base per l'organizzazione e divisione di tutto. Dura più giorni|x|categoria, tariffa, hotel|
|categoria|un torneo offre gare per diverse categorie. |x|torneo|
|tariffa|ogni giocatore sceglie la tariffa che più gli si addice|x|torneo, hotel|
|rendiconto|a fine torneo viene creato raggruppando le tariffe di tutte le squadre di una società. C'è la possibilità di applicare degli sconti manualmente|x|società, tariffa|
|hotel|contiene le camere e ospita le squadre senza spezzarle|x|torneo, tariffa, squadra|
|calendario|rappresenta come verranno fatte le partite tra squadre|x|squadra, torneo|
|rooming list| lista che viene compilata dalle società dove loro comunicano quale giocatore sarà in quale tipo di stanza|x|società, torneo, hotel|
|società|contiene le squadre e si interfaccia con gli organizzatori|x|squadra|
|squadra|contiene i giocatori e non può venir spezzata|x|società, calendario|

#### Scelte progettuali riguardanti i termini, sinonimi e ambiguità
1. La brochure in realtà viene ignorata dal database
2. "Formula a roulette" si riferisce soltanto al modo in cui vengono assegnate le camere. In sostanza solo l'organizzatore sceglie l'ordine delle camere. Le società possono soltanto esprimere delle preferenze che forse potrebbero venire ascoltate.
3. Neanche il calendario verrà immagazzinato nel DB. Verrà calcolato da un algoritmo quando si avranno tutte le squadre e salvato in un json.
---
### Requisiti rivisti
Si vuole progettare una base di dati per gestire la creazione di tornei sportivi.

Questa base di dati conterrà informazioni su tornei, squadre partecipati e le loro società, tariffe e hotel in cui i giocatori delle squadre dovranno alloggiare.

La creazione del torneo avviene in una sequenza ed è possibile che da un passo all'altro passino settimane, anche perché si tratta di interfacciarsi con decine di hotel e centinaia di squadre, con giocatori e genitori al seguito. Per un totale di migliaia di persone. La sequenza è la seguente:
1. Si manda la brochure a tutte le società che la faranno vedere alle proprie squadre e ai propri giocatori;
2. Le società comunicano la propria adesione;
3. Le società rispondono agli organizzatori compilando un questionario *provvisorio*. Questo questionario comunica in modo indicativo quante squadre, quanti giocatori e quanti genitori parteciperanno;
4. Le società rispondono agli organizzatori compilando il questionario *definitivo* (anche se poi sotto banco piccole modifiche e aggiunte possono venir fatte);
5. Logica per inserire le persone negli hotel. Questa logica non va a toccare precisamente ogni giocatore: si sa quante camere da quante persone un hotel mette a disposizione e si usa questo numero per creare la lista di camere che userà ogni singola squadra (o forse ogni singola società, non saprei bene onestamente !!!!!!!!!!!!);
6. Si comunica alle società l'hotel e il tipo di camere messe a disposizione (es: 4 camere da 3 persone e 2 camere da 5);
7. Le squadre si lamenteranno e quindi verranno fatti piccoli aggiustamenti per accontentarli il più possibile;
8. La società risponda con le rooming list (es: in una camera da 3 ci saranno Marco, Paolo e Daniele);
9. Le rooming list vengono comunicate dagli organizzatori agli hotel.

In teoria parallelamente al passo 5, dato che si sanno già definitivamente le squadre, si fa anche il calcolo del calendario. È importante tenere calcolare anche che squadre della stessa regione, e magari provincia, è meglio che non giochino assieme. Inoltre il numero di partite giocate per squadra giornalmente è meglio che sia spalmato ugualmente sui giorni del torneo: è meglioche una squadra non giochi 6 partite il sabato e solo 2 la domenica.

Il torneo ha dentro di se diverse categorie basate sugli anni dei giocatori e categorie diverse possono giocare con formati diversi.

Ogni giornata di torneo ha un catering da organizzare, ma non credo che spetti a questa applicazione farlo.

Le tariffe variano a seconda di quello che sceglie ciascun giocatore e verranno sommate tutte e trasmesso il rendiconto alla società.

Al torneo partecipano anche squadre professioniste, ma loro avranno delle tariffe particolari.

È assolutamente di massima importanza che ogni dato possa venir modificato in ogni momento.

---
### Schema ER
![Disegno schema ER](BackEnd/db/schemaER-copia.png)

#### Scelte progettuali
1. Ogni singolo giocatore di ogni squadra può effettuare un'iscrizione singola scegliendo esattamente una tra le tariffe proposte dal torneo.
2. Il controllo che la tariffa dal giocatore sia una tra le proposte dal torneo è svolto dall'operatore e non deve essere garantito dal modello *** non credo sia detto: è comunque collegato al torneo
3. il database deve fornire alla richiesta, le stanze dell'hotel disponibili per quel particolare torneo, non è necessario sapere tutte le stanze dell'hotel ma solo quelle fornite dall'hotel stesso per quel particolare torneo.
4. I genitori possono accompagnare i figli negli hotel dormendo nelle stanze fornite ma non devono per forza dormire nella loro stessa stanza e neanche nello stesso hotel.
5. Non serve conoscere il legame tra padre e figlio, questo viene gestito esternamente.
6. Ogni torneo propone delle tariffe proprie ed è possibile che di edizione in edizione queste tariffe cambino.
7. I tornei ospitano diverse categorie di squadre e ogni squadra è parte di una società, la quale può avere più squadre.
8. Per ogni nuova edizione di un torneo viene creata una nuova squadra e una nuova iscrizione, senza modificare i giocatori delle edizioni passate così da mantenere lo storico.
9. Una squadra che pernotta viene assegnata a un solo hotel, e tutte le stanze riservate per quella squadra devono appartenere a quell'hotel.
10. È possibile che vengano organizzati più tornei lo stesso anno ma sempre in periodi diversi ed è necessario mantenere la storicità dei giocatori che hanno giocato ai tornei, delle stanze fornite e degli hotel che hanno partecipato a quel determinato torneo.
11. Un genitore viene registrato nel sistema soltanto se pernotta in almeno una stanza.
12. Un genitore può specificare la preferenza di voler stare con il figlio per quel pernottamento ma si tratta solo di una preferenza gestita dall'operatore

#### Business rules
1. Un giocatore sceglie una sola tariffa per ogni iscrizione a un torneo, e deve essere tra quelle proposte per quel torneo.
2. Un giocatore paga la tariffa anche per l'eventuale genitore, perché i genitori non hanno una tariffa propria.
3. Se c'è una nuova edizione di un torneo o un altro torneo anche nello stesso anno in periodi diversi, si fanno nuove squadre, nuove iscrizioni, nuove partecipazioni e nuove tariffe senza toccare lo storico e i giocatori passati.
4. Il legame tra genitore e figlio è gestito fuori dal database.
5. Un genitore viene messo nel sistema solo se pernotta in almeno una stanza.
6. La preferenza con_figlio dice che il genitore vorrebbe stare nella stanza del figlio, ma resta una preferenza gestita dall'operatore o dall'app, non un obbligo fisso.
7. L'occupazione di una stanza da parte di giocatore o genitore deve tornare con iscrizione, torneo, stanze riservate/disponibili e date di soggiorno e torneo.
8. Una squadra può iscriversi una sola volta allo stesso torneo.
9. Un giocatore può giocare con una sola squadra nello stesso torneo.
10. Non tutte le squadre e non tutti i giocatori devono per forza pernottare.
11. Una squadra che pernotta va in un solo hotel e tutte le stanze riservate per lei devono essere di quell'hotel e disponibili per il torneo, salvo eccezioni gestite a mano.
12. Un giocatore che pernotta deve stare in una delle stanze riservate dalla sua squadra. 
13. In una stanza nello stesso periodo non possono esserci più giocatori + genitori dei posti letto che ha.
14. La stessa persona non può stare in più stanze nello stesso periodo.
15. La stessa stanza può essere riservata da iscrizioni diverse solo in periodi che non si sovrappongono.
16. La data di inizio soggiorno deve venire prima di quella di fine e tornare con le date del torneo, contando l'arrivo il giorno prima dell'inizio gare.
17. Quanto paga in totale una società per un torneo è la somma delle tariffe scelte da tutti i giocatori delle sue squadre iscritte a quel torneo.
18. La categoria della squadra deve tornare col torneo, e se c'è formula_roulette sulla tariffa va applicata la sua logica.


## Progettazione Logica


### Tavola dei volumi
| Concetto | Tipo | Volume | 
| :--- | :--- | :--- |


#### Motivazioni tavola dei volumi

---
### Tavola delle operazioni


#### Motivazioni tavola delle operazioni

## Back-end

## Front-end