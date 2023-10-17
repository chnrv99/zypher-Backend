-- so first scene only 1 challenge
-- second and third, 2 challenges
-- fourth only 1 challenge
-- for first and fourth scene, they have to complete that one challenge to advance
-- for second and third scene, they have to complete any one challenge to advance

CREATE TABLE
    IF NOT EXISTS questions (
        level DECIMAL(1,1) PRIMARY KEY NOT NULL,
        scene INTEGER NOT NULL,
        text TEXT NOT NULL,
        image TEXT,
        answer TEXT NOT NULL
    );

CREATE TABLE
    IF NOT EXISTS users (
        username TEXT PRIMARY KEY NOT NULL CHECK(
            LENGTH(username) BETWEEN 3 AND 20
        ),
        avatar TEXT NOT NULL,
        password TEXT NOT NULL,
        level DECIMAL(1,1) NOT NULL DEFAULT 1,
        scene INTEGER NOT NULL DEFAULT 1,
        reachedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE
    IF NOT EXISTS attempts (
        username TEXT NOT NULL REFERENCES users(username),
        level INTEGER NOT NULL REFERENCES questions(level),
        attempt TEXT NOT NULL,
        timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

CREATE INDEX
    IF NOT EXISTS leaderboard ON users(level DESC, reachedAt ASC);