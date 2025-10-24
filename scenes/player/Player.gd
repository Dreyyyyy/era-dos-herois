extends CharacterBody2D

@export var speed: float = 200.0
@export var gravity: float = 1000.0
@export var jump_force: float = -400.0
@export var run_multiplier: float = 2.0

func get_input() -> Vector2:
	var input_direction: Vector2 = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	return input_direction

func _physics_process(delta: float) -> void:
	var input_direction = get_input()
	var current_speed = speed
	
	if Input.is_action_pressed("player_run"):
		current_speed *= run_multiplier
	
	velocity.x = input_direction.x * current_speed
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor() and Input.is_action_just_pressed("player_jump"):
		velocity.y = jump_force

	move_and_slide()
