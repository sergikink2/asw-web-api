package routers

import (
	"ASW/controllers"

	"github.com/astaxie/beego"
)

func init() {
	beego.Router("/", &controllers.UserController{})

	beego.Router("/createcomment", &controllers.IssueController{}, "post:CreateComment")
	beego.Router("/deletecomment", &controllers.IssueController{}, "get:DeleteComment")
	beego.Router("/editcomment", &controllers.IssueController{}, "get:EditComment")
	beego.Router("/updatecomment", &controllers.IssueController{}, "post:UpdateComment")

	beego.Router("/getlist", &controllers.IssueController{})
	beego.Router("/newissue", &controllers.IssueController{}, "get:New")
	beego.Router("/createissue", &controllers.IssueController{}, "post:Create")
	beego.Router("/editissue", &controllers.IssueController{}, "get:Edit")
	beego.Router("/updateissue", &controllers.IssueController{}, "post:Update")
	beego.Router("/issuedescription", &controllers.IssueController{}, "get:IssueDescrip")
	beego.Router("/delete", &controllers.IssueController{}, "get:Delete")
	beego.Router("/exists", &controllers.IssueController{}, "get:Exists")
	beego.Router("/watch", &controllers.IssueController{}, "get:Watch")
	beego.Router("/changevotes", &controllers.IssueController{}, "get:Vote")
	beego.Router("/resolveissue", &controllers.IssueController{}, "get:Resolve")

	beego.Router("/getwatchers", &controllers.WatcherController{})
	beego.Router("/createwatcher", &controllers.WatcherController{}, "post:Watching")
	beego.Router("/deleteWatcher", &controllers.WatcherController{}, "get:Delete")
	beego.Router("/createuser", &controllers.UserController{}, "post:CreateUser")
	beego.Router("/getkey", &controllers.UserController{}, "get:Getkey")

}
