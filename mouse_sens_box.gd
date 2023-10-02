extends SpinBox


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#	
#	else:
#		sensitivity = config.get_value("Controls","mouse_sensitivity")
#		joypad_sensitivity = config.get_value("Controls","joypad_sensitivity")

func _on_value_changed(value):
#	var config = ConfigFile.new()
#	# Load data from a file.
#	var err = config.load("user://settings.cfg")
#	# If the file didn't load, ignore it.
#	if err != OK:
#		return
#	config.set_value("Controls","mouse_sensitivity",value/1000)
#	config.save("user://settings.cfg")
	get_node("/root/Main/Player/Player").sensitivity = value / 1000


func _on_controller_sens_box_value_changed(value):
	get_node("/root/Main/Player/Player").joypad_sensitivity = value / 100
