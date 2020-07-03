package models

import (
	"fmt"

	"github.com/jinzhu/gorm"
)

type Watcheable struct {
	gorm.Model `json:"-"`
	WatcheriD  string `gorm:"unique;not null"`
	IssueiD    uint   `valid:"-"`
}

func (w *Watcheable) Insert() uint {
	DB.Create(w)
	return w.ID
}
func ReadAllWatchers() ([]Watcheable, error) {
	var is []Watcheable
	err := DB.Find(&is).Error
	return is, err
}
func ReadAnWatcher(idiss uint, userid string) (Watcheable, error) {
	var is Watcheable
	//err := DB.First(&is, idiss).Error
	err := DB.Where("watcheri_d = ? AND issuei_d = ?", userid, idiss).Find(&is).Error
	return is, err
}
func (w *Watcheable) DeleteWatcher() error {
	fmt.Println(w)
	if w.ID != 0 {
		return DB.Delete(&w).Error
	}
	return nil
}
