class_name Player

extends CharacterBody2D


const GRAVITY: int = 1100
const HORIZONTAL_MAX_SPEED: int = 100
const ACCELERATION: int = 1000
const JUMP_SPEED: int = 280
const JUMP_TERMINATION_MULTIPLIER: float = 1.5


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	pass
	

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	
	var input_axis: float = Input.get_axis("move_left", "move_right")
	
	handle_movement(input_axis, delta)
	handle_jump(delta)
	
	move_and_slide()
	
	update_animation(input_axis)
	GameEvent.player_position_change.emit(global_position)


func apply_gravity(delta: float) -> void:
	velocity.y += GRAVITY * delta


func handle_movement(input_axis: float, delta: float) -> void:
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, input_axis * HORIZONTAL_MAX_SPEED, ACCELERATION * delta)
	else:
		velocity.x = lerp(0.0, velocity.x, pow(2, -50 * delta)) # framerate independent lerp


func handle_jump(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_SPEED * -1
	
	if velocity.y < 0 and !Input.is_action_pressed("jump"):
		velocity.y += GRAVITY * JUMP_TERMINATION_MULTIPLIER * delta


func update_animation(input_axis: float) -> void:
	if input_axis != 0:
		animated_sprite_2d.play("run")
		animated_sprite_2d.flip_h = true if input_axis < 0 else false
	else:
		animated_sprite_2d.play("idle")
	
	if !is_on_floor():
		animated_sprite_2d.play("jump")
