#import "preamble.typ": *
#import "@preview/meander:0.4.2"
#show: template.with(logo: "./RFS-two-no-wisps.png", title: [Labb 1 --- Grunder])
Välkomna till första labben! Dessa övningar är gjorda för att testa era kunskaper från föreläsningen och ger er en chans att pröva era kunskaper.

Det finns ett facit för alla frågor, men tyvärr har HAL krypterat allting! Ni måste lösa _facitfrågan_ i varje nivå för att hitta en krypteringsnyckeln som låser upp facit.

Handledarna har lyckats knäcka krypteringsalgoritmen, men inte nyckeln. Därför har vi levererat ett avkodningsskript med er labbspec. Den kör ni som nedan, i en terminal i den mapp där facit ligger.
```
> ./decrypt.py <namn-på-facit>
Ange krypteringsnyckeln: <er-kryptonyckel>
```

För att testa era kunskaper så har vi skickat med ett testfacit i filen `facit-test.enc`, med nyckeln "hej". Kör avkodaren på detta facit för att se att allt funkar:
```
> ./decrypt.py facit-test.enc
Ange krypteringsnyckeln: hej
```
Notera att ni inte ser bokstäverna ni skriver in som nyckel, men de lagras ändå.

För er som eventuellt använder Windows på egen dator, krävs att ni skriver följande i en terminal:
```
> pip install cryptography click
*vänta tills det är klart, sen*

> python decrypt.py facit-test.enc
Ange krypteringsnyckeln: hej
```

== Nivå 1

=== Miniräknaren
Skriv en enkel miniräknare. Den skall fråga användaren om två tal: `a` och `b`. Därefter skall den summera talen, och skriva ut resultatet.

=== Åldespådom
Du har vält att bli spåperson. Din tjänst går ut på att förutspå hur gammal någon kommer att vara om 10 år. Skriv ett program som frågar användaren om deras ålder och skriver ut hur gamla de är om 10 år.

=== Udda eller jämnt? <odd-even>
Fråga användaren om ett tal och avgöra om det är jämnt eller udda. Printa resultatet.

*Ledning:* Kom ihåg att modulooperatorn (`%`) ger resten vid division av dess vänstra operand med dess högra operand.

=== Amerikansk termometer
Som alla vet, så är amerikanerna envisa med att ha sina egna enheter. Temperatur är en av de jobbigaste. Skriv ett program som konverterar en temperature given av användare från Celcius till Farenheit enligt formeln
$
  t_(degree"F") = (t_(degree"C") dot 9 / 5) + 32.
$

=== Bromssträcka --- Facitfråga
Bromsträckan för en bil beräknas
$
  s_b = v_0^2 / (2 a_b)
$
där $s_b$ är bromssträckan i meter, $a_b$ är _beloppet_ av bromsaccelerationen i $"m"slash "s"^2$ och $v_0$ är utgångshastigheten i $"m"slash"s"$. Du behöver skriva en kod som konverterar en hastighet, angiven i $"km"slash"tim"$, till en bromssträcka för en bil.

Ditt program skall fråga efter både utgångshastighet och bromssaceleration separat.

Beräkna bromssträckan med programmet för specifikt en bil med $v_0 = 100 "km"slash"tim"$ och $a_b = 3.2 "m"slash"s"^2$. Avrunda svaret till tre decimaler, det är nyckeln för att låsa upp facit.
// Svaret är : 120.563

*Bonus:* Ändra i koden så att du kan ange bromssacceleration i enheten [g], dvs. multipel av tyngdaccelerationen $g approx 9.81 "m"slash"s"^2$.

== Nivå 2

=== Betygssystemet
#meander.reflow({
  import meander: *
  placed(top + right, table(
    columns: (auto, auto),
    [*F*], [0],
    [*E*], [10],
    [*D*], [12.5],
    [*C*], [15],
    [*B*], [17.5],
    [*A*], [20],
  ))
  container()
  content[
    Som känt är skalan för betyg i det svenska gymnasiet egentligen numeriskt. Lärare brukar dock sätta betyg som bokstäver. Visst är det jobbigt att försöka komma ihåg siffrorna? Skriv en kod som tar in ett betyg från användaren och gör om det till dess motsvarande siffra. Programmet skriver ut siffran efter betyget.
  ]
})


=== Lösenordscheck
En vanlig grej man måste göra är att kolla lösenord. Ta in ett lösenord från användaren och jämför det med ett förinställt lösenord i koden. Det förinställd lösenordet _måste_ vara lagrat i en konstant variabel. Skriv ut om lösenordet är rätt eller fel.

=== Betygsättning
#meander.reflow({
  import meander: *
  placed(top + right, table(
    columns: (auto, auto),
    [*F*], [\<50],
    [*E*], [50-60],
    [*D*], [60-70],
    [*C*], [70-80],
    [*B*], [80-90],
    [*A*], [90-100],
  ))
  container()
  content[
    Nu är det dags för en tvist på första fråga i detta kapitel! Denna gång skall ni sätta ett betyg baserat på provresultat. Det finns som mest 100 poäng att få, och betygen är fördelade som i tabellen. För varje betyg är undre gränsken _inklusiv_ medan övre gränsen är _exklusiv_. Dvs. att $50 <= x < 60$ för E t.ex. Låt användaren skriva in en poäng mellan 0-100 och skriv ut betyget. Det ska vara åket att ha ej hela poäng och programmet skall klaga om en omöjlig poängsumma har givits.
  ]
})

=== Skottåret - Facitfråga
Som bekant går \~365.25 dagar på ett år. Den ursprungliga Julianska algoritmen lade till en skottdag vart 4:e år. Detta är dock inte helt exakt, vilket ledde till den Gregorianska kalendern som lägger till en dag på alla år som är delbara med 4, förutom de år som är _delbara_ med 100 men _inte delbara_ med 400. Skriv ett program som tar in ett år från användaren och skriver ut ifall det är ett skottår eller inte. Programmet måste klaga till användaren om ett negativt årtal har angivits.

*Ledning:* Kom ihåg vår kära vän modulus (`%`) från #ref(<odd-even>, supplement: "uppg.").

För att låsa upp facit: beräkna ifall år 13874844 är ett skottår. Nyckeln är "ja" om det är ett skottår, och "nej" annars.
// Svaret: ja
