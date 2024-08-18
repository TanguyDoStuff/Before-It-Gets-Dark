extends AnimatedSprite2D

@onready var Game = get_parent().get_parent().get_parent()
@onready var Map = get_parent().get_parent()

var currentCutscene: String #Current Cutscene
var NPC: Node #Current NPC


func _ready() -> void:
	set_visible(false)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and Global.isCutscenePlaying and !Global.chess_isPlaying:
		nextCutscene()

func startCutscene(cutsceneName, npc):
	currentCutscene = cutsceneName
	NPC = get_parent().get_parent().get_node(npc)
	
	Global.isCutscenePlaying = true
	NPC.set_modulate(Color(0, 0, 0, 0)) #Set NPC invisible
	set_visible(true) #Display cutscene
	
	match currentCutscene:
		"cutscene_catisserie_1":
			play("catisserie_stand")
			playAudio("Catisserie/dialogue_catisserie_1.wav")
			
		"cutscene_nerdy_1":
			play("nerdy_talk")
			playAudio("Nerdy/dialogue_nerdy_1.wav")
			
		"cutscene_nerdy_postchess_1":
			$Subtitles.set_visible(true)
			Game.get_node("Overlay").set_visible(true)
			Game.get_node("Transition").set_visible(true)
			play("nerdy_stare")
			playAudio("Nerdy/dialogue_nerdy_postchess_1.wav")
			
		"cutscene_duck_1":
			Flags.cutsceneDuckPlayed = true
			Game.get_node("Music").set_pitch_scale(1)
			Game.playMusic("duck")
			play("player_happy")
			playAudio("Duck/dialogue_duck_1.wav")
		"cutscene_duck_postkey_1":
			play("duck_spin")
			playAudio("Duck/dialogue_duck_postkey_1.wav")
			
		"cutscene_door_transition":
			play("door_transition")
			playAudio("doortransition.wav")
			
		"cutscene_ermit1_1":
			play("ermit_talk")
			playAudio("Ermit/dialogue_ermit1_1.wav")
		"cutscene_ermit2_1":
			Flags.cutsceneErmit2Played = true
			play("ermit_talk")
			playAudio("Ermit/dialogue_ermit2_1.wav")
			
		"cutscene_light_transition":
			$Subtitles.set_visible(false)
			play("light_transition")
			playAudio("lighttransition.wav")
			
		"cutscene_witch_1":
			Flags.cutsceneWitchPlayed = true
			play("witch_stimming")
			playAudio("Witch/dialogue_witch_1.wav")
		
		"cutscene_end_1":
			Map.isFadeingOutMusic = true
			play("player_stare")
			playAudio("blank.wav")
			
		_:			
			push_error(String("Unknown cutscene: " + cutsceneName))
	
	$Subtitles.set_text(currentCutscene)

func playAudio(audio):
	var path = String("res://assets/dialogue/" + audio) #Génère le path
	
	#Check si l'audio existe
	if ResourceLoader.exists(path):
		$Audio.stream = load(path)
		$Audio.play(0)
	else:
		push_error(String("Unknown Audio: " + path))

func _on_audio_finished() -> void:
	if !Global.chess_isPlaying:
		nextCutscene()

