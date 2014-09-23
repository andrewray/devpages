(* perform oauth, and do something with the token *)

let log s = Firebug.console##log(Js.string s)

(* set the client_id for the required service(s) *)
class type network = object
	method windows : Js.js_string Js.t Js.prop
	method google : Js.js_string Js.t Js.prop
	method facebook : Js.js_string Js.t Js.prop 
	method dropbox : Js.js_string Js.t Js.prop
	method twitter : Js.js_string Js.t Js.prop
	method yahoo : Js.js_string Js.t Js.prop
	method instagram : Js.js_string Js.t Js.prop
  method linkedin : Js.js_string Js.t Js.prop
  method soundcloud : Js.js_string Js.t Js.prop
  method foursquare : Js.js_string Js.t Js.prop
  method github : Js.js_string Js.t Js.prop
  method flickr :Js.js_string Js.t Js.prop
end

class type init_options = object
  (* popup, page or none *)
  method display : Js.js_string Js.t Js.prop
  method scope : Js.js_string Js.t Js.prop
  method redirect_uri : Js.js_string Js.t Js.prop
  (* token or code *)
  method response_type : Js.js_string Js.t Js.prop
  method force : bool Js.t Js.prop
  method oauth_proxy : Js.js_string Js.t Js.prop
end

class type logout_options = object
  method force : bool Js.t Js.prop
end

class type oauth = object
  method auth : Js.js_string Js.t Js.prop
  method grant : Js.js_string Js.t Js.prop
  method reposonse_type : Js.js_string Js.t Js.prop
  method version : int Js.t Js.prop
end

class type auth_status = object
  method access_token : Js.js_string Js.t Js.prop
  method client_id : Js.js_string Js.t Js.prop
  method display : Js.js_string Js.t Js.prop
  method expires : float Js.t Js.prop
  method expires_in : float Js.t Js.prop
  method network : Js.js_string Js.t Js.prop
  method oauth : oauth Js.t Js.prop
  method oauth_proxy : Js.js_string Js.t Js.prop
  method redirect_uri : Js.js_string Js.t Js.prop
  method scope : Js.js_string Js.t Js.prop
  method state : Js.js_string Js.t Js.prop
  method token_type : Js.js_string Js.t Js.prop
end

class type auth_event = object
  method network : Js.js_string Js.t Js.readonly_prop
  method authResponse : 'a Js.readonly_prop
end

let network () : network Js.t = Js.Unsafe.obj [||]
let init_options () : init_options Js.t = Js.Unsafe.obj [||]

class type hello = object
  method init : 
    network Js.t -> 
    init_options Js.t Js.opt -> 
    unit Js.meth
  method login : 
    Js.js_string Js.t -> 
    init_options Js.t Js.opt -> 
    (unit -> unit) Js.callback Js.opt -> 
    unit Js.meth
  method logout : 
    Js.js_string Js.t -> 
    logout_options Js.t Js.opt -> 
    (unit -> unit) Js.callback Js.opt -> 
    unit Js.meth
  method getAuthResponse :
    Js.js_string Js.t -> 
    auth_status Js.t Js.meth
  (* get method callback can have an extra 'next' argument *)
  method api :
    Js.js_string Js.t -> 
    Js.js_string Js.t -> 
    'a Js.t Js.opt -> 
    (Js.js_string -> unit) Js.callback -> 
    unit Js.meth
  method on : 
    Js.js_string Js.t -> (auth_event Js.t -> unit) Js.callback -> unit Js.meth
  method off : 
    Js.js_string Js.t -> (unit -> unit) Js.callback -> unit Js.meth
end

let hello : hello Js.t = Js.Unsafe.variable "hello"

let main _ = 
  let () = log "logging in" in
  let network = 
    let network = network() in
    network##github <- Js.string "a37e79e29d16dbde630f";
    network
  in
  let init_opts = 
    let init_opts = init_options () in
    init_opts##redirect_uri <- Js.string "http://andrewray.github.io/devpages/redirect.html'";
    init_opts##oauth_proxy <- Js.string "https://auth-server.herokuapp.com/proxy";
    Js.Opt.return init_opts
  in
  let () = hello##init(network, Js.Opt.empty) in
  let () = hello##login(Js.string "github", init_opts, Js.Opt.empty) in
  let () = log "awaiting for callback" in
  let () = hello##on(Js.string "auth.login", Js.wrap_callback (fun e ->
    let network = Js.to_string e##network in
    log ("logged in to " ^ network))) in
  Js._false

let _ = Dom_html.window##onload <- Dom_html.handler main


