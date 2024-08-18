extends Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Spin block
	$Environment/Block3.set_rotation($Environment/Block3.get_rotation() + Vector3(0, delta, 0))
	$Environment/Block3Collision.set_rotation($Environment/Block3Collision.get_rotation() + Vector3(0, delta, 0))
	
	$Environment/Block6.set_rotation($Environment/Block6.get_rotation() + Vector3(0, 1, 1))
	$Environment/Block6Collision.set_rotation($Environment/Block6Collision.get_rotation() + Vector3(0, 1, 1))
	
	$Environment/Darkness.set_position($Environment/Darkness.get_position() + Vector3(0, 0.0001, 0))
