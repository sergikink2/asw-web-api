package controllers

import (
	models "ASW/models"
	"encoding/json"
	"fmt"

	"github.com/astaxie/beego"
)

type IssueController struct {
	beego.Controller
}

type issue struct {
	Name        string
	Creator     string
	CreatoriD   string
	Worker      string
	Kind        string
	Description string
	Priority    string
}

var IssueGlobal models.Issue

type ug struct {
	ID   string
	Name string
}

type vote struct {
	NameOwner string
	NameIssue string
}

var UserGlobal ug

var votado []vote

var Globalcommentid uint

func (c *IssueController) Get() {

	c.Data["issues"], _ = models.ReadAllIssues()
	c.Data["watchers"], _ = models.ReadAllWatchers()
	c.TplName = "issue/list.tpl"
}

func (c *IssueController) New() {
	priorities := []string{"Trivial", "Minor", "Major", "Critical", "Blocker"}
	c.Data["priority"] = priorities
	kinds := []string{"Bug", "Enhacement", "Proposal", "Task"}
	c.Data["kind"] = kinds
	workers := []string{"Pol", "Sergi", "Jordi", "Alex"}
	c.Data["worker"] = workers
	c.TplName = "issue/create.tpl"
}

func (c *IssueController) Create() {

	var Issue models.Issue
	var issue issue
	json.Unmarshal(c.Ctx.Input.RequestBody, &issue)
	Issue.Name = issue.Name
	iss, _ := Issue.FindIssueByName()
	if iss.Priority != "" {
		c.Redirect("/exists", 302)
	}
	Issue.Description = issue.Description
	Issue.Worker = issue.Worker
	Issue.Kind = issue.Kind
	Issue.Priority = issue.Priority
	Issue.Status = "New"
	Issue.CreatoriD = issue.CreatoriD
	Issue.CreatorName = issue.Creator
	id := Issue.Insert()
	issaux, _ := models.ReadAnIssue(id)
	IssueGlobal = Issue
	IssueGlobal.CreatedAt = issaux.CreatedAt
	c.Redirect("/getlist", 302)
}

func (c *IssueController) Exists() {
	c.TplName = "issue/exists.tpl"
}

func (c *IssueController) Vote() {
	var iss models.Issue
	idi, _ := c.GetInt("idi")
	iss.ID = uint(idi)
	Issueaux, _ := iss.ReadAnIssue()
	i := 0
	trobat := false
	for i = 0; i < len(votado) && !trobat; i++ {
		if votado[i].NameIssue == Issueaux.Name && votado[i].NameOwner == UserGlobal.Name {
			trobat = true
		}
	}
	var newvotado vote
	newvotado.NameIssue = Issueaux.Name
	newvotado.NameOwner = UserGlobal.Name
	votado = append(votado, newvotado)
	Issueaux.Votes += 1
	Issueaux.UpdateIssue()
	c.Redirect("/getlist", 302)
}

func (c *IssueController) Edit() {
	priorities := []string{"Trivial", "Minor", "Major", "Critical", "Blocker"}
	c.Data["priority"] = priorities
	kinds := []string{"Bug", "Enhacement", "Proposal", "Task"}
	c.Data["kind"] = kinds
	workers := []string{"Pol", "Sergi", "Jordi", "Alex"}
	c.Data["worker"] = workers
	status := []string{"New", "On hold", "Resolved", "Duplicate", "Invalid", "Wontfix", "Closed"}
	c.Data["status"] = status
	c.Data["issuenameupdate"] = c.GetString("name")

	var iss models.Issue
	idi, _ := c.GetInt("idi")
	iss.ID = uint(idi)
	Issueaux, err := iss.ReadAnIssue()
	IssueGlobal.ID = iss.ID
	if err == nil {
		c.Data["issuenameupdate"] = Issueaux.Name
		c.Data["issuedescriptionupdate"] = Issueaux.Description
		fmt.Println("Mi issuedescription es: ", Issueaux.Description)
		c.Data["issuepriority"] = Issueaux.Priority
		c.Data["issuekind"] = Issueaux.Kind
		c.Data["issueworker"] = Issueaux.Worker
		c.Data["issuestatus"] = Issueaux.Status
	}
	c.TplName = "issue/edit.tpl"
}

func (c *IssueController) Update() {
	// changes
	Issue, _ := IssueGlobal.ReadAnIssue()
	Issue.Name = c.GetString("issuename")
	Issue.Description = c.GetString("issuedescription")
	Issue.Worker = c.GetString("worker")
	Issue.Kind = c.GetString("kind")
	Issue.Priority = c.GetString("priority")
	Issue.Status = c.GetString("status")
	Issue.UpdateIssue()
	IssueGlobal = Issue
	c.Redirect("/issuedescription", 302)
}

