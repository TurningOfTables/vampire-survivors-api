package main

import (
	"fmt"
	"reflect"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/log"
	"github.com/google/uuid"
	"golang.org/x/text/cases"
	"golang.org/x/text/language"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

type Weapon struct {
	gorm.Model
	Name               string `gorm:"unique"`
	Description        string
	UnlockRequirements string
	Dlc                string
	BaseDamage         float64
	MaxLevel           int
	Rarity             int
	Evolution          string
	EvolvedWith        string
	Uuid               string
}

type PassiveItem struct {
	gorm.Model
	Name               string `gorm:"unique"`
	Description        string
	UnlockRequirements string
	Dlc                string
	MaxLevel           int
	Rarity             int
	Uuid               string
}

type Dlc struct {
	gorm.Model
	Name string `gorm:"unique"`
	Uuid string
}

var port string = "8000"

func main() {
	log.SetLevel(log.LevelInfo)

	app := initApp()

	app.Listen(fmt.Sprintf("localhost:%v", port))
}

func initApp() *fiber.App {
	db, err := gorm.Open(sqlite.Open("data.db"), &gorm.Config{})
	if err != nil {
		log.Fatal(err)
	}

	app := fiber.New()
	app.Static("/", "./docs")

	db.AutoMigrate(&Weapon{})
	db.AutoMigrate(&PassiveItem{})
	db.AutoMigrate(&Dlc{})

	app.Get("/weapons", func(c *fiber.Ctx) error {
		return getWeapons(c, db)

	})
	app.Post("/weapons", func(c *fiber.Ctx) error {
		return postWeapons(c, db)
	})
	app.Get("/weapons/:searchField/:searchValue", func(c *fiber.Ctx) error {
		return getWeaponBySearch(c, db)
	})
	app.Get("/passiveitems", func(c *fiber.Ctx) error {
		return getPassiveItems(c, db)
	})
	app.Post("/passiveitems", func(c *fiber.Ctx) error {
		return postPassiveItems(c, db)
	})
	app.Get("/dlcs", func(c *fiber.Ctx) error {
		return getDlcs(c, db)
	})
	app.Post("/dlcs", func(c *fiber.Ctx) error {
		return postDlcs(c, db)
	})

	return app
}

func getWeapons(c *fiber.Ctx, db *gorm.DB) error {
	var weapons []Weapon

	rows, err := db.Find(&weapons).Rows()
	if err != nil {
		log.Warn(err)
		return c.Status(fiber.StatusInternalServerError).JSON("Error getting weapons from database")
	}
	defer rows.Close()
	return c.JSON(weapons)
}

func getWeaponBySearch(c *fiber.Ctx, db *gorm.DB) error {
	var weapons []Weapon
	searchField := c.Params("searchField")
	searchValue := c.Params("searchValue")

	if !isValidSearchField(searchField, Weapon{}) {
		return c.Status(fiber.StatusBadRequest).JSON("Invalid search field")
	}

	if err := db.Where(searchField+" = ?", titleCase(searchValue)).Find(&weapons).Error; err != nil {
		fmt.Println(err)
	}
	return c.JSON(weapons)
}

func postWeapons(c *fiber.Ctx, db *gorm.DB) error {
	var weapons []Weapon

	if err := c.BodyParser(&weapons); err != nil {
		log.Warn(err)
		return c.Status(400).JSON("Error in POST /weapons request body")
	}

	for _, w := range weapons {
		uuid := generateUUID()
		w.Uuid = uuid
		log.Infof("Inserting %v", w)
		if err := db.Create(&w).Error; err != nil {
			log.Warn(err)
			return c.Status(500).JSON("Error saving weapon to database")
		}
	}

	return c.SendStatus(fiber.StatusCreated)
}

func getPassiveItems(c *fiber.Ctx, db *gorm.DB) error {
	var passiveItems []PassiveItem

	rows, err := db.Find(&passiveItems).Rows()
	if err != nil {
		log.Warn(err)
		return c.Status(fiber.StatusInternalServerError).JSON("Error getting passiveItems from database")
	}
	defer rows.Close()
	return c.JSON(passiveItems)
}

func postPassiveItems(c *fiber.Ctx, db *gorm.DB) error {
	var passiveItems []PassiveItem

	if err := c.BodyParser(&passiveItems); err != nil {
		log.Warn(err)
		return c.Status(400).JSON("Error in POST /passiveitems request body")
	}

	for _, p := range passiveItems {
		uuid := generateUUID()
		p.Uuid = uuid
		log.Infof("Inserting %v", p)
		if err := db.Create(&p).Error; err != nil {
			log.Warn(err)
			return c.Status(500).JSON("Error saving passive item to database")
		}
	}

	return c.SendStatus(fiber.StatusCreated)
}

func getDlcs(c *fiber.Ctx, db *gorm.DB) error {
	var dlcs []Dlc

	rows, err := db.Find(&dlcs).Rows()
	if err != nil {
		log.Warn(err)
		return c.Status(fiber.StatusInternalServerError).JSON("Error getting dlcs from database")
	}
	defer rows.Close()
	return c.JSON(dlcs)
}

func postDlcs(c *fiber.Ctx, db *gorm.DB) error {
	var dlcs []Dlc

	if err := c.BodyParser(&dlcs); err != nil {
		log.Warn(err)
		return c.Status(400).JSON("Error in POST /dlcs request body")
	}

	for _, d := range dlcs {
		uuid := generateUUID()
		d.Uuid = uuid
		log.Infof("Inserting %v", d)

		if err := db.Create(&d).Error; err != nil {
			log.Warn(err)
			return c.Status(fiber.StatusInternalServerError).JSON("Error saving dlc to database")
		}
	}

	return c.SendStatus(fiber.StatusCreated)
}

func generateUUID() string {
	uuid, err := uuid.NewRandom()
	if err != nil {
		log.Warn(err)
	}

	return uuid.String()
}

func titleCase(text string) string {
	cs := cases.Title(language.English)
	return cs.String(text)
}

func isValidSearchField(searchField string, i interface{}) bool {
	t := reflect.TypeOf(i)
	searchField = titleCase(searchField)

	for i := 0; i < t.NumField(); i++ {
		if _, found := t.FieldByName(searchField); found {
			return true
		}
	}
	return false
}
