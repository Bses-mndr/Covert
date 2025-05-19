extends Button

func _ready() -> void:
	self.mouse_entered.connect(btnenter.bind())
	self.mouse_entered.connect(btnexit.bind())

func btnenter():
	self.add_theme_color_override("font_hover_color",Color(0.64, 0.064, 0.064))

func btnexit():
	self.get_theme_color("font_color")
