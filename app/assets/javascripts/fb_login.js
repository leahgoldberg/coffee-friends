console.log("URI", document.location.href);

window.fbAsyncInit = function() {
  FB.init({
    appId  : '123242711377342',
    status : true,
    cookie : true,
    xfbml  : true,
  });
};

(function(d) {
    var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
    js = d.createElement('script'); js.id = id; js.async = true;
    js.src = "//connect.facebook.net/en_US/all.js";
    d.getElementsByTagName('head')[0].appendChild(js);
  }(document));

$(function() {
  checkLoginStatus();
  $('#fb-register-button').click(function(e) {
    e.preventDefault();
    if (navigator.userAgent.match('CriOS')) {
      fbManualRedirect();
    } else {
      FB.login(function(response) { authenticateFB(response) }, { scope: 'email,user_friends'});
    }
  });
});

function fbManualRedirect() {
  var fbRedirectUrl = 'https://www.facebook.com/dialog/oauth?client_id=';
  var appID = '123242711377342';
  var scope = '&scope=email,user_friends';
  var url = fbRedirectUrl + appID + '&redirect_uri=' + document.location.href + scope;
  Cookies.set('fb-chrome-ios', true);
  window.open(url);
}

function checkLoginStatus() {
  FB.getLoginStatus(function(response) {
    if (response.status === 'connected' && Cookies.get('fb-chrome-ios') === 'true'){
      Cookies.remove('fb-chrome-ios');
      authenticateFB(response);
    }
  }, true);
}

function authenticateFB(response) {
  if (response.authResponse) {
    $.ajax({
      url: '/auth/facebook/callback',
      type: 'GET'
    }).done(function(json) { loadLoginForm(json); });
  }
}

function handleRegistrationErrors() {
  $('#fb-mid-login-form').submit(function(e) {
    e.preventDefault();
    $form = $(e.target);
    $.ajax({
      url: '/users',
      type: 'POST',
      data: $form.serialize()
    }).done(function(response) {
      if (response.includes('error')) { loadLoginForm(response);}
    }).fail(function() {
      console.log("Login was not successful")
    })
  })
}

function loadLoginForm(form_string) {
  $('#taglines').hide();
  $('#email-register').hide();
  $('#filler').remove();
  $("#small-logo-img").remove();
  $('#register').html(form_string);
  $('.phone').mask("(999) 999-9999",{placeholder:" "});
  handleRegistrationErrors();
}


function fbCompleteLogin(){
  
  FB.getLoginStatus(function(response) {
    // Calling this with the extra setting "true" forces
    // a non-cached request and updates the FB cache.
    // Since the auth login elsewhere validated the user
    // this update will now asyncronously mark the user as authed
  }, true);
  
}


function requireLogin(callback){

    FB.getLoginStatus(function(response) {
        if (response.status != "connected"){
            showLogin();
        }else{
            checkAuth(response.authResponse.accessToken, response.authResponse.userID, function(success){
              // Check FB tokens against your API to make sure user is valid
            });
        }
    });
}
