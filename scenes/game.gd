extends Node3D

var currentTuto = "move"

var isMusicIntroFinished = false
var preloadedMusic

const mapList = ["valley", "area2", "cave", "mountaintop", "ending"]
var mapLoading

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Flags.setFlags()
	$Transition/AnimationPlayer.play("EndTransition")
	$Overlay.play()

func _process(_delta: float) -> void:
	# Tutorial stuff
	if currentTuto == "move" and (Input.is_action_just_pressed("move_down") or Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")):
		$TutorialText.set_text("tutorial_camera")
		currentTuto = "camera"
	elif currentTuto == "camera" and (Input.is_action_just_pressed("camera_down") or Input.is_action_just_pressed("camera_up") or Input.is_action_just_pressed("camera_left") or Input.is_action_just_pressed("camera_right")):
		$TutorialText.set_text("tutorial_jump")
		currentTuto = "jump"
	elif currentTuto == "jump" and Input.is_action_just_pressed("move_jump"):
		currentTuto = "done"
		$TutorialText.set_visible(false)
	

func playMusic(audio):
	isMusicIntroFinished = false
	preloadedMusic = load(String("res://assets/music/" + audio + "_loop.mp3"))
	var path = String("res://assets/music/" + audio + "_intro.mp3") #Génère le path
	
	#Check si l'audio existe
	if ResourceLoader.exists(path):
		$Music.stream = load(path)
		$Music.play(0)
	else:
		push_error(String("Unknown Music: " + path))

func _on_music_finished() -> void:
	if !isMusicIntroFinished:
		$Music.stream = preloadedMusic
		$Music.play(0)
		isMusicIntroFinished = true

func loadMap(map):
	match map:
		mapList[0]:
			mapLoading = preload("res://scenes/map/valley.tscn")
		mapList[1]:
			mapLoading = preload("res://scenes/map/area2.tscn")
		mapList[2]:
			mapLoading = preload("res://scenes/map/cave.tscn")
		mapList[3]:
			mapLoading = preload("res://scenes/map/mountaintop.tscn")
		mapList[4]:
			mapLoading = preload("res://scenes/preending.tscn")
			
	$Transition/AnimationPlayer.play("StartTransition")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "StartTransition":
		get_child(5).queue_free() #Remove the map ($Map doesn't work idk why)
		add_child(mapLoading.instantiate())
		$Transition/AnimationPlayer.play("EndTransition")
