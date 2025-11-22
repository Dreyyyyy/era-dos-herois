extends CharacterBody2D

# https://www.youtube.com/watch?v=9u59U-DWNJs
func _on_detection_area_body_entered(body: Node2D) -> void:
	print("Player has entered the area");


func _on_detection_area_body_exited(body: Node2D) -> void:
	print("Player has exited the area");
