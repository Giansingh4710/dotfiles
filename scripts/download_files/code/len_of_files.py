import os, sys
import mutagen

len_of_files_in_seconds = 0
total_files = 0
failed_files = 0
def goThroughFiles(dir):
    global len_of_files_in_seconds
    global total_files
    global failed_files
    for thing in os.listdir(dir):
        path=dir+"/"+thing
        if os.path.isdir(path):
            try:
                goThroughFiles(path)
                # print(f"Parsed Dir: {path}")
            except Exception as e:
                print(f"Couldn't Parse Dir: {path}")
        elif os.path.isfile(path):
            total_files+=1
            try:
                audio=mutagen.File(path)
                len_of_files_in_seconds+=audio.info.length
            except Exception as e:
                print(f'{thing} failed : {e}')
                failed_files+=1

def nicePrintTime(seconds):
    minutes=seconds/60
    print(f"\nMinutes: {minutes}")
    hours=minutes/60
    print(f"Hours: {hours}")
    days=hours/24
    print(f"Days: {days}")

    fullDays=seconds//(60*60*24)
    timeleft=seconds-fullDays*(60*60*24)
    fullHour=timeleft//(60*60)
    timeleft=timeleft-fullHour*(60*60)
    fullminutes=timeleft//60
    timeleft=timeleft-fullminutes*60
    print("So in total:", end=" ")
    print(f"{int(fullDays)} days, {int(fullHour)} hours, {int(fullminutes)} minutes, {int(timeleft)} seconds")

directory = sys.argv[1]
goThroughFiles(directory)
nicePrintTime(len_of_files_in_seconds)
print(f"\nSuccessful Files: {total_files-failed_files}")
print(f"Failed Files: {failed_files}")
print(f"Total Files: {total_files}")
