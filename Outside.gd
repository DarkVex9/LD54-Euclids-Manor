extends DirectionalLight3D

var env

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	env = preload("res://assets/Environment.tres")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enter_outside_body_entered(body):
	if not body.name == "Player":
		return
	get_parent().get_node("WorldEnvironment").environment = env
	visible = true


func _on_exit_outide_body_entered(body):
	if not body.name == "Player":
		return
	get_parent().get_node("WorldEnvironment").environment = null
	visible = false
