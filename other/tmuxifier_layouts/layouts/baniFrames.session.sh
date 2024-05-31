session_root "~/Desktop/dev/webdev/BaniFrames/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "BaniFrames"; then

  # Create a new window inline within session layout definition.
  new_window ""
  run_cmd "npm install"
  run_cmd "npm run dev"

  new_window ""
  run_cmd "nvim ."

  new_window ""
  run_cmd "cd /Users/gians/Desktop/dev/rand/sikhStuff/Gurbani/GetBanis"
  run_cmd "nvim ."

  select_window 2

  # Load a defined window layout.
  #load_window "example"

  # Select the default active window on session creation.
  #select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
