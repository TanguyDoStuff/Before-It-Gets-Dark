extends Control

func _ready() -> void:
	match DisplayServer.window_get_mode():
		0, 1, 2:
			$Panel/VBoxContainer/ScreenThingy.select(0)
		3, 4:
			$Panel/VBoxContainer/ScreenThingy.select(1)
			
	match TranslationServer.get_locale():
		"en", "en_AG", "en_AU", "en_BW", "en_CA", "en_DK", "en_GB", "en_HK", "en_IE", "en_IL", "en_IN", "en_NG", "en_NZ", "en_PH", "en_SG", "en_US", "en_ZA", "en_ZM", "en_ZW":
			$Panel/VBoxContainer/Language.select(0)
		"fr", "fr_FR", "fr_BE", "fr_CA", "fr_CH", "fr_LU":
			$Panel/VBoxContainer/Language.select(1)

func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)


func _on_button_pressed() -> void:
	get_tree().set_pause(false)
	set_visible(false)


func _on_screen_thingy_item_selected(index: int) -> void:
	match index:
		0: #Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1: #Fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2: #Exclusive fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)


func _on_language_item_selected(index: int) -> void:
	match index:
		0: #English
			TranslationServer.set_locale("en")
		1: #French
			TranslationServer.set_locale("fr")
