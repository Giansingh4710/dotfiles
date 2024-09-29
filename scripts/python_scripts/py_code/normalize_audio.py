from pydub import AudioSegment
import os
import sys

# pip3 install pydub


def loudness_normalize_audio(input_file, target_lufs=-40.0):
    audio = AudioSegment.from_file(input_file)
    loudness = audio.dBFS
    diff = abs(loudness - target_lufs)
    if diff < 2:
        print(f"{input_file} : {loudness} good enough")
        return
    print(f"{input_file}: Loudness {loudness}!={target_lufs}")

    # Calculate the adjustment factor to reach the target loudness
    adjustment_factor = target_lufs - loudness
    # Apply the gain to adjust the loudness
    normalized_audio = audio.apply_gain(adjustment_factor)
    normalized_audio.export(input_file, format="mp3")


def normalize_audio(input_file, target_dBFS=20.0):
    audio = AudioSegment.from_file(input_file)
    # the more negative the target_dBFS value the louder the audio will be
    if audio.dBFS <= target_dBFS:
        print(f"{input_file} is already normalized.")
        return
    print(f"Normalising: {input_file}")
    normalized_audio = audio.normalize(target_dBFS)
    normalized_audio.export(input_file, format="mp3")


def main(path):
    os.chdir(path)
    print(f"Current working directory: {os.getcwd()}")
    for filename in os.listdir():
        if filename.lower().endswith(".mp3"):
            try:
                # normalize_audio(filename)
                loudness_normalize_audio(filename)
            except Exception as e:
                print(f"Error: {e}")
        if os.path.isdir(filename):
            main(filename)
    os.chdir("..")


# inn="./yt_lalli/001) Bhai Mohinder Singh SDO Willams Lake 1980s.mp3"
# opt="bob.mp3"
# normalize_audio(inn,opt,20)


path = sys.argv[1]
main(path)
