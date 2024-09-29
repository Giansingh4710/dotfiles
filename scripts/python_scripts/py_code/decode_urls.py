from urllib.parse import unquote

file_name = input("Enter the file path: ")
# file_name = "a"
input_file = open(file_name, "r")
# links = input_file.readlines()
# for i in links:
#     print(f'"{unquote(i.strip())}",')


for line in input_file:
    if "http" in line:
        print(unquote(line),end="")
    else:
        print(line,end="")
