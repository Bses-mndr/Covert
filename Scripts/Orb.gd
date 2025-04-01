extends Area3D

var score
var orb

func _ready() -> void:
	orb = get_node("/root/"+get_tree().current_scene.name+"/UI/Orbs")

func _on_body_entered(body: Node3D) -> void:
	
	score = get_node("/root/"+get_tree().current_scene.name+"/World_Settings/Level_manager").score
	score += 1
	get_node("/root/"+get_tree().current_scene.name+"/World_Settings/Level_manager").score = score
	
	orb.text = "Orbs : " + str(score)
	queue_free()
