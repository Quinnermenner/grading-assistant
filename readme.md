Dit zijn twee scriptjes om het nakijken wat soepeler te laten verlopen.

Requirements:

* Je IDE moet zijn gelinked met je Dropbox waar je de submits in kan vinden. Volg hiervoor: https://c9.io/blog/dropbox-on-cloud9/. Let op dat je geen nieuwe workspace hoeft aan te maken als je niet wil.
** Het kan zijn dat de dropbox command niet kan worden gevonden. Gebruik dan dropbox.py
** Ik raad aan 'dropbox.py autostart' uit te voeren.
* Je hebt een 'students.csv' bestand nodig in de folder waar je scripts in zitten. In deze csv moet een lijst staan met studentnummers. Gewoon spaties ertussen is voldoende.
* Je moet de scripts chmodden. Voer "chmod u+x *.sh" in de folder met de scripts, dat moet voldoende zijn.
* Het is handig de scripts in een handige folder te zetten. Dan blijft je workspace mooi schoon!
* That's it!! :)

Extractor.sh

* Usage: './extractor.sh "pset" "student_name"'
* Extractor haalt de files die je nodig hebt uit de dropbox en stopt ze in een map van de bijbehorende student.
* De mappen worden aangemaakt naar studentnummers.
* Het 'pset' argument is vereist en moet één van de problem sets zijn zoals genoemd op https://cs50x.mprog.nl onder het kopje "other".
* Het 'student_name' argument is optioneel. Als je die meegeeft worden de files van alleen die specifieke student opgehaald. Het dient een geldig studentnummer te zijn.
* Als je geen studentnummer meegeeft worden de files van alle studenten uit je 'student.csv' opgehaald.

Checker.sh

* Usage: './checker50.sh "pset" "student_name"'
* Checker voert alle check50's uit voor de betreffende pset.
* Dit betekent dat je af en toe een submit error krijgt, of een verschil ziet tussen de more en less comfortable opgaven.
* Het is aan jou om uit te zoeken waar je wel en niet op moet letten.
* Het 'pset' argument is vereist en moet één van de problem sets zijn zoals genoemd op https://cs50x.mprog.nl onder het kopje "other".
* Het 'student_name' argument is optioneel. Als je die meegeeft worden de files van alleen die specifieke student gechecked. Het dient een geldig studentnummer te zijn.
* Als je geen studentnummer meegeeft worden alle studenten gechecked. Je krijgt dan aan het begin van iedere test een kleine prompt of je verder wil gaan. Type een "y" als je verder wil, andere knoppen slaan die student over.

students.csv

* Zet hier de studenten die je bent toegewezen.
* Pas de placeholder values aan naar eigen inzicht. Spaties kunnen ook worden gebruikt in plaats van newlines.