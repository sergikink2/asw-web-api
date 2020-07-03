package controllers

import (
	models "ASW/models"
	"encoding/json"
	"fmt"

	"github.com/astaxie/beego"
)

type WatcherController struct {
	beego.Controller
}

type watcher struct {
	WatcheriD string
	IssueiD   uint
}

var WatcherGlobal models.Watcheable

func (c *WatcherController) Get() {
	c.Data["watchers"], _ = models.ReadAllWatchers()
	c.TplName = "issue/list.tpl"
}

func (c *WatcherController) Watching() {

	var Watcher models.Watcheable
	var watcherAux watcher
	json.Unmarshal(c.Ctx.Input.RequestBody, &watcherAux)
	//fmt.Println(watcherAux)
	Watcher.WatcheriD = watcherAux.WatcheriD
	Watcher.IssueiD = watcherAux.IssueiD
	id := Watcher.Insert()
	fmt.Println("Mi id de watcher es : ", id)
	c.TplName = "issue/list.tpl"

}

func (c *WatcherController) Delete() {

	id, _ := c.GetInt("idi")
	uid := uint(id)
	var userid = c.GetString("userid")
	fmt.Println("Mi id issue para eliminar es el: ", uid)

	auxWatcher, _ := models.ReadAnWatcher(uid, userid)
	fmt.Println(auxWatcher)
	auxWatcher.DeleteWatcher()
	c.Redirect("/getlist", 302)

}
