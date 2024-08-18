extends Node3D

var isFadeingOutMusic = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().playMusic("almost_there")
	
func _process(delta: float) -> void:
		$Environment/Darkness.set_position($Environment/Darkness.get_position() + Vector3(0, 0.0003, 0))
		if isFadeingOutMusic:
			fadeOutMusic(delta)

func fadeOutMusic(delta):
	get_parent().get_node("Music").set_volume_db(get_parent().get_node("Music").get_volume_db() - (5 * delta))
