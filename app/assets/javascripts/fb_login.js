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
  $('#fb-register-button').click(function(e) {
    e.preventDefault();
    FB.login(function(response) {
      if (response.authResponse) {
        $.ajax({
          url: '/auth/facebook/callback',
          type: 'GET'
        }).done(function(json) { loadLoginForm(json); });
      }
    }, { scope: 'email,user_friends'});
  });
});

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
  $('#register').html(form_string);
  $('.phone').mask("(999) 999-9999",{placeholder:" "});
  handleRegistrationErrors();
}
