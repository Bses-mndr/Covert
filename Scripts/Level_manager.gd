extends Node

var player
@export var monster: CharacterBody3D

func _ready():
	get_node("/root/"+ get_tree().current_scene.name+"/Player/Head/Camera3D").current = true
	player = get_node("/root/"+ get_tree().current_scene.name+"/Player")
	await get_tree().create_timer(4,false).timeout
	monster.spawn()

func _process(delta: float) -> void:
	get_tree().call_group("Monster","update_target_location",player.global_transform.origin)
