--- Creo el Schema
CREATE SCHEMA canciones2024;

--- Creo las tablas que voy a utilizar
DROP TABLE IF EXISTS canciones;
CREATE TABLE IF NOT EXISTS canciones (
	ID					INT PRIMARY KEY,
	SONG				VARCHAR(200),
	ALBUM				VARCHAR(200),
    ARTIST				VARCHAR(100),
    RELEASE_DATE		VARCHAR(100),
    ALL_TIME_RANK		BIGINT,
    SCORE				FLOAT,
    EXPLICIT			INT
);

DROP TABLE IF EXISTS spotify;
CREATE TABLE IF NOT EXISTS spotify (
	ID					INT PRIMARY KEY,
	SPOTIFY_STREAMS				BIGINT,
	SPOTIFY_PLAYLIST_COUNT		BIGINT,
	SPOTIFY_PLAYLIST_REACH		BIGINT,
	SPOTIFY_POPULARITY			BIGINT
);

DROP TABLE IF EXISTS youtube;
CREATE TABLE IF NOT EXISTS youtube (
	ID					INT PRIMARY KEY,
	YOUTUBE_VIEWS				BIGINT,
    YOUTUBE_LIKES				BIGINT,
    YOUTUBE_PLAYLIST_REACH		BIGINT
);

DROP TABLE IF EXISTS tiktok;
CREATE TABLE IF NOT EXISTS tiktok (
	ID					INT PRIMARY KEY,
	TIKTOK_POST					BIGINT,
    TIKTOK_LIKES				BIGINT,
    TIKTOK_VIEWS				BIGINT
);

DROP TABLE IF EXISTS misc;
CREATE TABLE IF NOT EXISTS misc (
	ID					INT PRIMARY KEY,
	APPLE_PLAYLIST_COUNT		BIGINT,
    AIRPLAY_SPINS				BIGINT,
    SIRIUSXM_SPINS				BIGINT,
    DEEZER_PLAYLIST_COUNT		BIGINT,
    DEEZER_PLAYLIST_REACH		BIGINT,
    AMAZON_PLAYLIST_COUNT		BIGINT,
    PANDORA_STREAMS				BIGINT,
    PANDORA_TRACK_STATIONS		BIGINT,
    SOUNDCLOUD_STREAMS			BIGINT,
    SHAZAM_COUNTS				BIGINT
);


--- Creo una tabla temporal para cargar el dataset
DROP TABLE IF EXISTS temp_canciones;
CREATE TABLE IF NOT EXISTS temp_canciones (
	ID							INT PRIMARY KEY,
    SONG						VARCHAR(250),
	ALBUM						VARCHAR(200),
    ARTIST						VARCHAR(100),
    RELEASE_DATE				VARCHAR(100),
    ISRC						VARCHAR(100),
    ALL_TIME_RANK				VARCHAR(100),
    Track_Score					FLOAT,
    SPOTIFY_STREAMS				BIGINT,
	SPOTIFY_PLAYLIST_COUNT		BIGINT,
	SPOTIFY_PLAYLIST_REACH		BIGINT,
	SPOTIFY_POPULARITY			BIGINT,
	YOUTUBE_VIEWS				BIGINT,
    YOUTUBE_LIKES				BIGINT,
	TIKTOK_POST					BIGINT,
    TIKTOK_LIKES				BIGINT,
    TIKTOK_VIEWS				BIGINT,
    YOUTUBE_PLAYLIST_REACH		BIGINT,
	APPLE_PLAYLIST_COUNT		BIGINT,
    AIRPLAY_SPINS				BIGINT,
    SIRIUSXM_SPINS				BIGINT,
    DEEZER_PLAYLIST_COUNT		BIGINT,
    DEEZER_PLAYLIST_REACH		BIGINT,
    AMAZON_PLAYLIST_COUNT		BIGINT,
    PANDORA_STREAMS				BIGINT,
    PANDORA_TRACK_STATIONS		BIGINT,
    SOUNDCLOUD_STREAMS			BIGINT,
    SHAZAM_COUNTS				BIGINT,
    Explicit_Track				BIGINT
) CHARACTER SET utf8mb4;

--- Cargo los datos del dataset a la tabla temporal
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Most Streamed Songs 2024.csv'
INTO TABLE temp_canciones
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


--- Paso las columnas de la tabla temporal a las tablas correspondientes
INSERT INTO canciones (ID,SONG,ALBUM,ARTIST,RELEASE_DATE,ALL_TIME_RANK,SCORE,EXPLICIT)
SELECT ID, SONG, ALBUM, ARTIST, RELEASE_DATE, ALL_TIME_RANK, Track_Score, Explicit_Track
FROM temp_canciones;

SELECT * FROM canciones;