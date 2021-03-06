Dit zijn een aantal scriptjes om het nakijken wat soepeler te laten verlopen.

Requirements:

* Je IDE moet zijn gelinked met je Dropbox waar je de submits in kan vinden. Volg hiervoor: Volg https://www.youtube.com/watch?v=YxokaFPOcOg met de volgende commands (met dank aan Kim de Bie):
  1. cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf –
  2. ~/.dropbox-dist/dropboxd
  3. ln -s /home/ubuntu/Dropbox/ ~/workspace/
  4. cd ~/ && wget https://linux.dropbox.com/packages/dropbox.py
  5. chmod +x dropbox.py
  6. cd /bin && sudo ln -s ~/dropbox.py
  7. dropbox start
  8. (Als regel 6/7 niet werken) ~/dropbox.py start
* Je hebt een 'students.csv' bestand nodig in de folder waar je scripts in zitten. In deze csv moet een lijst staan met studentnummers. Gewoon spaties ertussen is voldoende.
* Je moet de scripts chmodden. Voer "chmod u+x *.sh" in de folder met de scripts, dat moet voldoende zijn.
* Zet de scripts in een handige folder; "Grading" bijvoorbeeld. Dan blijft je workspace mooi schoon!
* Let erop dat dit een assistentie tool is. Je zal soms zelf moeten ingrijpen als een student iets raars heeft gedaan bij het inleveren.
* That's it!! :)

Recommended usage:

* Run 'dropbox.py status' om te kijken of je nog gelinked bent.
* Run eventueel ./dropboxer.sh tot er een nieuwe link.
* Run ./extractor.sh 'pset'
* Run ./checker.sh 'pset'
* Run ./grader.sh 'pset'
* En je kunt nakijken! Jeej..

Extractor.sh

* Usage: './extractor.sh "pset" "student_name"'
* Extractor haalt de files die je nodig hebt uit de dropbox en stopt ze in een map van de bijbehorende student.
* De mappen worden aangemaakt naar studentnummers.
* Het 'pset' argument is vereist en moet één van de problem sets zijn zoals genoemd op https://cs50x.mprog.nl onder het kopje "other".
* Het 'student_name' argument is optioneel. Als je die meegeeft worden de files van alleen die specifieke student opgehaald. Het dient een geldig studentnummer te zijn.
* Als je geen studentnummer meegeeft worden de files van alle studenten uit je 'student.csv' opgehaald.

Checker.sh

* Usage: './checker.sh "pset" "student_name"'
* Checker voert alle check50's uit voor de betreffende pset.
* Voert valgrinds uit voor de relevante opdrachten.
* Dit betekent dat je af en toe een submit error krijgt, of een verschil ziet tussen de more en less comfortable opgaven.
* Het is aan jou om uit te zoeken waar je wel en niet op moet letten.
* Het 'pset' argument is vereist en moet één van de problem sets zijn zoals genoemd op https://cs50x.mprog.nl onder het kopje "other".
* Het 'student_name' argument is optioneel. Als je die meegeeft worden de files van alleen die specifieke student gechecked. Het dient een geldig studentnummer te zijn.
* Als je geen studentnummer meegeeft worden alle studenten gechecked.
* Alle check50 & valgrind resultaten worden naar .txt bestanden geschreven.

Preppers.sh

* Wordt aangeroepen door checker. Hoef je in theorie niet zelf te runnen.
* Zorgt dat alle extra files worden aangemaakt en runt make.

Grader.sh

* Leest de resultaten van check50 en valgrind netjes naar je terminal.
* Je wordt per student geprompt of je die wil graden.
* Gebruik de -o flag voor de andere arguments om automatisch de files van studenten te openen.

Syncer.sh

* Voert een selective sync uit op alle studenten uit je students.csv
* Voorkomt het probleem dat je hele dropbox naar je ide wordt gekopieerd.
* Zorgt ervoor dat er sneller wordt gesynct met dropbox!
* Als je een directory meegeeft bv. "./syncer.sh folder_naam" dan wordt alleen die weggehaald.
* Wil je een folder terug hebben? "dropbox.py exclude remove folder_naam"
*
Check50py.sh

* Doet checks gelijk aan check50 voor de python scripts.

students.csv

* Zet hier de studenten die je bent toegewezen.
* Pas de placeholder values aan naar eigen inzicht. Spaties kunnen ook worden gebruikt in plaats van newlines.

Disclaimer:

* Geen garantie dat alles vlekkeloos werkt. Net als check50 zelf zijn de scripts een hulptool.

Special thanks:

* Bart v. Baal
