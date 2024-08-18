extends Node2D

@onready var Music = get_parent().get_parent().get_parent().get_node("Music")
@onready var Darkness = get_parent().get_parent().get_node("Environment/Darkness")

var timesNerdyPlayed = 0
var blackAnnouncementPlayed = false
var wtfSoundPitch: float
var isWTFingTheSound = false

func _ready() -> void:
	set_visible(false)

func _process(_delta: float) -> void:
	if !Global.chess_playerTurn:
		match timesNerdyPlayed:
			0,1,2,3,4:
				$NerdPiece.set_position(Vector2(150, 153))
				Global.chess_playerTurn = true
				timesNerdyPlayed += 1
		match timesNerdyPlayed:
			1:
				turnAnnouncement(load("res://assets/chess/Turn/BlackTurn.png"))
			2:
				turnAnnouncement(load("res://assets/chess/Turn/WhiteTurn1.png"))
				wtfSoundPitch = 0.95
				isWTFingTheSound = true
			3:
				turnAnnouncement(load("res://assets/chess/Turn/WhiteTurn2.png"))
				wtfSoundPitch = 0.90
				isWTFingTheSound = true
			4:
				turnAnnouncement(load("res://assets/chess/Turn/WhiteTurn3.png"))
				wtfSoundPitch = 0.01
				isWTFingTheSound = true
			5:
				endGame()
				
	if isWTFingTheSound:
		wtfTheSound()

func turnAnnouncement(texture):
	$TurnAnnouncement.set_texture(texture)
	$TurnAnnouncement.set_visible(true)
	$SoundEffect.play(0)
	
func _on_sound_effect_finished() -> void:
	if timesNerdyPlayed == 1 and !blackAnnouncementPlayed:
		blackAnnouncementPlayed = true
		turnAnnouncement(load("res://assets/chess/Turn/WhiteTurn1.png"))
	else:
		$TurnAnnouncement.set_visible(false)

func startGame():
	Global.chess_isPlaying = true
	Global.chess_playerTurn = true
	set_visible(true)
	turnAnnouncement(load("res://assets/chess/Turn/WhiteTurn1.png"))
	
func endGame():
	Global.chess_isPlaying = false
	Darkness.set_position(Vector3(0, 20, 0))
	set_visible(false)
	get_parent().get_parent().get_node("Player/Cutscene").startCutscene("cutscene_nerdy_postchess_1", "Nerdy")
	Music.stop()
	queue_free()

func wtfTheSound():
	if Music.get_pitch_scale() >= wtfSoundPitch:
		Music.set_pitch_scale(Music.get_pitch_scale() - 0.001)
	else:
		isWTFingTheSound = false
