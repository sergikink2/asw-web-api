<!DOCTYPE html>
<html>
    <head>
		<script src="../../static/js/jquery.min.js"></script>
		<style>
			#container{
				display: flex;
				justify-content: center;
			}
			#name,#description{
				display:flex;
				flex-direction: row;
			}
			.input-group{
				margin-bottom: 30px;
				display: flex;
				justify-content: space-around;
				flex-direction: row;
				color-text: grey;
			}
			select{
				width: 150px;
				font-size: 20px;
			}
			span{
				margin-right: 20px;
			}
			input{
				font-family:Arial;
				font-size:20px;
				width: 900px;
			}
			textarea{
				font-family:Arial;
				font-size:20px;
				width: 900px;
				height:150px;
			}
			#savebutton{
				display:flex;
				justify-content:center;
				padding: 10px;
			}
			#cancelbutton{
				padding: 10px;
			}
			.buttonSave{
				position:absolute;
				bottom:25px;
				right:100px;
				cursor:pointer;
				padding: 5px;
				font-size: 12px;
				border-radius: 5px;
				padding-right: 20px;
				padding-left: 20px;
				background-color: #0033cc;
				color:white;
				height:35px;
			}
			.buttonAtt {
				border:none;
			}
			.buttonCancel {
				position:fixed;
				bottom:25px;
				right:25px;
				cursor:pointer;
				padding: 5px;
				font-size: 12px;
				border-radius: 5px;
				padding-right: 20px;
				padding-left: 20px;
				color:blue;
				background:none;
				border:none;
				height:35px;
			}
			
			#containercancel{
				display: flex;
				justify-content: flex-end;
			}
			body{
			display: flex;
			flex-direction: row;
			margin: 0;
		}
		.uno{
			background-color: rgb(7, 71, 166);
			width: 6vw;
			height: 100vh;
			display: flex;
			flex-direction: column;
			justify-content: space-between;
			
		}
		#content2{
			margin-bottom: 30px;
		}
		.dos{
			background-color: #f5f5f5;
			width: 24vw;
			height: 100vh;
			color: rgb(66, 82, 110);
			font-size: 17px;
		}
		.tres{
			height: 100vh;
			width: 70vw;
			margin: 20px;
		}
		#text{
			align-content: center;
		}
		p{
			color: rgb(66, 82, 110);
			font-size: 25px;
			height: 32px;
			margin-left: 20px;
		}
		#image{
			display: flex;
			justify-content: center;
			margin-top: 25px;
		}
		#image3, #image4, #image5{
			display: flex;
			justify-content: center;
			margin-top: 30px;
		}
		#image1,#image2{
			display: flex;
			justify-content: center;
			padding-top: 10px;
			padding-bottom: 10px;
		}
		#contenedorimage,#contenedorimage1{
			margin-top: 30px;
		}
		#source, #commit, #branches, #pipelines, #downloads, #boards, #settings, #pull, #issue, #snippets{
			display: flex;
			padding-top: 10px;
			padding-bottom: 10px;
			padding-left: 10px;
			margin-left: 20px;
			margin-right: 20px;
			border-radius: 5px;

		}
		.text{
			display: flex;
			align-items: center;
		}
		.img{
			margin-right: 15px;
		}
		#issue{
			background-color: rgb(66, 82, 110, 0.1);
			color: #0052CC;
		}
		</style>
		<script src="https://www.gstatic.com/firebasejs/5.9.3/firebase.js"></script>
      <script src="https://www.gstatic.com/firebasejs/5.8.4/firebase-auth.js"></script>
		<script>
			var config = {
          apiKey: "AIzaSyAICbrmGUV1SjkM437siYZyXEY12CvOTWM",
          authDomain: "asw-13.firebaseapp.com",
          databaseURL: "https://asw-13.firebaseio.com",
          projectId: "asw-13",
          storageBucket: "asw-13.appspot.com",
          messagingSenderId: "768358226926"
        };

        firebase.initializeApp(config);
				
			</script>
			<script>
				function createissue(){
					firebase.auth().onAuthStateChanged(function(user) {
					if (user) {
						var Issue = new Object();
						
						
						if($("#issuename").val()!==""){
							Issue.Name = $("#issuename").val();
							Issue.Priority = $("#priority").val();
							Issue.Kind = $("#kind").val();
							Issue.Worker = document.getElementById("assignee").value;
							if($("#issuedescription").val()===""){
								Issue.Description = "No description provided"
							}
							else Issue.Description = $("#issuedescription").val();
							Issue.CreatoriD = user.uid;
							Issue.Creator = user.displayName;
							console.log(user.displayName + ' '+ Issue.Creator)
							$.ajax({
									type: "post",
									url: "/createissue",
									data: JSON.stringify(Issue),
									contentType: "application/json; charset=utf-8",
									dataType: "json"
									})
							.done(function(data){
								console.log("i'im in")
									window.location("/issuedescription")
							})
							.fail(function() {
									
							});
						}
						} else {
							// No user is signed in.
						}
					
				});
				}
			</script>

        <title>Issue Creation</title>
        <meta charset="utf-8">
		<link rel="icon" type="image/png" href="static/img/bi-logo.png">
    </head>