func nextCutscene(): #Go to the next cutscene
	match currentCutscene:
		"cutscene_catisserie_1":
			Flags.cutsceneCatisseriePlayed = true
			currentCutscene = "cutscene_catisserie_2"
			play("player_talk")
			playAudio("Catisserie/dialogue_catisserie_2.wav")
		"cutscene_catisserie_2":
			currentCutscene = "cutscene_catisserie_3"
			play("catisserie_stand")
			playAudio("Catisserie/dialogue_catisserie_3.wav")
		"cutscene_catisserie_3":
			currentCutscene = "cutscene_catisserie_4"
			play("player_happy")
			playAudio("Catisserie/dialogue_catisserie_4.wav")
		"cutscene_catisserie_4":
			currentCutscene = "cutscene_catisserie_5"
			play("catisserie_stand")
			playAudio("Catisserie/dialogue_catisserie_5.wav")
		"cutscene_catisserie_5":
			endCutscene()
			
		"cutscene_nerdy_1":
			Flags.cutsceneNerdyPlayed = true
			currentCutscene = "cutscene_nerdy_2"
			play("player_happy")
			playAudio("Nerdy/dialogue_nerdy_2.wav")
		"cutscene_nerdy_2":
			currentCutscene = "cutscene_nerdy_3"
			play("nerdy_spin")
			playAudio("Nerdy/dialogue_nerdy_3.wav")
		"cutscene_nerdy_3":
			currentCutscene = "cutscene_nerdy_4"
			play("player_talk")
			playAudio("Nerdy/dialogue_nerdy_4.wav")
		"cutscene_nerdy_4":
			currentCutscene = "cutscene_nerdy_5"
			play("nerdy_talk")
			playAudio("Nerdy/dialogue_nerdy_5.wav")
		"cutscene_nerdy_5":
			currentCutscene = "cutscene_nerdy_6"
			play("player_what")
			playAudio("Nerdy/dialogue_nerdy_6.wav")
		"cutscene_nerdy_6":
			currentCutscene = "cutscene_nerdy_7"
			play("nerdy_spin")
			playAudio("Nerdy/dialogue_nerdy_7.wav")
		"cutscene_nerdy_7":
			currentCutscene = "cutscene_nerdy_8"
			play("player_what")
			playAudio("Nerdy/dialogue_nerdy_8.wav")
			Game.playMusic("the_rook")
		"cutscene_nerdy_8":
			NPC.get_node("ChessMinigame").startGame()
			$Subtitles.set_visible(false)
			Game.get_node("Overlay").set_visible(false)
			Game.get_node("Transition").set_visible(false)
			$Audio.stop()
		
		"cutscene_nerdy_postchess_1":
			currentCutscene = "cutscene_nerdy_postchess_2"
			play("player_stare")
			playAudio("blank.wav")
		"cutscene_nerdy_postchess_2":
			currentCutscene = "cutscene_nerdy_postchess_3"
			play("nerdy_stare")
			playAudio("blank.wav")
		"cutscene_nerdy_postchess_3":
			currentCutscene = "cutscene_nerdy_postchess_4"
			play("player_stare")
			playAudio("blank.wav")
		"cutscene_nerdy_postchess_4":
			currentCutscene = "cutscene_nerdy_postchess_5"
			play("nerdy_spin")
			playAudio("Nerdy/dialogue_nerdy_postchess_5.wav")
			Game.get_node("Music").set_pitch_scale(0.80)
			Game.playMusic("going_up")
		"cutscene_nerdy_postchess_5":
			Map.get_node("Environment/Rope").set_visible(true) #Add rope
			Map.get_node("Environment/EndOfTheWorldCollision2").call_deferred("set_disabled", false) #Add collision to prevent going back
			endCutscene()
			
		"cutscene_duck_1":
			currentCutscene = "cutscene_duck_2"
			play("duck_spin")
			playAudio("Duck/dialogue_duck_2.wav")
		"cutscene_duck_2":
			currentCutscene = "cutscene_duck_3"
			play("player_talk")
			playAudio("Duck/dialogue_duck_3.wav")
		"cutscene_duck_3":
			currentCutscene = "cutscene_duck_4"
			play("duck_spin")
			playAudio("Duck/dialogue_duck_4.wav")
		"cutscene_duck_4":
			currentCutscene = "cutscene_duck_5"
			play("player_talk")
			playAudio("Duck/dialogue_duck_5.wav")
		"cutscene_duck_5":
			endCutscene()
		
		"cutscene_duck_postkey_1":
			Flags.cutsceneDuckKeyPlayed = true
			currentCutscene = "cutscene_duck_postkey_2"
			play("explosion")
			playAudio("explosion.wav")
			Game.get_node("Music").stop()
		"cutscene_duck_postkey_2":
			endCutscene()
			NPC.set_visible(false) # RIP Ducky :(
			
		"cutscene_door_transition":
			endCutscene()
			Game.loadMap("cave")
			
		"cutscene_ermit1_1":
			currentCutscene = "cutscene_ermit1_2"
			play("player_talk")
			playAudio("Ermit/dialogue_ermit1_2.wav")
		"cutscene_ermit1_2":
			currentCutscene = "cutscene_ermit1_3"
			play("ermit_talk")
			playAudio("Ermit/dialogue_ermit1_3.wav")
		"cutscene_ermit1_3":
			currentCutscene = "cutscene_ermit1_4"
			play("ermit_talk")
			playAudio("Ermit/dialogue_ermit1_4.wav")
		"cutscene_ermit1_4":
			currentCutscene = "cutscene_ermit1_5"
			play("player_talk")
			playAudio("Ermit/dialogue_ermit1_5.wav")
		"cutscene_ermit1_5":
			currentCutscene = "cutscene_ermit1_6"
			play("ermit_talk")
			playAudio("Ermit/dialogue_ermit1_6.wav")
		"cutscene_ermit1_6":
			currentCutscene = "cutscene_ermit1_7"
			play("player_talk")
			playAudio("Ermit/dialogue_ermit1_7.wav")
		"cutscene_ermit1_7":
			currentCutscene = "cutscene_ermit1_8"
			play("ermit_talk")
			playAudio("Ermit/dialogue_ermit1_8.wav")
		"cutscene_ermit1_8":
			Flags.cutsceneErmit1Played = true
			Map.get_node("Environment/Darkness").set_position(Vector3(0, -8, 0))
			Map.get_node("Environment/EndOfTheWorldCollision1").call_deferred("set_disabled", false) #Add collision to prevent going back
			endCutscene()
			
		"cutscene_ermit2_1":
			Map.get_node("Environment/Darkness").set_position(Vector3(0, -3, 0))
			Map.get_node("Environment/EndOfTheWorldCollision2").call_deferred("set_disabled", false) #Add collision to prevent going back
			endCutscene()
			NPC.set_visible(false) # RIP Ermit :(
		
		"cutscene_light_transition":
			endCutscene()
			$Subtitles.set_visible(true)
			Game.loadMap("mountaintop")
			
		"cutscene_witch_1":
			currentCutscene = "cutscene_witch_2"
			play("witch_disappointed")
			playAudio("Witch/dialogue_witch_2.wav")
		"cutscene_witch_2":
			currentCutscene = "cutscene_witch_3"
			play("player_talk")
			playAudio("Witch/dialogue_witch_3.wav")
		"cutscene_witch_3":
			currentCutscene = "cutscene_witch_4"
			play("witch_looking")
			playAudio("Witch/dialogue_witch_4.wav")
		"cutscene_witch_4":
			currentCutscene = "cutscene_witch_5"
			play("witch_stimming")
			playAudio("Witch/dialogue_witch_5.wav")
		"cutscene_witch_5":
			currentCutscene = "cutscene_witch_6"
			play("explosion")
			playAudio("explosion.wav")
		"cutscene_witch_6":
			NPC.set_position(Vector3(-20.432, 19.292, -19.983))
			endCutscene()
			
		"cutscene_end_1":
			currentCutscene = "cutscene_end_2"
			play("witch_disappointed")
			playAudio("blank.wav")
		"cutscene_end_2":
			currentCutscene = "cutscene_end_3"
			play("player_talk")
			playAudio("Witch/dialogue_end.wav")
		"cutscene_end_3":
			Game.loadMap("ending")

		_:
			push_error(String("Unknown Cutscene: " + currentCutscene))
	
	$Subtitles.set_text(currentCutscene)
	
func endCutscene():
	$Audio.stop()
	NPC.set_modulate(Color(1, 1, 1, 1))
	set_visible(false)
	Global.isCutscenePlaying = false
