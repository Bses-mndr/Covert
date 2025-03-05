extends StaticBody3D

var interactable = true
var opened = false
var info_text

func _ready() -> void:
	info_text = get_node("/root/"+get_tree().current_scene.name+"/UI/Info")

func interact():
	
	if interactable && get_parent().key == null:
		interactable = false
		if opened == false:
			#print("opening")
			opened = true
			$AnimationPlayer.play("open")
		else:
			#print("closing")
			opened = false
			$AnimationPlayer.play("close")
		$open_close.play()
		await get_tree().create_timer(1,false).timeout
		interactable = true
	elif interactable:
		info_text.text = "LOCKED! You don't have key to this door."
		interactable = false
		$locked.play()
		$AnimationPlayer.play("locked")
		await get_tree().create_timer(.4,false).timeout
		interactable = true

func enemy_interact():
	
	if interactable && get_parent().key == null:
		interactable = false
		if opened == false:
			opened = true
			$AnimationPlayer.play("open")
		else:
			opened = false
			$AnimationPlayer.play("close")
		$open_close.play()
		await get_tree().create_timer(1,false).timeout
		interactable = true
