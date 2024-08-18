extends CharacterBody3D

@onready var Game = get_parent().get_parent()
@onready var Map = get_parent()

const SPEED = 2.0
const JUMP_VELOCITY = 3.0
const CAMERA_SPEED = 0.02

var gravityOn = true

func _physics_process(delta: float) -> void:
	if !Global.isCutscenePlaying:
		movements(delta)
	else:
		set_velocity(Vector3(0, 0, 0)) #Prevent moving while in cutscene
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_pause"):
		Game.get_node("Settings").set_visible(true)
		get_tree().set_pause(true)

func movements(delta):
	# GRAIVTY
	if not is_on_floor() and gravityOn:
		velocity += get_gravity() * delta
	
	# JUMP
	if Input.is_action_just_pressed("move_jump") and (is_on_floor() or !gravityOn):
		velocity.y = JUMP_VELOCITY
	
	# MOVEMENTS
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	# CAMERA
	if Input.is_action_pressed("camera_left"):
		rotation.y = rotation.y + CAMERA_SPEED
	if Input.is_action_pressed("camera_right"):
		rotation.y = rotation.y - CAMERA_SPEED
	if Input.is_action_pressed("camera_up") and $Camera.rotation.x < 1:
		$Camera.rotation.x = $Camera.rotation.x + CAMERA_SPEED
	if Input.is_action_pressed("camera_down") and $Camera.rotation.x > -1:
		$Camera.rotation.x = $Camera.rotation.x - CAMERA_SPEED

#Auto cutscene
func _on_interaction_area_area_entered(area: Area3D) -> void:
	# Auto cutscenes
	if area.is_in_group("cutscene_catisserie_1") and !Flags.cutsceneCatisseriePlayed:
		$Cutscene.startCutscene("cutscene_catisserie_1", "Catisserie")
	if area.is_in_group("cutscene_nerdy_1") and !Flags.cutsceneNerdyPlayed:
		$Cutscene.startCutscene("cutscene_nerdy_1", "Nerdy")
	if area.is_in_group("cutscene_duck_1") and !Flags.cutsceneDuckPlayed and !Flags.playerGotKey:
		$Cutscene.startCutscene("cutscene_duck_1", "Duck")
	if area.is_in_group("cutscene_duck_1") and Flags.playerGotKey and !Flags.cutsceneDuckKeyPlayed:
		$Cutscene.startCutscene("cutscene_duck_postkey_1", "Duck")
	if area.is_in_group("cutscene_ermit_1") and !Flags.cutsceneErmit1Played:
		$Cutscene.startCutscene("cutscene_ermit1_1", "Ermit")
	if area.is_in_group("cutscene_ermit_2") and !Flags.cutsceneErmit2Played:
		$Cutscene.startCutscene("cutscene_ermit2_1", "Ermit")
	if area.is_in_group("cutscene_light_transition"):
		$Cutscene.startCutscene("cutscene_light_transition", "Ermit")
	if area.is_in_group("cutscene_witch_1") and !Flags.cutsceneWitchPlayed:
		$Cutscene.startCutscene("cutscene_witch_1", "Witch")
			
	# Map transition
	if area.is_in_group("transition_area2"):
		Game.loadMap("area2")
	if area.is_in_group("cutscene_door_transition") and Flags.playerGotKey:
		$Cutscene.startCutscene("cutscene_door_transition", "Door")
		
	if area.is_in_group("end_cutscene"):
		$Cutscene.startCutscene("cutscene_end_1", "Witch")
		
	# Objects
	if area.is_in_group("rope"):
		gravityOn = false
	if area.is_in_group("jump_fall"):
		set_position(Vector3(13.472, 36.175, -6.465))
	if area.is_in_group("item_key"):
		Flags.playerGotKey = true
		Map.get_node("KeyArea").queue_free()
		Map.get_node("Environment/Darkness").set_position(Vector3(0, 25, 0))
		Map.get_node("Nerdy").set_modulate(Color(0, 0, 0)) #Corrupt Nerdy
		Map.get_node("Environment/EndOfTheWorldCollision").call_deferred("set_disabled", false)


func _on_interaction_area_area_exited(area: Area3D) -> void:
	# Objects
	if area.is_in_group("rope"):
		gravityOn = true
