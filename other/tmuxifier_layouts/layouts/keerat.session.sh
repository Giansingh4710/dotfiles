# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Desktop/dev/webdev/keerat/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "keerat"; then

  # Create a new window inline within session layout definition.
  new_window ""
  run_cmd "nvm use '18.17.0'"
  run_cmd "sleep 2" # so getshabads can take port 3000
  run_cmd "npm run dev"

  new_window ""
  run_cmd "nvim ."

  new_window ""
  run_cmd "cd ~/Desktop/dev/webdev/keerat/app/Keertan/AkhandKeertan/scraping/dl_all_links_from_yt_link/"

  new_window ""
  run_cmd "cd ~/Desktop/dev/webdev/getshabads/"
  run_cmd "npm run dev"

  select_window 2


  # run_cmd "tmux swap-window -s :1 -t :4" # getshabads npm needs to run first so it can take port 3000
  # run_cmd "tmux split-window -h -t :3" # tmux split-window -h -t <session-name>:<window-index>

  # Load a defined window layout.
  #load_window "example"

  # Select the default active window on session creation.
  #select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
