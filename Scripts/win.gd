extends Control

func _process(delta: float) -> void:
	await get_tree().create_timer(5,false).timeout
	get_tree().change_scene_to_file("res://Scenes/Main_menu.tscn")
