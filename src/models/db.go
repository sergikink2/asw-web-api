package models

import (
	"fmt"
	"strings"

	"github.com/astaxie/beego"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/mysql"
)

var DB *gorm.DB

func LoadDB() error {
	mUser := beego.AppConfig.String("mysqluser")
	mPass := beego.AppConfig.String("mysqlpass")
	mDB := beego.AppConfig.String("mysqlDB")
	con := mUser + ":" + mPass + "@/" + mDB + "?charset=utf8&parseTime=True&loc=Local"

	db, err := gorm.Open("mysql", con)
	if err != nil {
		fmt.Println("Failed to connect " + mDB + ": " + err.Error())
		fmt.Println("Trying to create a database...")
		DB, err = createDB(mUser, mPass, mDB)
		if err != nil {
			return err
		}
		println(mDB + " created succesfully")
	}

	DB = db

	println("Connected User...")
	DB.AutoMigrate(&User{})
	println("Migrating Issue...")
	DB.AutoMigrate(&Issue{})
	println("Migrating Comment...")
	DB.AutoMigrate(&Comment{})
	println("Migrating Watcheable...")
	DB.AutoMigrate(&Watcheable{})
	println("Done!")

	return nil
}

func createDB(mysqluser, mysqlpass, mysqldb string) (*gorm.DB, error) {
	var mysqlConnect []string
	mysqlConnect = append(mysqlConnect, mysqluser, ":", mysqlpass)
	mysqlConnect = append(mysqlConnect, "@tcp(localhost:3306)/?charset=utf8&parseTime=True&loc=Local")
	db, err := gorm.Open("mysql", strings.Join(mysqlConnect, ""))
	db.Exec("CREATE DATABASE " + mysqldb)
	db.Exec("USE " + mysqldb)
	return db, err
}
