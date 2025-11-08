extends Control

@onready var minimap_viewport: SubViewport = $MinimapContainer/MinimapSubview
@onready var minimap_camera: Camera2D = $MinimapContainer/MinimapSubview/MinimapCamera

var player: Node2D

# Need to adjust the documentation with the proper references
# https://docs.godotengine.org/en/stable/classes/class_subviewportcontainer.html
# https://docs.godotengine.org/en/stable/classes/class_subviewport.html
# https://www.youtube.com/watch?v=bcAEgXJYZtU
func _ready() -> void:
	minimap_viewport.world_2d = get_tree().root.world_2d
	
	await get_tree().process_frame

	player = get_tree().get_first_node_in_group("player")
	
	if not player:
		var parent = get_tree().current_scene
		player = parent.get_node_or_null("Player")

func _physics_process(delta: float) -> void:
	if player and minimap_camera:
		minimap_camera.position = player.position
