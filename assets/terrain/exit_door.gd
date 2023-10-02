extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_unlock_exit_body_entered(body):
	if not body.name == "Player":
		return
	position.y = -2.2


func _on_unlock_exit_body_exited(body):
	if not body.name == "Player":
		return
	position.y = -10
