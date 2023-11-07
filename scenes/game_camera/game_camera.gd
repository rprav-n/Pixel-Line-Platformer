class_name GameCamera

extends Camera2D

const SPEED: int = 400


func _ready() -> void:
	GameEvent.player_position_change.connect(_on_player_position_change)


func _on_player_position_change(player_position: Vector2) -> void:
	global_position = lerp(player_position, global_position, 
		pow(2, -15 * get_physics_process_delta_time()))
