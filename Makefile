TITLE="Anthony Scemama's Web Page"
RST2HTML=rst2html --link-stylesheet --stylesheet-path="./css/" --stylesheet="css/templatemo_style.css" --template="template.txt" --date --strip-comments --time --generator --title=$(TITLE) --cloak-email-addresses

.PHONY: default 

default: index.html pub_list.html

pub_list.html: 
	- mv pub_list.html pub_list.html.old
	wget "http://irssv2.ups-tlse.fr/publications/embed3.php?do=author&authorid=170" -O - | tail -n +33 | head -n -1 | ./remove_links.py > pub_list.html

%.html: %.rst template.txt pub_list.html
	$(MAKE) -B pub_list.html
	$(RST2HTML) $< > $@

sync:
	git commit -a && git push
