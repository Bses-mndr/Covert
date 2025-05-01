extends Node

@export var bg_music: AudioStream
@export var monster: CharacterBody3D
@export var default_text = "Exploring..."
@export var devmode = false  
var env
var player
var bgm
var info_text
var score

var database:SQLite

var old_time:int
var stopwatch = 0.0
var stopped = false

func _ready():
	
	database = SQLite.new()
	database.path = "res://data.db"
	database.open_db()
	
	var qry = database.select_rows("Players","",["time"])
	for q in qry:
		old_time = q.values()[0]
	
	env = get_node("/root/"+get_tree().current_scene.name+"/World_Settings/WorldEnvironment")
	if devmode:
		$"../Camera3D".set_current(true)
	else:
		get_node("/root/"+ get_tree().current_scene.name+"/Player/Head/Camera3D").set_current(true)
		env.environment.background_energy_multiplier = 1.5
		get_node("/root/"+get_tree().current_scene.name+"/NavigationRegion3D/Level_1/Ceiling").visible = true
		get_node("/root/"+get_tree().current_scene.name+"/NavigationRegion3D/Level_1/Level Barriers").visible = true
	

	env.environment.fog_enabled = true
	env.environment.volumetric_fog_enabled = true
	player = get_node("/root/"+ get_tree().current_scene.name+"/Player")
	bgm = get_node("/root/"+get_tree().current_scene.name+"/Audio/bg_audio")
	info_text = get_node("/root/"+get_tree().current_scene.name+"/UI/Info")
	
	score = 0
	info_text.text = default_text
	bgm.stream = bg_music
	bgm.play()
	
func _process(delta: float) -> void:
	
	if !stopped:
		stopwatch += delta 
	else:
		var time = int(stopwatch)+int(old_time)
		database.query("UPDATE Players SET time = " + str(time))
		stopped = true
	
	if info_text.text != default_text: #Looping / Clearing Info_Text to Default.
		await get_tree().create_timer(2,false).timeout
		info_text.text = default_text
