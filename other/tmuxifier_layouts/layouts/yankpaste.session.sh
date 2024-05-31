session_root "~/Desktop/dev/webdev/yankPaste/"
if initialize_session "yankpaste"; then
  new_window ""
  run_cmd "npm install"
  run_cmd "npm run dev"

  new_window ""
  run_cmd "nvim -p src/client/App.jsx src/server/main.js"

  select_window 2
fi

finalize_and_go_to_session
