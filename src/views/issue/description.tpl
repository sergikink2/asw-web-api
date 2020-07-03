<!DOCTYPE html>
<html>
<head>
	<title>Issue Description</title>
	<link rel="icon" type="image/png" href="bi-logo.png">
	<style>
		body{
			display: flex;
			flex-direction: row;
			margin: 0;
			font-size: 20px;
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
			padding-left: 20px;
		}
		#text{
			align-content: center;
		}
		#title{
			color: rgb(66, 82, 110);
			font-size: 25px;
			height: 32px;
			margin-left: 20px;
			margin-top: 25px;
		}
		#title2{
			color: rgb(66, 82, 110);
			font-size: 25px;
			height: 32px;
			margin-top: 25px;
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
			#container{
				position:absolute;
				right:20px;
				width:300px;
				top:170px;
				height:auto;
				margin-right: 20px;
			}
			.input-group{
				display: flex;
				justify-content:space-around;
				flex-direction: row;
			}
			select{
				width: 150px;
				font-size: 15px;
			}
			input,textarea{
				font-size:20px;
			}
			input{
				width: 50%;
			}
			.resolvebutton{
				padding: 10px;
				background-color: #0000ff;
				color:white;
				top:-50px;
				left:10px;
				width:75px;
			}
			.Workflowbutton{
				padding: 10px;
				top:-50px;
				left:87px;
				width:90px;
				color:#333333;
				background-color: #f2f2f2;
			}
			.Morebutton{
				padding: 10px;
				top:-50px;	
				color:#333333;
				right:50px;
				width:60px;
				background-color: #f2f2f2;
			}
			.Editbutton{
				padding: 10px;
				top:-50px;
				color:#333333;
				right:0px;
				width:40px;
				background-color: #f2f2f2;

			}
			.CreateIssuebutton{
				padding: 10px;
				color:#333333;
				background-color:#f2f2f2;
				top:-130px;
				right:0px;
			}
			.button{
				position:absolute;
				padding: 5px;
				font-size: 13px;
				border-radius: 2px;
				border:none;
				height:30px;
			}
			#containercancel{
				display: flex;
				justify-content: flex-end;
			}
			.input-group-addon{
				/*align-self: center;*/
				font-size:15px;
				text-align: right;
				margin-right: 10px;
			}
			#details{
				border: 2px solid lightgrey;
				padding: 20px;
				border-radius: 5px;
			}

			#issuename, #priority, #kind, #worker, #status, #votes, #watchers{
				color: blue;
				font-size:15px;
			}
			hr{
				margin-right:350px;
			}
			#title{
				font-size: 30px;
				font-weight: bold;
			}
			p{
				width: 50%;
				margin-top:5px;
				margin-bottom: 5px;
			}

	</style>
	<link rel="icon" type="image/png" href="static/img/bi-logo.png">
	<script src="../../static/js/jquery.min.js"></script>
	<script>
		var issueid = new Object();
		issueid.id = {{.IDissue}};
		$.ajax({
			type: "get",
			url: "/getcomments",
			data: JSON.stringify(issueid),
			contentType: "application/json; charset=utf-8",
			dataType: "json"
			})
			.done(function(data){
			})
			.fail(function() {
									
			});
	
	</script>
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
	function createcomment(){
		firebase.auth().onAuthStateChanged(function(user) {
		if (user) {
		if($("#contentcomment").val()!==""){
			var Comment = new Object();
			Comment.userid = user.uid // variable del user para POL
			Comment.username = user.displayName
			Comment.content = $("#contentcomment").val();
			Comment.issue = {{.IDissue}}
			console.log(Comment);
			$.ajax({
				type: "post",
				url: "/createcomment",
				data: JSON.stringify(Comment),
				contentType: "application/json; charset=utf-8",
				dataType: "json"
			})
			.done(function(data){
			
			})
			.fail(function() {
										
			});
			}
			
		else {
			$("#contentcomment").css({"border-color":"red"});
		}
		} else {
				// No user is signed in.
			}
		});
	}
	</script>
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
			<p id="title">Bitbucket</p>
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
		<h1 id="title2">{{.name}}</h1> 
		<h5 style="color:grey"> Issue # <span id="idissuetitle">{{.IDissue}}</span><h5>
		<h5><span style="color:blue">{{.creator}}</span> 	created an issue at {{.data}} </h5>
		<h6 >{{.description}}</h6>
		<hr>
		<div>
		<h4> Comments </h4>
		<div>
			{{range .comments}}
			<br>
			<br>
			<p id="commentowner">{{.FirebaseName}}<p>
			<p id="content">{{.Content}}<p>
			<td> <button onclick="deletecomment({{.ID}})"> Delete </button></td>
			<td> <button onclick="loadcomment({{.ID}})"> Edit </button></td>
			{{end}}
		</div>
		</div>
		<div>
			<form action="/createcomment" method="POST" id="createbutton" >
				<input id="contentcomment" type="text" name="contentcomment" placeholder="What do you want to say?" style="font-size:15px">
				<button onclick="createcomment({{ .IDissue}})"> ENVIAR</button>
			</form>
		</div>
			<div id="container">

				<div id="resolvebutton">
					<button class="button resolvebutton" type="submit" onclick="resolveIssue({{ .IDissue}})">Resolve</button>
				</div>
					<div id="details">

					<div class="input-group">
						<p class="input-group-addon" id="basic-addon1" > Assignee: </p>
						<p type="text" id="worker" name="worker"> {{.worker}}</p>
					</div>	

					<div class="input-group" >
						<p class="input-group-addon" id="basic-addon1"> Type:</p>
						<p type="text" id="kind" name="kind">{{.kind}}</p>
					</div>

					<div class="input-group" >
						<p class="input-group-addon" id="basic-addon1"> Priority: </p>						
						<p type="text" id="priority" name="priority"> {{.priority}}</p>
					</div>

					<div class="input-group" >
						<p class="input-group-addon" id="basic-addon1"> Status:</p>
						<p type="text" id="status" name="status"> {{ .status}}</p>
					</div>

					<div class="input-group">
						<p class="input-group-addon" id="basic-addon1" > Votes: </p>
						<button type="text" id="votes" name="votes" onclick="changevotes({{.IDissue}})"> {{.nbVotes}} Vote for this issue </button>
					</div>

					<div class="input-group">
						<p class="input-group-addon" id="basic-addon1" > Watchers: </p>
						<p type="text" id="watchers" name="watchers"> {{.nbVotes}} Watch this issue </p>
					</div>

					</div>
				<div id="Workflowbutton">
					<select style="width:900px" name="status" id="status">
						{{ range .statuslist }}
                			<option> {{ .}} </option>
              			{{end}}
					</select>
				</div>
				<div id="Morebutton">
					<button class="button Morebutton" type="submit" onclick="deleteIssue({{ .IDissue}})">Delete</button>
				</div>
				<div id="Editbutton ">
						<button class="button Editbutton" type="submit" onclick="loadIssue({{ .name}}, {{ .IDissue}})">Edit</button>
				</div>
				<form action="/newissue">
					<div id="CreateIssuebutton">
						<button class="button CreateIssuebutton" type="submit">Create issue</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>

<script>
	function loadIssue(namei, idi){
 		window.location.href = "/editissue?idi="+idi+"&name="+namei;
	}

	function resolveIssue(idi){
 		window.location.href = "/resolveissue?idi="+idi;
	}

	function deleteIssue(idi){
 		window.location.href = "/delete?idi="+idi;
	}

	function createcomment(idi) {
		window.location.href = "/createcomment?idi="+idi;
	}

	function deletecomment(idi) {
		window.location.href = "/deletecomment?idi="+idi;
	}

	function loadcomment(idi) {
		window.location.href = "/editcomment?idi="+idi;
	}

	function changevotes(idi) {
		window.location.href = "/changevotes?idi="+idi;
	}
</script>
