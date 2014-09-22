(* perform oauth, and do something with the token *)

let log s = Firebug.console##log(Js.string s)

let main _ = 
  log "loading";
  Js._false

let _ = Dom_html.window##onload <- Dom_html.handler main


