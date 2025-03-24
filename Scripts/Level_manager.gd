extends Node

@export var bg_music: AudioStream
@export var monster: CharacterBody3D
@export var default_text = "Exploring..."
var player
var bgm
var info_text

func _ready():
	get_node("/root/"+ get_tree().current_scene.name+"/Player/Head/Camera3D").set_current(true)
	get_node("/root/"+get_tree().current_scene.name+"/NavigationRegion3D/level_1/Ceiling").visible = true
	get_node("/root/"+get_tree().current_scene.name+"/NavigationRegion3D/level_1/Level Barriers").visible = true

	player = get_node("/root/"+ get_tree().current_scene.name+"/Player")
	bgm = get_node("/root/"+get_tree().current_scene.name+"/Audio/bg_audio")
	info_text = get_node("/root/"+get_tree().current_scene.name+"/UI/Info")
	
	
	info_text.text = default_text
	bgm.stream = bg_music
	bgm.play()
	monster.spawn()
	
func _process(delta: float) -> void:
	if info_text.text != default_text: #Looping / Clearing Info_Text to Default.
		await get_tree().create_timer(2,false).timeout
		info_text.text = default_text 
