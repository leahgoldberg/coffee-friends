window.fbAsyncInit = function() {
  FB.init({
    appId  : "123242711377342",
    status : true,
    cookie : true,
    xfbml  : true,
    version : 'v2.5'
  });
  console.log("fb init")
};

(function(d) {
    var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
    js = d.createElement('script'); js.id = id; js.async = true;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    d.getElementsByTagName('head')[0].appendChild(js);
  }(document));

$(function() {
  $('a').click(function(e) {
    e.preventDefault();
    console.log("fb login")
    FB.login(function(response) {
      if (response.authResponse) {
        $('#fb-connect').html('Connected! Hitting OmniAuth callback (GET /auth/facebook/callback)...');
        $.getJSON('/auth/facebook/callback', function(json) {
          $('#fb-connect').html('Connected! Callback complete.');
          $('#results').html(JSON.stringify(json));
        });
      }
    }, { scope: 'email,read_stream', state: 'abc123' });
  });
});
