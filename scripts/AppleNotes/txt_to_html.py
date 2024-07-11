import sys

def count_spaces_before_word(text):
    count = 0
    for char in text:
        if char == " ":
            count += 1
        else:
            break
    return count


def get_last_tag(html_lines):
    for i in range(len(html_lines) - 1, -1, -1):
        if html_lines[i] == "<br>":
            continue
        return html_lines[i]
    return "None"


def convert_to_html(text):
    lines = text.split("\n")
    html_lines = []
    indent_stack = [0]

    for i, line in enumerate(lines):
        if i == 0:
            html_lines.append(f"<h1>{line}</h1>")
            continue
        curr_indent_level = count_spaces_before_word(line)
        if "-" in line:
            # print(indent_stack, curr_indent_level, line)
            if "<li>" != get_last_tag(html_lines)[:4] or curr_indent_level > indent_stack[-1]:
                html_lines.append('<ul class="Apple-dash-list">')
            else:
                for i in range(len(indent_stack) - 1, -1, -1):
                    if curr_indent_level < indent_stack[i]:
                        html_lines.append("</ul>")
                        indent_stack.pop()

                if curr_indent_level < indent_stack[-1]:
                    html_lines.append("</ul>")
                    indent_stack.pop()
            html_lines.append(f"<li>{line.replace('-', '').strip()}</li>")
        else:
            if line.strip() == "":
                html_lines.append("<br>")
                continue  # dont wanna update prev_indent_level
            elif "<li>" == get_last_tag(html_lines)[:4]:
                html_lines.append("</ul>")
                indent_stack.pop()
            indent = "&nbsp;" * curr_indent_level
            html_lines.append(f"<p>{indent}{line}</p>")

        if len(indent_stack) == 0 or indent_stack[-1] != curr_indent_level:
            indent_stack.append(curr_indent_level)
    return html_lines

# py txt_to_html.py regular.txt > a.html
# file:///Users/gians/dotfiles/scripts/AppleNotes/a.html

filePath = sys.argv[1]
file = open(filePath, "r")
html_code = convert_to_html(file.read())
print("\n".join(html_code))
file.close()
