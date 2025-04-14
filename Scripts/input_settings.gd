extends Control

@onready var input_button_scene = preload("res://SceneObjects/input_map.tscn")
@onready var action_list = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/ActionList

var is_remapping = false
var action_to_remap = null
var remapping_button = null

var action_to_events = {
	"Forward" : "forward",
	"Backward" : "backward",
	"Left" : "left",
	"Right" : "right",
	"Sprint" : "sprint",
	"Interact" : "interact",
	"Flashlight" : "flashlight"
}

func _ready() -> void:
	create_action_list()

func create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	
	for action in action_to_events:
		var button = input_button_scene.instantiate()
		var actionLabel = button.find_child("Action")
		var InputLabel = button.find_child("KeyInput")
		
		actionLabel.text = action
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			InputLabel.text = events[0].as_text().trim_suffix("(Physical)")
		else:
			InputLabel.text = ""
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button,action))

func _on_input_button_pressed(button,action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("KeyInput").text = "Press Key to bind..."

func _input(event: InputEvent) -> void:
	if is_remapping:
		if event is InputEventKey && event.pressed:
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap,event)
			_update_action_list(remapping_button,event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			accept_event()

func _update_action_list(button,event):
	button.find_child("KeyInput").text = event.as_text().trim_suffix("(Physical)")
