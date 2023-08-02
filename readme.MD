# Vampire Survivors API

## Description

Currently a work in progress, lacking some tests and a full data set. Additional endpoints to be added along with endpoint documentation.

Uses Go with the Fiber framework to provide an API for querying information about elements of the popular [Vampire Survivors] video game. Stores data in Postgres.

## Notes

Should also run with the included experimental Dockerfile

See Makefile for useful commands, including creating tables and data from dbschema.sql

By default binds to 0.0.0.0 on port 8000

**Note there is no meaningful password on the SQL database and testing authentication info is currently stored in plain text rather than in an env var or any secure way.**

## Attributions

[Fiber web framework](https://gofiber.io)

[Vampire Survivors by poncle](https://store.steampowered.com/app/1794680/Vampire_Survivors/)

[Data from Vampire Survivors wiki on Fandom](https://vampire-survivors.fandom.com/wiki/Vampire_Survivors_Wiki) under [Creative Commons Attribution-Share Alike License 3.0 (Unported) (CC BY-SA)](https://creativecommons.org/licenses/by-sa/3.0/)