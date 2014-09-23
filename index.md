---
layout: page
title: Experimental stuff
description: Experiments in html and js_of_ocaml
---

# Experimental stuff

<script src="js/hello.min.js"></script>
<script src="js/oauth.js"></script>

<!--
<div>
<button onclick="hello( 'github' ).login()">Github</button>
</div>

<div id='profile_github'></div>

<script src="js/hello.min.js"></script>
<script src="js/oauth.js"></script>
<script>

hello.on('auth.login', function(auth){
	
	// call user information, for the given network
	hello( auth.network ).api( '/me' ).then( function(r){
		// Inject it into the container
		var label = document.getElementById( "profile_"+ auth.network );
		if(!label){
			label = document.createElement('div');
			label.id = "profile_"+auth.network;
			document.getElementById('profile').appendChild(label);
		}
		label.innerHTML = '<img src="'+ r.thumbnail +'" /> Hey '+r.name;
	});
});

hello.init({ 
	github: 'a37e79e29d16dbde630f',
},{
  redirect_uri : 'http://andrewray.github.io/devpages/redirect.html',
  oauth_proxy : 'https://auth-server.herokuapp.com/proxy'
});
</script>
-->

