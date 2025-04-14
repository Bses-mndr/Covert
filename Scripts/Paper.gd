extends StaticBody3D

var toggle = false
var paper_view
var info_text
var note
var orb
var pickup_audio

var database:SQLite

func _ready() -> void:
	paper_view = get_node("/root/"+get_tree().current_scene.name+"/UI/Paper")
	info_text = get_node("/root/"+get_tree().current_scene.name+"/UI/Info")
	orb = get_node("/root/"+get_tree().current_scene.name+"/UI/Orbs")
	note = get_node("/root/"+get_tree().current_scene.name+"/UI/Note")
	paper_view.visible = toggle
	
	database = get_node("/root/"+get_tree().current_scene.name+"/World_Settings/Level_manager").database
	
func interact():
	
	var inst = database.select_rows("Instructions", "name = '" + name + "'", ["*"])
	var image = Image.new()
	image.load_jpg_from_buffer(inst[0].image)
	var texture = ImageTexture.create_from_image(image)
	note.text = inst[0].desc
	
	
	pickup_audio = get_node("/root/" + get_tree().current_scene.name + "/Player/pickup_audio")
	toggle = !toggle
	paper_view.texture = texture
	paper_view.visible = toggle
	orb.visible = !orb.visible
	note.visible = toggle
	pickup_audio.play()
	if toggle == true:
		info_text.text = "You found a CLUE!"
	get_node("/root/" + get_tree().current_scene.name + "/Player").movable = !toggle
	get_node("/root/" + get_tree().current_scene.name + "/Player/Head").movable = !toggle
