extends StaticBody3D

var is_open = false
var interactable = true

func interact():
	
	if interactable:
		interactable = false
		
		if is_open:
			is_open = false
			$"../../../AnimationPlayer".play("close")
		elif is_open == false:
			is_open = true
			$"../../../AnimationPlayer".play("open")
	
		$"../../../AudioStreamPlayer3D".play()
		await get_tree().create_timer(.5,false).timeout
		interactable = true
