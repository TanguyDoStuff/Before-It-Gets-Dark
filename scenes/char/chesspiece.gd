extends Node2D

@export var pieceType: String

var selected = false
var mouse_offset = Vector2(0,0)


func _ready() -> void:
	#Change chess sprite
	match pieceType:
		"King":
			$Sprite.set_texture(load("res://assets/chess/pieces/wKing.png"))
		"Queen":
			$Sprite.set_texture(load("res://assets/chess/pieces/wQueen.png"))
		"Rook":
			$Sprite.set_texture(load("res://assets/chess/pieces/wRook.png"))
		"Bishop":
			$Sprite.set_texture(load("res://assets/chess/pieces/wBishop.png"))
		"Knight":
			$Sprite.set_texture(load("res://assets/chess/pieces/wKnight.png"))
		"Pawn":
			$Sprite.set_texture(load("res://assets/chess/pieces/wPawn.png"))
		_:
			push_error(String("Unknown chess piece: " + pieceType))

func _process(_delta: float) -> void:
	if selected:
		followMouse()
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and selected == true:
		selected = false
		
		
func followMouse():
	position = get_global_mouse_position() + mouse_offset


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if Global.chess_playerTurn:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				mouse_offset = position - get_global_mouse_position()
				selected = true
			else:
				selected = false
				Global.chess_playerTurn = false


func _on_area_2d_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
