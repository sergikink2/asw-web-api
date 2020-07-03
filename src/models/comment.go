package models

import (
	"github.com/jinzhu/gorm"
)

type Comment struct {
	gorm.Model   `json:"-"`
	IssueID      uint   `valid:"-"`
	FirebaseID   string `valid:"-"`
	FirebaseName string `valid:"-"`
	Content      string `valid:"-"`
}

func (c *Comment) Insert() uint {
	DB.Create(c)
	return c.ID
}

func ReadAllComments(issue uint) ([]Comment, error) {
	var cs []Comment
	err := DB.Where("issue_id = ?", issue).Find(&cs).Error
	return cs, err
}

func (c Comment) UpdateComment() error {
	var Commentaux Comment
	DB.First(&Commentaux, c.ID)
	Commentaux.Content = c.Content
	return DB.Save(&Commentaux).Error
}

func ReadAComment(id uint) (Comment, error) {
	var Commentaux Comment
	err := DB.First(&Commentaux, id).Error
	return Commentaux, err
}

func (c *Comment) DeleteComment() error {
	if c.ID != 0 {
		return DB.Delete(&c).Error
	}
	return nil
}
