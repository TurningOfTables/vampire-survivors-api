package main

import (
	"database/sql"
	"errors"
	"fmt"
	"reflect"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/log"
	"github.com/google/uuid"
	"github.com/lib/pq"
	"golang.org/x/text/cases"
	"golang.org/x/text/language"
)

var dbStr string = "postgresql://postgres:pass@localhost:5432/vsapi?sslmode=disable"
var port string = "8000"

type Weapon struct {
	Name               string
	Description        string
	UnlockRequirements string
	Dlc                string
	BaseDamage         float64
	MaxLevel           int
	Rarity             int
	Evolution          string
	EvolvedWith        pq.StringArray
	Uuid               string
}

type PassiveItem struct {
	Name               string
	Description        string
	UnlockRequirements string
	Dlc                string
	MaxLevel           int
	Rarity             int
	Uuid               string
}

type Dlc struct {
	Name string
	Uuid string
}

func main() {
	log.SetLevel(log.LevelInfo)

	app := initApp()

	app.Listen(fmt.Sprintf("localhost:%v", port))
}

func initApp() *fiber.App {
	db, err := sql.Open("postgres", dbStr)
	if err != nil {
		log.Fatal(err)
	}

	app := fiber.New()
	app.Static("/", "./docs")
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

func getWeapons(c *fiber.Ctx, db *sql.DB) error {
	var weapons []Weapon

	rows, err := db.Query("SELECT * from weapons")
	if err != nil {
		log.Warn(err)
		return c.Status(500).JSON("Error reading weapons from db")
	}
	defer rows.Close()

	for rows.Next() {
		var w Weapon
		err := rows.Scan(&w.Name, &w.Description, &w.UnlockRequirements, &w.Dlc, &w.BaseDamage, &w.MaxLevel, &w.Rarity, &w.Evolution, &w.EvolvedWith, &w.Uuid)
		if err != nil {
			log.Warn(err)
		}

		weapons = append(weapons, w)
	}
	return c.JSON(weapons)

}

func getWeaponBySearch(c *fiber.Ctx, db *sql.DB) error {
	var weapons []Weapon
	weaponField := c.Params("searchField")
	weaponValue := c.Params("searchValue")

	weaponValue = titleCase(weaponValue)
	query, err := dangerouslyFormSqlWeaponSearch(weaponField, weaponValue, db)
	if err != nil {
		log.Error(err)
	}
	fmt.Println(query)

	rows, err := db.Query(query)
	if err != nil {
		log.Warn(err)
		return c.Status(500).JSON("Error searching for weapon")
	}
	defer rows.Close()

	for rows.Next() {
		var w Weapon
		err := rows.Scan(&w.Name, &w.Description, &w.UnlockRequirements, &w.Dlc, &w.BaseDamage, &w.MaxLevel, &w.Rarity, &w.Evolution, &w.EvolvedWith, &w.Uuid)
		if err != nil {
			log.Warn(err)
		}
		weapons = append(weapons, w)
	}

	return c.JSON(weapons)
}

func postWeapons(c *fiber.Ctx, db *sql.DB) error {
	var weapons []Weapon

	if err := c.BodyParser(&weapons); err != nil {
		log.Warn(err)
		return c.Status(400).JSON("Error in POST /weapons request body")
	}

	for _, w := range weapons {
		uuid := generateUUID()
		w.Uuid = uuid
		log.Infof("Inserting %v", w)
		_, err := db.Exec("INSERT into weapons (uuid, name, description, unlockrequirements, dlc, basedamage, maxlevel, rarity, evolution, evolvedwith) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)", w.Uuid, w.Name, w.Description, w.UnlockRequirements, w.Dlc, w.BaseDamage, w.MaxLevel, w.Rarity, w.Evolution, pq.Array(w.EvolvedWith))
		if err != nil {
			log.Warn(err)
			return c.Status(500).JSON("Error in POST /weapons creating new entry")
		}
	}

	return c.SendStatus(fiber.StatusCreated)
}

func getPassiveItems(c *fiber.Ctx, db *sql.DB) error {
	var passiveItems []PassiveItem

	rows, err := db.Query("SELECT * from passiveitems")
	if err != nil {
		log.Warn(err)
		return c.Status(500).JSON("Error reading passive items from db")
	}

	defer rows.Close()

	for rows.Next() {
		var p PassiveItem
		err := rows.Scan(&p.Name, &p.Description, &p.UnlockRequirements, &p.Dlc, &p.MaxLevel, &p.Rarity, &p.Uuid)
		if err != nil {
			log.Warn(err)
		}

		passiveItems = append(passiveItems, p)
	}
	return c.JSON(passiveItems)
}

func postPassiveItems(c *fiber.Ctx, db *sql.DB) error {
	var passiveItems []PassiveItem

	if err := c.BodyParser(&passiveItems); err != nil {
		log.Warn(err)
		return c.Status(400).JSON("Error in POST /passiveitems request body")
	}

	for _, p := range passiveItems {
		uuid := generateUUID()
		p.Uuid = uuid
		log.Infof("Inserting %v", p)

		_, err := db.Exec("INSERT into passiveitems (uuid, name, description, unlockrequirements, dlc, maxlevel, rarity) VALUES ($1, $2, $3, $4, $5, $6, $7)", p.Uuid, p.Name, p.Description, p.UnlockRequirements, p.Dlc, p.MaxLevel, p.Rarity)
		if err != nil {
			log.Warn(err)
			return c.Status(fiber.StatusInternalServerError).JSON("Error in POST /passiveitems creating new entry")
		}
	}

	return c.SendStatus(fiber.StatusCreated)
}

func getDlcs(c *fiber.Ctx, db *sql.DB) error {
	var dlcs []Dlc

	rows, err := db.Query("SELECT * from dlcs")
	if err != nil {
		log.Warn(err)
		return c.JSON("Error reading dlc from db")
	}
	defer rows.Close()

	for rows.Next() {
		var d Dlc
		err := rows.Scan(&d.Uuid, &d.Name)
		if err != nil {
			log.Warn(err)
		}

		dlcs = append(dlcs, d)
	}

	return c.JSON(dlcs)
}

func postDlcs(c *fiber.Ctx, db *sql.DB) error {
	var dlcs []Dlc

	if err := c.BodyParser(&dlcs); err != nil {
		log.Warn(err)
		return c.Status(400).JSON("Error in POST /dlcs request body")
	}

	for _, d := range dlcs {
		uuid := generateUUID()
		d.Uuid = uuid
		log.Infof("Inserting %v", d)

		_, err := db.Exec("INSERT into dlcs (uuid, name) VALUES ($1, $2)", d.Uuid, d.Name)
		if err != nil {
			log.Warn(err)
			return c.Status(fiber.StatusInternalServerError).JSON("Error in POST /dlcs creating new entry")
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
	cr := cases.Title(language.English)
	return cr.String(text)
}

// Only form SQL if the field exists, but is the wrong way to do this anyway
func dangerouslyFormSqlWeaponSearch(weaponField, weaponValue string, db *sql.DB) (string, error) {
	if isValidWeaponField(weaponField) {
		query := fmt.Sprintf("SELECT * FROM weapons WHERE %v = '%v'", weaponField, weaponValue)
		return query, nil
	}

	return "", errors.New("error forming SQL for weapon search")
}

func isValidWeaponField(weaponField string) bool {
	var w Weapon
	t := reflect.TypeOf(w)
	weaponField = titleCase(weaponField)

	for i := 0; i < t.NumField(); i++ {
		if t.Field(i).Name == weaponField {
			return true
		}
	}
	return false
}

func isValidStructField(field string, s interface{}) bool {
	t := reflect.TypeOf(s)
	field = titleCase(field)

	for i := 0; i < t.NumField(); i++ {
		if t.Field(i).Name == field {
			return true
		}
	}

	return false
}
