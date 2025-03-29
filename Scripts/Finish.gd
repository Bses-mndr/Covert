extends Area3D

var score

func _ready() -> void:
	score = get_node("/root/"+get_tree().current_scene.name+"/World_Settings/Level_manager").score

func _on_body_entered(body: CharacterBody3D) -> void:
	if score == 4:
		print("End Reached!")
	else:
		print("Collect More Orbs")
