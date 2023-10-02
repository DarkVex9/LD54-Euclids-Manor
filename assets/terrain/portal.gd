extends Node3D

var portal_surface
var camera = Node3D.new()
const CAMERA_OFFSET = Vector3(0,0.5,0)
var player_cam
var player_head
var destination_marker
var collision_shape_3D
var midpoint_offset = Vector3(0,0,0)
@export var player = Node3D.new()
@export var destination = Node3D.new()
@export var size = Vector2(1,2)
@export var destination_offset = Vector3(0,0,0)
@export var destination_rotation = Vector3(0,0,0)
@export var cull_mask = 1048569
@export var showPill = false


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().size_changed.connect(resize)
	portal_surface = get_node("Portal_Surface")
	
	var mat = ShaderMaterial.new()
	mat.set_shader(preload("res://assets/terrain/portal.gdshader"))
	var viewTexture = get_node("SubViewport").get_texture()
	mat.set_shader_parameter("viewport_texture",viewTexture)
	portal_surface.set("material_override",mat)

	#portal_surface.get("material_override").set_shader_param("viewport_texture", ViewportTexture.new())
	#portal_surface.set("material_override/shader_parameter/viewport_texture/viewport_path",get_node("SubViewport").get_path())
	camera = get_node("SubViewport/Destination_Marker/PortalCamera")
	camera.cull_mask = cull_mask
	resize()
	collision_shape_3D = get_node("Area3D/CollisionShape3D")
	
	portal_surface.mesh.size.x = size.x #- 0.02
	portal_surface.mesh.size.y = size.y #- 0.02
	portal_surface.position.y = size.y/2 #+ 0.01
	portal_surface.position.x = 0.01
	collision_shape_3D.shape.size.x = size.x
	collision_shape_3D.shape.size.y = size.y
	collision_shape_3D.position.y += size.y/2
	midpoint_offset.y = size.y/2
	
	destination_marker = get_node("SubViewport/Destination_Marker")
	#destination_marker.global_rotation = destination.global_rotation
	destination_marker.global_position =  destination.global_position
	destination_marker.global_position = destination_marker.position + destination_offset
	destination_rotation.x = deg_to_rad (destination_rotation.x)
	destination_rotation.y = deg_to_rad (destination_rotation.y)
	destination_rotation.z = deg_to_rad (destination_rotation.z)
	destination_marker.global_rotation = destination.rotation + destination_rotation
	
	player_head = player.get_node("Player/Head")
	player_cam = player.get_node("Player/Head/Camera3D")
	if player_head == null:
		print("Error - Portal - Player is likely not assigned")
	if showPill:
		get_node("SubViewport/Destination_Marker/Visualize_Destination").visible = true

func resize():
	get_node("SubViewport").set("size",DisplayServer.window_get_size())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera.global_position = destination_marker.global_position + player_cam.global_position - portal_surface.global_position + midpoint_offset
	#camera.rotation = destination.global_rotation + player_cam.global_rotation - sprite3d.global_rotation
	camera.global_rotation.x = player_cam.global_rotation.x
	camera.global_rotation.y = player_head.global_rotation.y + portal_surface.global_rotation.y - destination_marker.global_rotation.y
	#camera.position.x = sprite3d.global_position.x - player_cam.global_position.x
	#camera.position.y = sprite3d.global_position.y - player_cam.global_position.y
	#camera.position.z = sprite3d.global_position.z - player_cam.global_position.z


func _on_area_3d_body_entered(body):
	if not body.name == "Player":
		return
	# something is wrong with this line 
	#player.position = destination_marker.global_position + player.global_position - collision_shape_3D.global_position + midpoint_offset
	
	#player.global_position = camera.global_position - CAMERA_OFFSET
	#player.global_position = destination_marker.global_position + player_cam.global_position - portal_surface.global_position + midpoint_offset
	player.global_position = destination_marker.global_position + player.global_position - portal_surface.global_position + midpoint_offset
