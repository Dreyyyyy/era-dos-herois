extends CharacterBody2D

@onready var attack_area := $AttackArea
var move_speed = 150.0
var player_in_range = false
var can_attack = true
var attack_cooldown = 1.0
var facing_right = true
var stop_distance = 12.0

func _physics_process(delta):
	if player_in_range:
		follow_player(delta)

	if player_in_range and can_attack:
		velocity.x = 0
		perform_attack()

	var player = get_node_or_null("../Player")
	if player:
		update_facing(player.global_position)

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true
		print("Player in range")

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
		print("Player left range")

func perform_attack():
	print("Attacking player")
	can_attack = false
	attack_area.monitoring = true
	attack_area.visible = true

	await get_tree().create_timer(0.30).timeout
	attack_area.monitoring = false
	attack_area.visible = false

	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true
	
func follow_player(delta):
	var player = get_node("../Player")
	if not player:
		return

	var distance = player.global_position.x - global_position.x

	if abs(distance) > stop_distance:
		velocity.x = move_speed * sign(distance)
	else:
		velocity.x = 0 

	move_and_slide()

func update_facing(player_pos: Vector2):
	var dx = player_pos.x - global_position.x

	if dx > 5:
		facing_right = true
	elif dx < -5:
		facing_right = false

	attack_area.position.x = 60 * (1 if facing_right else -1)
