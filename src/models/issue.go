package models

import (
	"errors"

	"github.com/jinzhu/gorm"
)

type Issue struct {
	gorm.Model  `json:"-"`
	Name        string `valid:"-"`
	Priority    string `valid:"-"`
	Kind        string `valid:"-"`
	Worker      string `valid:"-"`
	Description string `valid:"-"`
	Status      string `valid:"-"`
	Votes       int    `valid:"-"`
	CreatoriD	string `valid:"-"`
	CreatorName string `valid:"-"`
}

func (i *Issue) Insert() uint {
	DB.Create(i)
	return i.ID
}

func ReadAllIssues() ([]Issue, error) {
	var is []Issue
	err := DB.Find(&is).Error
	return is, err
}

func ReadAnIssue(idiss uint) (Issue, error) {
	var is Issue
	err := DB.First(&is, idiss).Error
	return is, err
}

func ReadDeletedIssues() ([]Issue, error) {
	var is []Issue
	err := DB.Where("deleted_at != ?", nil).Find(&is).Error
	return is, err
}

func (i *Issue) ReadAnIssue() (Issue, error) {
	var is Issue
	err := DB.Where("id = ?", i.ID).Find(&is).Error
	return is, err
}

func (i *Issue) FindIssueByName() (Issue, error) {
	var is Issue
	err := DB.Where("name = ?", i.Name).Find(&is).Error
	return is, err
}

func (i Issue) UpdateIssue() error {
	var Issueaux Issue
	DB.First(&Issueaux, i.ID)
	if Issueaux.Name != "" {
		Issueaux = i
		return DB.Save(&Issueaux).Error
	} else {
		return errors.New("First devuelve campo vacío")
	}
}

func (i *Issue) DeleteIssue() error {
	if i.ID != 0 {
		return DB.Delete(&i).Error
	}
	return nil
}
