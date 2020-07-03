package controllers

import (
	"ASW/models"
	"context"
	"crypto/md5"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"log"

	firebase "firebase.google.com/go"
	"github.com/astaxie/beego"
	"google.golang.org/api/option"
)

type UserController struct {
	beego.Controller
}

var currentUser models.User

func (c *UserController) Getkey() {

	c.Data["key"] = string(createHash(currentUser.FirebaseID))
	c.TplName = "users/login.tpl"
}

func (c *UserController) Get() {
	opt := option.WithCredentialsFile("proyecto-de-asw-firebase-adminsdk-nercm-c5f2270bef.json")
	app, errno := firebase.NewApp(context.Background(), nil, opt)
	if errno != nil {
		log.Fatalf("error initializing app: %v\n", errno)
	}
	fmt.Println("Mi app es: ", app)

	c.TplName = "users/login.tpl"
}

func (c *UserController) CreateUser() {
	var user models.User
	json.Unmarshal(c.Ctx.Input.RequestBody, &user)
	currentUser = user
	id := user.Insert()
	fmt.Println("Mi id de watcher es : ", id)
	c.TplName = "users/login.tpl"

}

func createHash(key string) string {
	hasher := md5.New()
	hasher.Write([]byte(key))
	return hex.EncodeToString(hasher.Sum(nil))
}

/*
func (c *UserController) FAKE() {
	currentUser.FirebaseID = "Pol"
	currentUser, _ = models.ReadAnUser(currentUser.FirebaseID)
	c.Data["currentuser"] = currentUser.FirebaseID
	fmt.Println("Mi usuario actual es: ", currentUser)
	c.Redirect("/getlist", 302)
}
*/
