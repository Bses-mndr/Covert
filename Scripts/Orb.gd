extends Area3D

var score

func _on_body_entered(body: Node3D) -> void:
	
	score = get_node("/root/"+get_tree().current_scene.name+"/World_Settings/Level_manager").score
	score += 1
	get_node("/root/"+get_tree().current_scene.name+"/World_Settings/Level_manager").score = score
	
	print(score)
	queue_free()
