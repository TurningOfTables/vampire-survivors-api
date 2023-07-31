package main

import (
	"database/sql"
	"fmt"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/log"
	"github.com/lib/pq"
)

var dbStr string = "postgresql://postgres:pass@db:5432/vsapi?sslmode=disable"
var port string = "8000"

type Weapon struct {
	Id                 int
	Name               string
	Description        string
	UnlockRequirements string
	Dlc                string
	BaseDamage         float64
	MaxLevel           int
	Rarity             int
	Evolution          string
	EvolvedWith        pq.StringArray
}

type PassiveItem struct {
	Id                 int
	Name               string
	Description        string
	UnlockRequirements string
	Dlc                string
	MaxLevel           int
	Rarity             int
}

type Dlc struct {
	Id   int
	Name string
}

func main() {
	log.SetLevel(log.LevelInfo)

	app := initApp()

	app.Listen(fmt.Sprintf("0.0.0.0:%v", port))
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
		err := rows.Scan(&w.Id, &w.Name, &w.Description, &w.UnlockRequirements, &w.Dlc, &w.BaseDamage, &w.MaxLevel, &w.Rarity, &w.Evolution, &w.EvolvedWith)
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
		count, err := countTable(db, "weapons")
		if err != nil {
			log.Warn(err)
		}
		w.Id = count
		log.Infof("Inserting %v", w)
		_, err = db.Exec("INSERT into weapons (id, name, description, unlockrequirements, dlc, basedamage, maxlevel, rarity, evolution, evolvedwith) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)", w.Id, w.Name, w.Description, w.UnlockRequirements, w.Dlc, w.BaseDamage, w.MaxLevel, w.Rarity, w.Evolution, pq.Array(w.EvolvedWith))
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
		err := rows.Scan(&p.Id, &p.Name, &p.Description, &p.UnlockRequirements, &p.Dlc, &p.MaxLevel, &p.Rarity)
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
		count, err := countTable(db, "passiveitems")
		if err != nil {
			log.Warn(err)
		}
		p.Id = count
		log.Infof("Inserting %v", p)

		_, err = db.Exec("INSERT into passiveitems (id, name, description, unlockrequirements, dlc, maxlevel, rarity) VALUES ($1, $2, $3, $4, $5, $6, $7)", p.Id, p.Name, p.Description, p.UnlockRequirements, p.Dlc, p.MaxLevel, p.Rarity)
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
		err := rows.Scan(&d.Id, &d.Name)
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
		count, err := countTable(db, "dlcs")
		if err != nil {
			log.Warn(err)
		}
		d.Id = count
		log.Infof("Inserting %v", d)

		_, err = db.Exec("INSERT into dlcs (id, name) VALUES ($1, $2)", d.Id, d.Name)
		if err != nil {
			log.Warn(err)
			return c.Status(fiber.StatusInternalServerError).JSON("Error in POST /dlcs creating new entry")
		}
	}

	return c.SendStatus(fiber.StatusCreated)
}

func countTable(db *sql.DB, table string) (int, error) {
	var c int
	query := fmt.Sprintf("SELECT COUNT(*) FROM %v", table)
	rows, err := db.Query(query)
	if err != nil {
		log.Warn(err)
		return 0, err
	}
	defer rows.Close()

	for rows.Next() {
		err := rows.Scan(&c)
		if err != nil {
			log.Warn(err)
			return 0, err
		}
	}

	return c, nil
}
