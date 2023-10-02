extends CharacterBody3D

const SPEED = 3.5
const FRICTION = SPEED/6
const JUMP_VELOCITY = 4.5
var sensitivity = 0.002
var joypad_sensitivity = 0.055

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head = $Head
@onready var camera = $Head/Camera3D


func _ready():
#	var config = ConfigFile.new()
#	# Load data from a file.
#	var err = config.load("user://settings.cfg")
#	# If the file didn't load, ignore it.
#	if err != OK:
#		config.set_value("Controls","mouse_sensitivity",sensitivity)
#		config.set_value("Controls","joypad_sensitivity",joypad_sensitivity)
#		config.save("user://settings.cfg")
#	else:
#		sensitivity = config.get_value("Controls","mouse_sensitivity")
#		joypad_sensitivity = config.get_value("Controls","joypad_sensitivity")
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	connect("_on_mouse_sens_box_value_changed",set_sensitivity)
	connect("_on_controller_sens_box_value_changed",set_joypad_sensitivity)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(100))



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Joypad camera movement
	var joypad_vec = Vector2()
	joypad_vec = Vector2(Input.get_joy_axis(0, 2), Input.get_joy_axis(0, 3))
	if joypad_vec.x < 0.1 and joypad_vec.x > -0.2:
		joypad_vec.x = 0
	if joypad_vec.y < 0.1 and joypad_vec.y > -0.2:
		joypad_vec.y = 0
	head.rotate_y(-joypad_vec.x * joypad_sensitivity)
	camera.rotate_x(-joypad_vec.y * joypad_sensitivity)
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-100), deg_to_rad(100))
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION)
		velocity.z = move_toward(velocity.z, 0, FRICTION)

	move_and_slide()

func set_sensitivity(value):
	sensitivity = value/1000
	
func _on_mouse_sens_box_value_changed(value):
	sensitivity = value/1000

#_on_controller_sens_box_value_changed
func set_joypad_sensitivity(value):
	joypad_sensitivity = value/100

