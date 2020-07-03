<!DOCTYPE html>
<html>
      <head> 
      <title>Authentication</title>
      <script src="https://www.gstatic.com/firebasejs/5.9.3/firebase.js"></script>
      <script src="https://www.gstatic.com/firebasejs/5.8.4/firebase-auth.js"></script>
      <script src="../../static/js/jquery.min.js"></script>
      <script src="../../static/js/md5.js"></script>
      <script>

        // Initialize Firebase
        var config = {
          apiKey: "AIzaSyAICbrmGUV1SjkM437siYZyXEY12CvOTWM",
          authDomain: "asw-13.firebaseapp.com",
          databaseURL: "https://asw-13.firebaseio.com",
          projectId: "asw-13",
          storageBucket: "asw-13.appspot.com",
          messagingSenderId: "768358226926"
        };

        firebase.initializeApp(config);
        function startfirebase(){
          var provider = new firebase.auth.GoogleAuthProvider();
          firebase.auth().signInWithPopup(provider).then(function(result) {
            //window.location.href ="/getlist";
            createUser();
            window.location.href ="/getkey";

            }).catch(function(error) {
            // Handle Errors here.
            var errorCode = error.code;
            var errorMessage = error.message;
            // The email of the user's account used.
            var email = error.email;
            // The firebase.auth.AuthCredential type that was used.
            var credential = error.credential;
            // ...
            });
            
        }

        function createUser(){
          firebase.auth().onAuthStateChanged(function(user) {
          if (user) {
            var User = new Object();	
						User.Name = user.displayName;
						User.FirebaseID = user.uid;
            $.ajax({
								type: "post",
								url: "/createuser",
								data: JSON.stringify(User),
								contentType: "application/json; charset=utf-8",
								dataType: "json"
            })
						.done(function(){
						})
						.fail(function() {
              

						});

          }else {
              // No user is signed in.
          }
          });
          var id = firebase.auth().currentUser.uid;
          console.log({{.key}})

        }
        
      </script>
      <style>
      body{
        display: flex;
        justify-content: center;
        align-items: center;
        align-content:center;
        flex-direction: column;
        height: 100vh;
        background-color: rgb(7, 71, 166);
      }
        button{
          font-size: 20px;
          padding: 10px;
          background-color: white;
          display: flex;
          align-items: center;
          border-radius:10px;
          font-weight: bold;
          color: rgb(66, 82, 110);
        }
        img{
          margin-right:10px;
        }
        h1{
          color: rgb(222, 235, 255);
          font-family: Arial;
          font-size: 40px;
        }
         label{
          color: rgb(222, 235, 255);
          font-family: Arial;
          font-size: 20px;
        }
      </style>
<link rel="icon" type="image/png" href="static/img/bi-logo.png">
      </head> 
      <body>
      <h1>BITBUCKET AUTHENTICATION</h1>
      <button onClick="startfirebase()"><img src="../../static/img/google-icon.png" width="20px" height="20px">GOOGLE REGISTER/LOGIN </button>
      <label id ="key" style = "margin-top:1%">API Key: {{.key}}</label>
      </body>
</html>
