import json
from pprint import pprint
import glob

with open('code-train-gt.json') as f:
    data = json.load(f)

folder = 'train-data-split\\'
languages = glob.glob(folder + '*')
nrLanguages = len(languages)
nrPicByLanguage = []
ind = 0
languagesSet = set()
code = {
    "JavaScript" : "",
    "Java" : "",
    "SQL" : "",
    "Python" : "",
    "c++" : "",
    "c#" : ""
}

for language in languages:
    ind = ind + 1
    try:
        print(data[language[language.find("\\")+1:]])
        languagesSet.add(data[language[language.find("\\")+1:]])

        with open(language, 'r+', encoding="utf8") as f:
            text = f.read()
            code[data[language[language.find("\\")+1:]]] += (text + '\n' + "+++___+++___+++___+++" + '\n')
    except KeyError:
        None
    print(ind)


# print(code)
print(languagesSet)

for language in languagesSet:
    with open('train-data\\' + language + ".txt", 'w+', encoding="utf8") as g:
        g.write(code[language] + '\n')