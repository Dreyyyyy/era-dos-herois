extends Control

@onready var minimap_viewport: SubViewport = $MinimapContainer/MinimapSubview
@onready var minimap_camera: Camera2D = $MinimapContainer/MinimapSubview/Camera2D

var player: Node2D

# Need to adjust the documentation with the proper references
# https://docs.godotengine.org/en/stable/classes/class_subviewportcontainer.html
# https://www.youtube.com/watch?v=bcAEgXJYZtU
func _ready() -> void:
	minimap_viewport.world_2d = get_tree().root.world_2d
	
	player = get_tree().get_first_node_in_group("player")
	if not player:
		var parent = get_tree().current_scene
		player = parent.get_node_or_null("Player")

func _physics_process(delta: float) -> void:
	if player and minimap_camera:
		minimap_camera.global_position = player.global_position
