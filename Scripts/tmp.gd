extends Button

var database:SQLite
var uid

func _ready() -> void:
	database = SQLite.new()
	database.path = "res://data.db"
	database.open_db()
	uid = "Monster1"

func _on_pressed() -> void:
	print(uid.trim_prefix("Monster"))
	var m_id:int = 3
	var coor:Array[Array]
	var i = 0 
	var destinations = database.select_rows("Destinations","m_id = '"+str(m_id)+"'",["x","y","z"])
	for d in destinations:
		coor.append(d.values())
	print(coor)
	var x = coor[0][0]
	var y = coor[0][1]
	var z = coor[0][2]
	print(Vector3(x,y,z))
