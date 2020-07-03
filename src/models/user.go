package models

import (
	"github.com/jinzhu/gorm"
)

type User struct {
	gorm.Model `json:"-"`
	Name       string `valid:"-"`
	FirebaseID string `gorm:"unique;not null"`
}

func (u *User) Insert() uint {
	DB.Create(u)
	return u.ID

}

func ReadAllUsers() ([]User, error) {
	var us []User
	err := DB.Find(&us).Error
	return us, err
}

func ReadAnUser(uid string) (User, error) {
	var u User
	err := DB.Where("firebase_id = ?", uid).First(&u).Error
	return u, err
}

func (u User) UpdateUser() error {
	var Useraux User
	DB.First(&Useraux, u.ID)
	Useraux = u
	return DB.Save(&Useraux).Error
}

func (u *User) DeleteUser() error {
	if u.ID != 0 {
		return DB.Delete(&u).Error
	}
	return nil
}
