import sys
import requests


def download_links_from_file(file_path):
    try:
        with open(file_path, "r") as file:
            links = file.readlines()
            links = [link.strip() for link in links]

            for link in links:
                # Download each link
                response = requests.get(link)

                # Check if request was successful
                if response.status_code == 200:
                    # Extract filename from URL
                    file_name = link.split("/")[-1]
                    with open(file_name, "wb") as f:
                        f.write(response.content)
                    print(f"Downloaded {file_name}")
                else:
                    print(
                        f"Failed to download {link}. Status code: {response.status_code}"
                    )
    except FileNotFoundError:
        print("File not found. Please provide a valid file path.")


if __name__ == "__main__":
    file_path = input("Enter the file path: ")
    download_links_from_file(file_path)
