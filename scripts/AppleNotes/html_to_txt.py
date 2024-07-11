import sys
import re

def remove_html_tags(text):
    clean = re.compile("<.*?>")
    return re.sub(clean, "", text)


def convert_to_txt(text):
    text_lines = []
    ul_count = 0

    lines = text.split("\n")
    for i, line in enumerate(lines):
        if i == 0:
            text_lines.append(remove_html_tags(line))
            continue
        if "br" in line:
            text_lines.append("")

        elif line.startswith("<ul"):
            ul_count += 1
        elif line.startswith("</ul>"):
            ul_count -= 1
        elif line.startswith("<li>"):
            indent_level = (ul_count - 1) * 4 * " "
            tag_text = remove_html_tags(line)
            if tag_text.strip() == "":
                continue
            text_lines.append(indent_level + "- " + tag_text)
        else: 
            tag_text = remove_html_tags(line)
            text_lines.append(tag_text)

    return "\n".join(text_lines)


# run 'file -I THE_NOTE.txt'
# file -I THE_NOTE.txt -> THE_NOTE.txt: text/plain; charset=iso-8859-1
# py html_to_txt.py THE_NOTE.txt

filePath = sys.argv[1]
content = open(filePath, "r", encoding="iso-8859-1").read()
plain_text = convert_to_txt(content)
"""
for some weird reason, the print prints out ^M as new line character
if you make a new file and put this code there, print will work fine,
but when this file is run from the apple script it make the print weird.
in my lua config. I just replace \r with \n. \r is ^M when it displays for me
"""
print(plain_text)
