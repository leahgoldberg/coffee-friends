window.fbAsyncInit = function() {
  FB.init({
    appId  : gon.fb_app_id,
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
        }).done(function(json) {
          $('#register').html(json);
          $('.phone').mask("(999) 999-9999",{placeholder:" "});
        });
      }
    }, { scope: 'email,user_friends'});
  });

  // $('#fb-mid-login-form').submit(function(e) {
  //   e.preventDefault();
  //   $.ajax({
  //     url: '/users',
  //     type: 'POST',
  //     data: $(this).serialize()
  //   }).done(function(response) {
  //     debugger
  //     console.log('cool');
  //   }).fail(function(response) {
  //     debugger
  //     console.log('wut');
  //   })
  // })

});
