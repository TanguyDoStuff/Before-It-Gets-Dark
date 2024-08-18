extends Node2D

var isMusicIntroFinished = false
var preloadedMusic = load("res://assets/music/title_loop.mp3")

func _on_music_finished() -> void:
	if !isMusicIntroFinished:
		$Music.stream = preloadedMusic
		$Music.play(0)
		isMusicIntroFinished = true


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_settings_button_pressed() -> void:
	$Settings.set_visible(true)