func (c *IssueController) IssueDescrip() {
	c.Data["IDissue"] = IssueGlobal.ID
	c.Data["name"] = IssueGlobal.Name
	c.Data["kind"] = IssueGlobal.Kind
	c.Data["description"] = IssueGlobal.Description
	c.Data["priority"] = IssueGlobal.Priority
	c.Data["worker"] = IssueGlobal.Worker
	c.Data["nbVotes"] = IssueGlobal.Votes
	c.Data["data"] = IssueGlobal.CreatedAt
	c.Data["status"] = IssueGlobal.Status
	statuslist := []string{"New", "On hold", "Resolved", "Duplicate", "Invalid", "Wontfix", "Closed"}
	c.Data["statuslist"] = statuslist
	c.Data["creator"] = IssueGlobal.CreatorName
	c.Data["comments"], _ = models.ReadAllComments(IssueGlobal.ID)
	c.TplName = "issue/description.tpl"
}

func (c *IssueController) Watch() {
	c.Data["issuenameupdate"] = c.GetString("name")
	var auxIssue models.Issue
	auxIssue.Name = c.GetString("name")
	Issueaux, _ := auxIssue.FindIssueByName()
	IssueGlobal = Issueaux
	UserGlobal.ID = c.GetString("userid")
	UserGlobal.Name = c.GetString("username")
	c.Redirect("/issuedescription", 302)
}

func (c *IssueController) Delete() {
	id, _ := c.GetInt("idi")
	uid := uint(id)
	fmt.Println("Mi id issue para eliminar es el: ", uid)

	auxIssue, _ := models.ReadAnIssue(uid)
	auxIssue.DeleteIssue()
	c.Redirect("/getlist", 302)

}

func (c *IssueController) Resolve() {
	id, _ := c.GetInt("idi")
	uid := uint(id)
	fmt.Println("Mi id issue para resolver es el: ", uid)

	auxIssue, _ := models.ReadAnIssue(uid)
	auxIssue.Status = "Resolve"
	auxIssue.UpdateIssue()
	IssueGlobal = auxIssue
	fmt.Println("Mi issue status es el siguiente: ", IssueGlobal.Status)
	c.Redirect("/issuedescription", 302)
}

func (c *IssueController) CreateComment() {
	var Comment models.Comment
	Comment.IssueID = IssueGlobal.ID
	Comment.FirebaseID = UserGlobal.ID
	Comment.FirebaseName = UserGlobal.Name
	Comment.Content = c.GetString("contentcomment")
	Comment.Insert()
	c.Redirect("/issuedescription", 302)
}

func (c *IssueController) DeleteComment() {
	var Comment models.Comment
	id, _ := c.GetInt("idi")
	Comment.IssueID = uint(id)
	fmt.Println("Mi comment to delete es: ", Comment.IssueID)
	Comment, _ = models.ReadAComment(Comment.IssueID)
	if UserGlobal.Name == Comment.FirebaseName {
		Comment.DeleteComment()
	}
	c.Redirect("/issuedescription", 302)
}

func (c *IssueController) EditComment() {
	var Comment models.Comment
	id, _ := c.GetInt("idi")
	Comment.IssueID = uint(id)
	fmt.Println("Mi comment to edit es: ", Comment.IssueID)
	c.Data["IDissue"] = IssueGlobal.ID
	c.Data["name"] = IssueGlobal.Name
	c.Data["kind"] = IssueGlobal.Kind
	c.Data["description"] = IssueGlobal.Description
	c.Data["priority"] = IssueGlobal.Priority
	c.Data["worker"] = IssueGlobal.Worker
	c.Data["nbVotes"] = IssueGlobal.Votes
	c.Data["data"] = IssueGlobal.CreatedAt
	c.Data["status"] = IssueGlobal.Status
	statuslist := []string{"New", "On hold", "Resolved", "Duplicate", "Invalid", "Wontfix", "Closed"}
	c.Data["statuslist"] = statuslist
	c.Data["creator"] = IssueGlobal.CreatorName
	Comment, _ = models.ReadAComment(Comment.IssueID)
	Globalcommentid = Comment.ID
	c.Data["commentname"] = Comment.FirebaseName
	c.Data["commentdescription"] = Comment.Content
	c.TplName = "issue/descriptionfake.tpl"

}

func (c *IssueController) UpdateComment() {
	var updatecomment models.Comment
	updatecomment.ID = Globalcommentid
	updatecomment.Content = c.GetString("content")
	auxcomment, _ := models.ReadAComment(Globalcommentid)

	if auxcomment.FirebaseName == UserGlobal.Name {
		fmt.Println("He entrado en el IF")
		updatecomment.UpdateComment()
	}
	c.Redirect("/issuedescription", 302)
}
