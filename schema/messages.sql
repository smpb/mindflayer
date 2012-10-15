--
-- SQLite schema for messages database
--

PRAGMA foreign_keys=ON;

DROP TABLE IF EXISTS message;
CREATE TABLE message (
  id        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  date      DATETIME NOT NULL,
  type      TEXT NOT NULL,

  sender    REFERENCES user(nick) ON UPDATE CASCADE,
  src_name  TEXT,
  src_host  TEXT,
  target    REFERENCES alias(nick) ON UPDATE CASCADE,

  content   TEXT
);

DROP TABLE IF EXISTS alias;
CREATE TABLE alias (
  id    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  user  NOT NULL REFERENCES user(nick) ON UPDATE CASCADE,
  nick  TEXT NOT NULL,

  date        DATETIME
);

DROP TABLE IF EXISTS user;
CREATE TABLE user (
  id      INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  nick    TEXT NOT NULL,

  name    TEXT,
  gender  CHAR,
  url     TEXT,

  UNIQUE(nick)
);

CREATE INDEX message_by_alias ON message  (sender, content);
CREATE INDEX message_by_type  ON message  (type,   content);

