window.fbAsyncInit = function() {
  FB.init({
    appId  : "123242711377342",
    status : true,
    cookie : true,
    xfbml  : true,
    // version : 'v2.5'
  });
  console.log("fb init")
};

(function(d) {
    var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
    js = d.createElement('script'); js.id = id; js.async = true;
    js.src = "//connect.facebook.net/en_US/all.js";
    d.getElementsByTagName('head')[0].appendChild(js);
  }(document));

// function fbLogin() {
$(function() {
  $('#login-button').click(function(e) {
    e.preventDefault();
    console.log("fb login")
    FB.login(function(response) {
      if (response.authResponse) {
        $.ajax({
          url: '/auth/facebook/callback',
          type: 'GET'
        }).done(function(json) {
          $('#results').html(json);
        });
      }
    }, { scope: 'email,user_friends'});
  });
});
