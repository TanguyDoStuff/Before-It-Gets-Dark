extends Node

var cutsceneCatisseriePlayed: bool
var cutsceneNerdyPlayed: bool
var cutsceneDuckPlayed: bool
var cutsceneDuckKeyPlayed: bool
var cutsceneErmit1Played: bool
var cutsceneErmit2Played: bool
var cutsceneWitchPlayed: bool

var playerGotKey: bool

func setFlags():
	cutsceneCatisseriePlayed = false
	cutsceneNerdyPlayed = false
	cutsceneDuckPlayed = false
	cutsceneDuckKeyPlayed = false
	cutsceneErmit1Played = false
	cutsceneErmit2Played = false
	cutsceneWitchPlayed = false

	playerGotKey = false
