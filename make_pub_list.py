#!/usr/bin/env python3

# requires pip install requests

URL="&".join( [
  "https://api.archives-ouvertes.fr/search/?wt=json",
  "q=authId_i:(138649+OR+217193+OR+767210+OR+860806+OR+902463+OR+1023500)",
  "indent=true", 
  "fl=label_s,arxivId_s,files_s,title_s,author_s,authFullName_s,journal_s,label_bibtex,doiId_s,publicationDateY_i",
  "group=false",
  "start=0",
  "rows=10000",
  "fq=docType_s:(ART+OR+COMM+OR+OUV+OR+COUV+OR+DOUV+OR+OTHER+OR+UNDEFINED+OR+REPORT+OR+THESE+OR+HDR)",
  "sort=publicationDateY_i desc"
  ] )

import requests
import json


def arxiv(i):
  return "[<a href='https://arxiv.org/abs/%s'>ArXiv : %s</a>]"%(i,i)

def doi(i):
  return "[<a href='https://dx.doi.org/%s'>DOI : %s</a>]"%(i,i)

def pdf(i):
  return "[<a href='%s'>pdf</a>]"%(i)


def main():
    r = requests.get(URL)
    data = json.loads(r.content)["response"]
    with open('data.json','wb') as f:
       f.write(r.content)
    with open('data.json','rb') as f:
      data = json.load(f)["response"]["docs"]

    prev_year = 0
    for doc in data:
        year = doc["publicationDateY_i"]
        if year != prev_year:
            prev_year = year
            print("""<div class="header">%d</div>"""%(year))
        
        print("""<span class='title'>%s<br></span>"""%doc["title_s"][0])
        l = [ "<span class='author'>%s</span>"%auth for auth in doc["authFullName_s"] ]
        print(", ".join(l))
        print("<br>")
        print("""<br><table style="width:100%">""")
        print("""<col width="45%"><col width="45%"><col width="10%">""")
        print("""<tr>""")
        print("""<td>"""),
        if "arxivId_s" in doc:
            print( arxiv(doc["arxivId_s"])),
        print("""</td><td>"""),
        if "doiId_s" in doc:
            print( doi(doc["doiId_s"])) 
        print("""</td><td>"""),
        if "files_s" in doc:
            print( pdf(doc["files_s"][0])),
        print("""</td></tr></table>""")
        print("<br>")
        print("<br>")
    

if __name__ == "__main__":
   main()

