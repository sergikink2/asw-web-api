<!DOCTYPE html>
<html>
    <head>
        <title>Issue Creation</title>
        <link rel="stylesheet" type="text/css" href="../css/creation.css">
        <meta charset="utf-8">
    </head>
    <body> 
        <p> Create issue </p>
        <div id="form">
            <Form >
            	<div class="first">
            		<label>Title *</label>
            		<input type="text" name="title">

            	</div>
            	<div class="first">
            		<label>Description</label>
            		<textarea></textarea>
            	</div>
            	<div>
            		<label>Assignee</label>
            		<select>
            			<option>Sergi</option>
            			<option>Jordi</option>
            			<option>Àlex</option>
            			<option>Pol</option>
            		</select>
            	</div>
            	<div>
            		<label>Kind *</label>
            		<select>
            			<option>Bug</option>
            			<option>Enhancement</option>
            			<option>Proposal</option>
            			<option>Task</option>
            		</select>
            	</div>
            	<div>
            		<label>Priority *</label>
            		<select>
            			<option>Trivial</option>
            			<option>Minor</option>
            			<option>Major</option>
            			<option>Critical</option>
            			<option>Blocker</option>
            		</select>
            	</div>	
            </Form>
        </div>
        <div id="buttons">
        	<button id="b1">Create issue</button> <button id="b2">Cancel</button>
        </div>
    </body>
</html>