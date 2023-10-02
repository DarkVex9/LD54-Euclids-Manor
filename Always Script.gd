extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#Pausing
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			get_tree().paused = false
			get_parent().get_node("Pause Menu").visible = false
			get_parent().get_node("Rooms/Room1/StartText").visible = true
			
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			get_tree().paused = true
			get_parent().get_node("Pause Menu").visible = true
			get_parent().get_node("Rooms/Room1/StartText").visible = false
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			Input.warp_mouse(Vector2(DisplayServer.window_get_size().x/2,DisplayServer.window_get_size().y*0.6))
