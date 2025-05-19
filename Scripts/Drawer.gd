extends StaticBody3D

var interactable:bool = true
var is_open:bool = false
var partition 

@export var child:StaticBody3D

func _ready() -> void:
	
	partition = $Body/Handle_1/D_1
	child.reparent(partition,true)

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
