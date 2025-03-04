extends Area3D

@export var audio_feedback: AudioStream
var scare_sound

func _ready() -> void:
	scare_sound = get_node("/root/" + get_tree().current_scene.name + "/Audio/scare_sound")

func trigger_entered(body):
	scare_sound.stream = audio_feedback
	if body == get_node("/root/" + get_tree().current_scene.name + "/Player"):
		scare_sound.play()
		set_deferred("monitoring",false)
