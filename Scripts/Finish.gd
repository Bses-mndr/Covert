extends Area3D

var score
var info

func _ready() -> void:
	score = get_node("/root/"+get_tree().current_scene.name+"/World_Settings/Level_manager").score
	info = get_node("/root/"+get_tree().current_scene.name+"/UI/Info")

func _on_body_entered(body: CharacterBody3D) -> void:
	score = get_node("/root/"+get_tree().current_scene.name+"/World_Settings/Level_manager").score
	if score == 4:
		get_node("/root/"+get_tree().current_scene.name+"/World_Settings/Level_manager").stopped = true
		get_tree().change_scene_to_file("res://Scenes/Win.tscn")
	else:
		info.text = "Collect more Orbs!"
