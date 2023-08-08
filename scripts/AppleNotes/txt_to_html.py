import sys

def count_spaces_before_word(text):
    count = 0
    for char in text:
        if char == " ":
            count += 1
        else:
            break
    return count


def convert_to_html(text):
    lines = text.split("\n")
    html = ""

    for i,line in enumerate(lines):
        indent_level = count_spaces_before_word(line)
        indent = "&nbsp;" * indent_level
        if i == 0:
            html += f'<h1>{line}</h1>'
            continue

        html += f'<p>{indent}{line}</p>'
    return html


filePath = sys.argv[1]
file = open(filePath, "r")
html_code = convert_to_html(file.read())
print(html_code)
file.close()