<body>
	<div class="uno">
		<div>
			<div id="image">
				<img src="static/img/bi-logo.png" width="32px" height="32px;">
			</div>
			<div id="contenedorimage">
				<div id="image1">
					<img src="static/img/search.png" width="24px" height="24px">
				</div>
				<div id = "image2">
					<img src="static/img/mas3.png" width="24px" height="24px">
				</div>
			</div>
		</div>
		<div id="content2">
			<div id="image3">
				<img src="static/img/icons.png" width="24px" height="24px;">
			</div>
			<div id="image4">
				<img src="static/img/help.png" width="24px" height="24px">
			</div>
			<div id = "image5">
				<img src="static/img/profile.png" width="24px" height="24px">
			</div>
		</div>
	</div>
	<div class="dos">
		<div id="text">
			<p>Bitbucket</p>
		</div>
		<div id="contenedorimage1">
			<div id="source">
				<img class="img" src="static/img/source.png" width="24px" height="24px"> <div class="text">Source</div>
			</div>
			<div id = "commit">
				<img class="img" src="static/img/commit.png" width="24px" height="24px"> <div class="text">Commits</div>
			</div>
			<div id = "branches">
				<img class="img" src="static/img/branch.png" width="24px" height="24px"> <div class="text">Branches</div>
			</div>
			<div id = "pull">
				<img class="img" src="static/img/git-pull2.png" width="24px" height="24px"> <div class="text">Pull requests</div>
			</div>
			<div id = "pipelines">
				<img class="img" src="static/img/pipeline.png" width="24px" height="24px"> <div class="text">Pipelines</div>
			</div>
			<a href="/getlist" style="text-decoration: none" id = "issue">
				<img class="img" src="static/img/issues.png" width="24px" height="24px"> <div style="color:rgb(66, 82, 110)"class="text">Issues</div>
			</a>
			<div id = "downloads">
				<img class="img" src="static/img/download.png" width="24px" height="24px"> <div class="text">Downloads</div>
			</div>
			<div id = "boards">
				<img class="img" src="static/img/board.png" width="24px" height="24px"> <div class="text">Boards</div>
			</div>
			<div id = "settings">
				<img class="img" src="static/img/setting.png" width="24px" height="24px"> <div class="text">Settings</div>
			</div>
		</div>
	</div>
	<div class="tres">
		<h2>Issues</h2>
		<h3>Create issue</h3>
			<div id="container">
				<form  class="form-register"  id="form" action="/issuedescription">

					<div class="input-group" id="name">
						<td>Title<span style="color:red">*</span>
						<td><input type="text" id="issuename" name="issuename" required></td>
					</div>

					<div class="input-group" id="description">
						<td><span class="input-group-addon" id="basic-addon1"> Description </span></td>
						<td><textarea type="text" id="issuedescription" name="issuedescription"></textarea></td>
					</div>
					
					<div class="input-group">
						<td><span class="input-group-addon" id="basic-addon1"> Assignee </span></td>
						<td><select style="width:900px" name="worker" id="assignee">
              {{ range .worker }}
                <option> {{ .}} </option>
              {{end}}
						</select></td>
					</div>

					<div class="input-group" >
						<td><span class="input-group-addon" id="basic-addon1"> Kind
						<span style="color:red">*</span></span></td>
						<td><select style="width:900px" name="kind" id="kind">
							{{ range .kind }}
                <option> {{ .}} </option>
              {{end}}
						</select></td>
					</div>

					<div class="input-group" >
						<td><span class="input-group-addon" id="basic-addon1"> Priority
						<span style="color:red">*</span></span></td>
						<td><select style="width:900px" name="priority" id="priority">
							{{ range .priority }}
                <option> {{ .}} </option>
              {{end}}
						</select></td>
					</div>

					<div>
						Attachments
						<input type="file">
					</div>

					<div id="savebutton" style="float:right">
						<td><button onClick="createissue()" class="buttonSave" type="submit" value="SAVE">Create issue</button></td>
					</div>
				</form>
					<form action="/getlist">
						<td><button class="buttonCancel" type="submit" value="CANCEL" >Cancel</button></td>
					</form>	
			</div>
	</div>
</body>
</html>