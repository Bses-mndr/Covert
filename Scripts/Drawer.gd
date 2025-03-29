extends StaticBody3D

var interactable:bool = true
var is_open:bool = false
func interact():
	if interactable:
		interactable = false
		if is_open:
			is_open = false
			$AnimationPlayer.play("close")
		else:
			is_open = true
			$AnimationPlayer.play("open")
		$AudioStreamPlayer3D.play()
		await get_tree().create_timer(.5,false).timeout
		interactable = true
