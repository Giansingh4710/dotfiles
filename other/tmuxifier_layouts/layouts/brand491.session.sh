# Set a custom session root path. Default is `$HOME`.
# Must be called before `initialize_session`.
session_root "~/Desktop/NJIT/njit_classes/CS491_Capstone/Brand_Run/"

# Create session with specified name if it does not already exist. If no
# argument is given, session name will be based on layout file name.
if initialize_session "Brand"; then

  # Create a new window inline within session layout definition.
  # new_window "server"
  new_window ""
  run_cmd "bun i"
  run_cmd "bun dev"
  run_cmd "echo 'http://127.0.0.1:5173' | pbcopy"

  new_window ""
  run_cmd "nvim ./src/App.jsx"
  # select_window "editor"

  # Load a defined window layout.
  #load_window "example"

  # Select the default active window on session creation.
  #select_window 1

fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
