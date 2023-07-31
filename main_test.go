package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http/httptest"
	"testing"

	"github.com/lib/pq"
	"github.com/stretchr/testify/assert"
)

var endpoints = []string{"/weapons", "/passiveitems", "/dlcs"}

func TestIndex(t *testing.T) {
	t.Parallel()
	app := initApp()
	req := httptest.NewRequest("GET", "/", nil)
	resp, _ := app.Test(req)

	assert.Equal(t, 200, resp.StatusCode, "GET to index expects 200")
}

func TestNonExistentRoute(t *testing.T) {
	t.Parallel()
	app := initApp()
	req := httptest.NewRequest("GET", "/foo", nil)
	resp, _ := app.Test(req)

	assert.Equal(t, 404, resp.StatusCode, "GET to non existent route /foo expects 404")
}

func TestGetWeapons(t *testing.T) {
	t.Parallel()
	app := initApp()
	req := httptest.NewRequest("GET", "/weapons", nil)
	resp, _ := app.Test(req)

	assert.Equal(t, 200, resp.StatusCode, "GET to /weapons expects 200")
}

func TestPostWeapons(t *testing.T) {
	t.Parallel()
	postBody := []Weapon{{Id: 0, Name: "Test Name", Description: "Test Description", UnlockRequirements: "Test Unlock Requirements", Dlc: "Base", BaseDamage: 10.5, MaxLevel: 5, Rarity: 50, Evolution: "Test Evolution", EvolvedWith: pq.StringArray{"Test Evolved With"}}}
	json, err := json.Marshal(postBody)
	if err != nil {
		fmt.Println("Error encoding JSON body")
	}

	reader := bytes.NewReader(json)

	app := initApp()
	req := httptest.NewRequest("POST", "/weapons", reader)
	req.Header.Set("Content-Type", "application/json")
	resp, _ := app.Test(req)

	assert.Equal(t, 201, resp.StatusCode, "POST to /weapons expects 201")
}

func TestPostInvalid(t *testing.T) {
	t.Parallel()

	for _, endpoint := range endpoints {
		postBody := map[string]string{"foo": "bar"}
		json, err := json.Marshal(postBody)
		if err != nil {
			fmt.Println("Error encoding JSON body")
		}

		reader := bytes.NewReader(json)

		app := initApp()
		req := httptest.NewRequest("POST", endpoint, reader)
		resp, _ := app.Test(req)

		assert.Equalf(t, 400, resp.StatusCode, "POST invalid JSON to %v expects 400", endpoint)
	}
}

func TestGetPassiveItems(t *testing.T) {
	t.Parallel()
	app := initApp()
	req := httptest.NewRequest("GET", "/passiveitems", nil)
	resp, _ := app.Test(req)

	assert.Equalf(t, 200, resp.StatusCode, "GET to /passiveitems expects 200")
}

func TestPostPassiveItems(t *testing.T) {
	t.Parallel()
	postBody := []PassiveItem{{Id: 0, Name: "Test Name", Description: "Test Description", UnlockRequirements: "Test Unlock Requirements", Dlc: "Base", MaxLevel: 5, Rarity: 50}}
	json, err := json.Marshal(postBody)
	if err != nil {
		fmt.Println("Error encoding JSON body")
	}

	reader := bytes.NewReader(json)

	app := initApp()
	req := httptest.NewRequest("POST", "/passiveitems", reader)
	req.Header.Set("Content-Type", "application/json")
	resp, _ := app.Test(req)

	assert.Equalf(t, 201, resp.StatusCode, "POST to /passiveitems expects 201")
}

func TestGetDlcs(t *testing.T) {
	t.Parallel()
	app := initApp()
	req := httptest.NewRequest("GET", "/dlcs", nil)
	resp, _ := app.Test(req)

	assert.Equalf(t, 200, resp.StatusCode, "GET to /dlcs expects 200")
}

func TestPostDlcs(t *testing.T) {
	t.Parallel()
	postBody := []Dlc{{Id: 0, Name: "Test Name"}}
	json, err := json.Marshal(postBody)
	if err != nil {
		fmt.Println("Error encoding JSON body")
	}

	reader := bytes.NewReader(json)

	app := initApp()
	req := httptest.NewRequest("POST", "/dlcs", reader)
	req.Header.Set("Content-Type", "application/json")
	resp, _ := app.Test(req)

	assert.Equalf(t, 201, resp.StatusCode, "POST to /dlcs expects 201")
}
