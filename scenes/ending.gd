extends Node2D

var isMusicIntroFinished = false
var preloadedMusic = load("res://assets/music/sunsets_loop.mp3")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Darkness.get_position().y >= 0:
		$Darkness.set_position($Darkness.get_position() + Vector2(0, -1.45 * delta))
		$FrontDarkness.set_position($FrontDarkness.get_position() + Vector2(0, -0.95 * delta))
	if $Sun.get_position().y <= 93:
		$Sun.set_position($Sun.get_position() + Vector2(0, 0.5 * delta))
	if $Credits/Text.get_position().x >= -984:
		$Credits/Text.set_position($Credits/Text.get_position() + Vector2(-15 * delta, 0))


func _on_music_finished() -> void:
	if !isMusicIntroFinished:
		$Music.stream = preloadedMusic
		$Music.play(0)
		isMusicIntroFinished = true
