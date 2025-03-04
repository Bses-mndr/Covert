extends Node

@export var bg_music: AudioStream
var info_text
var default_text = "Exploring..."

func _ready() -> void:
	
	$NavigationRegion3D/Terrain.use_collision = true
	$Audio/bg_audio.stream = bg_music
	$Audio/bg_audio.play()
	info_text = get_node("/root/"+get_tree().current_scene.name+"/UI/Info")
	info_text.text = default_text

func _process(delta: float) -> void:
	if info_text.text != default_text:
		await get_tree().create_timer(2,false).timeout
		info_text.text = default_text 
