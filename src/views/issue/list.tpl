<!DOCTYPE html>
<html>
      <head>
			<script src="https://www.gstatic.com/firebasejs/5.9.3/firebase.js"></script>
      <script src="https://www.gstatic.com/firebasejs/5.8.4/firebase-auth.js"></script>
			<script src="../../static/js/jquery.min.js"></script>
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
				firebase.auth().onAuthStateChanged(function(user) {
					if (user) {
						document.getElementById("userid").innerHTML = user.displayName + " / ASW"
					} else {
						// No user is signed in.
					}
				});
			</script>
			<script>
				function createwatcher(id){
					var idN = parseInt(id);
					//console.log(idN);
					firebase.auth().onAuthStateChanged(function(user) {
					if (user) {
						var Watcher = new Object();	
						Watcher.WatcheriD = user.uid;
						Watcher.IssueiD = idN
						console.log(Watcher)
						$.ajax({
								type: "post",
								url: "/createwatcher",
								data: JSON.stringify(Watcher),
								contentType: "application/json; charset=utf-8",
								dataType: "json"
								})
						.done(function(data){
							console.log("i'im in")
						})
						.fail(function() {
								
						});
						} else {
							// No user is signed in.
						}
				});
				}
			
			
			</script>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
        <script src="https://code.jquery.com/jquery-3.3.1.js"></script>
        <script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap4.min.js"></script>
        <script>
            $(document).ready(function(){
            $('#tabla-issues').DataTable({"bLengthChange": false,"columnDefs": [ {
            "targets": 'no-sort',
            "orderable": false,
            } ]});
            });
        </script>
        <link href="/open-iconic/font/css/open-iconic-bootstrap.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
        <link rel="icon" type="image/png" href="static/img/bi-logo.png">
        <style>
            .table{margin-left:30px;padding:2px;}
            .th,.td{background-color:white}
            .inp1{border-width:0px; margin-left:90%;height:30px; color:#879091; font:Arial; font-size:14px ;border-radius:3px; 
            background-color:#F2F2F2;}
             .inpFilter{font:Arial; font-size:14px;border-width:0px; background-color:#fff;}
            .new{border-style:solid; border-width:1px; border-radius:3px;font-size:11px; border-color:#879091;}
            .label1{margin-top:2%; font-size:22px }
            .labelFilter{margin-top:1%; font-size:14px;font-weight: normal;}
            .formCreate{margin-bottom:1%; margin-top:2%;}
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
		}
		#issuename:hover{
					text-decoration:underline;
					color: blue;
			}
		.btn-custom1:focus{
			background: #5A6485;
			outline: none!important;
			box-shadow:none;
			border: none;
			color: white;
			margin-left: 1%

		}
		.btn-custom1{
			background: transparent;
			box-shadow:none;
			border: none;
			margin-left: 1%

		}
		.btn:hover{
			background: #EAEAEE;
			margin-left: 1%
		}
		.btn-custom2{
			background: transparent;
			box-shadow:none;
			border: none;
			color: #747476;
			font-size:12px;
			margin-left: 1%

		}
				</style>
				<title id="test"> 
						List of Issues 
				</title>
				<link rel="stylesheet" type="text/css" href="test.css">
				<meta charset="utf-8">
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
	<div  class="dos">
		<div style="margin-top:25px" id="text">
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
		<div id = "header" style="margin-left:2%;margin-right:2%;" class="row container-fluid">
									<label id="userid" class = "col-xs-10 label1"></label>
									<label id = "titulo" class = "col-xs-10 label1">Issues</label>
									<form  id = "form-create-issue" class = "col-xs-1 formCreate" action="/newissue">
									<input id = "create-issue-inp" class = "inp1" type="submit" value="Create issue" />
									</form>

						</div>
						<div id = "filter" style="margin-left:3.8%;" class="row container-fluid">
									
								<label id = "filter-label" style="width:65px; padding:0.0%" class = "col-xs-1 labelFilter">Filter by: </label>
								<div style="margin-top:0.5%;">
									<button class="btn btn-custom1" id="all">All</button>
									<button class="btn btn-custom1" id="open">Open</button>
									<button class="btn btn-custom1" id="myissue">My issues</button>
									<button class="btn btn-custom1" id="watching">Watching</button>
								</div>

						</div>
						<div id = "issues" style="margin-right:2%; margin-left:2%" class="container-fluid">
									<table role="grid" id = "tabla-issues" class="display dataTable" aria-describedby="tabla-issues_info" >
												<thead id = "header-tabla-issues">
															<tr role = "row" id = "tr-header-tabla-issues">
																		<th>Title</th>
																		<th>T</th>
																		<th>P</th>
																		<th >Status</th>
																		<th class="no-sort">Votes</th>
																		<th>Asignee</th>
																		<th>CreatedAt</th>
																		<th >UpdatedAt</th>
						<th width="10px"class="no-sort"></th>												
															</tr>
												</thead>
												<tbody class = "searchable">
															{{ range .issues }}
																		<tr role="row">
							<td id="issuename" class="sorting_1" onclick="watchIssue({{.Name}})" >#<span id ="issueid">{{.ID}}</span>: {{ .Name }}</td>
							<td class="col-xs-1">{{ .Kind }}</td>
							<td class="col-xs-1">{{ .Priority }}</td>
							<td class="col-xs-1"> <label class="new">{{ .Status }}</label></td>
							<td class="col-xs-1">
								<button type="button" title="Vote" id="VoteButton" class="btn btn-default btn-sm updatebtn" onclick="voteIssue({{ .ID}})">
									<span class="glyphicon glyphicon-thumbs-up" aria-hidden="true" ></span>
								</button>
							</td>
							<td class="col-xs-1">{{ .Worker }}</td>
							<td class="col-xs-2">{{.CreatedAt}}</td>
							<td class="col-xs-2">{{.UpdatedAt}}</td>

							<td id = "buttons" class="td_buttons_actions">

								<!--<button type="button" title="Update" id="UpdateButton" class="btn btn-default btn-sm updatebtn" onclick="loadIssue({{ .Name}}, {{ .ID}})">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true" ></span>
								</button>-->

								<button type="button" title="Watch" id="WatchButton" class="btn btn-custom2 btn-sm updatebtn">
											<span style = "background-color:transparent"class="glyphicon glyphicon-eye-open" aria-hidden="true" ></span>
								</button>			
								
							</td>
							
								<!--<button type="button" title="Delete" id="DeleteButton" class="btn btn-default btn-sm deletebtn" data-toggle="modal" data-target=".bs-example-modal-sm" onclick="deleteCluster({{ .ID}})">
								<span class="glyphicon glyphicon-remove" aria-hidden="true" ></span>
								</button> 
							</td>-->
																		</tr>
																		
															{{ end }}
												</tbody>
									</table>
						</div>
	</div>

	</body>
	</html>

	<script>

	
	function watchIssue(namei){
		firebase.auth().onAuthStateChanged(function(user) {
				if (user) {
					window.location.href = "/watch?name="+namei+"&userid="+user.uid+"&username="+user.displayName;
				}
			});
	}

	function loadIssue(namei, idi){
	window.location.href = "/editissue?idi="+idi+"&name"+namei;
	}
	function voteIssue(idi,){
	window.location.href = "/vote?idi="+idi;
	}
	function xxx(x) {
	}

	
	function deleteWatcher(idi,userid){
 		window.location.href = "/deleteWatcher?idi="+idi+"&userid="+userid;
	}

	$(document).ready(function(){
			
		$(".searchable tr td:nth-child(1)").each(function () {
					var idT = $(this).children().text();
					var idN = parseInt(idT);
					{{range .watchers}}
						if (idN === {{.IssueiD}}) {
							$(this).siblings("#buttons").children().css({
							'font-size': '15px',
							'color' : 'black'
							});
						}
				{{end}}
		});
	});

	$(document).ready(function () {
		var userid;
		firebase.auth().onAuthStateChanged(function(user) {
		if (user) {
				userid = user.uid
		}else {
				// No user is signed in.
		}
		});
		$("button.btn-custom2").on("click", function(){
			var size =  $(this).css("font-size");
			var id = $(this).parent().siblings("#issuename").children().text();
			if (size == '12px'){
				$(this).css({
				'font-size': '15px',
				'color' : 'black'
				});
				createwatcher(id);
			}else{
				$(this).css({
				'font-size': '12px',
				'color' : '#747476'
				});
				deleteWatcher(id,userid)
			}        			
			});					
		});

		$(document).ready(function () {
			
				firebase.auth().onAuthStateChanged(function(user) {
					if (user) {
							userid = user.uid
					}else {
							// No user is signed in.
					}
				});

				$("button.btn-custom1").on("click", function(){
					var filter =  $(this).text();
				
						$(".searchable tr td:nth-child(4)").each(function () {
								if (filter === 'Open'){								
									$(this).parent().hide();
									console.log($(this).children().text());
									if($(this).children().text() === 'New' || $(this).children().text() === 'Open'){
											$(this).parent().show();
									}
								}
						});
						$(".searchable tr td:nth-child(9)").each(function () {
									if (filter === 'Watching'){
									$(this).parent().show();
									if($(this).children().css("font-size") === '12px'){
											$(this).parent().hide();
									}
								}
						}); 

						$(".searchable tr td:nth-child(1)").each(function () {
								if (filter === 'My issues'){
									$(this).parent().show();
									{{range .issues}}
										if({{.CreatoriD}} !== userid){
												$(this).parent().hide();
										}
									{{end}}
								}
					});
					$(".searchable tr td:nth-child(1)").each(function () {	
							if (filter === 'All'){
								$(this).parent().show();
							}
					});                         
			
				});
				
			});

	</script>


