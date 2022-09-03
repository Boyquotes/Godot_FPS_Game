extends KinematicBody

const MOUSE_SENSITIVITY = 0.1

onready var camera = $CameraRoot/Camera

# movement
var velocity = Vector3.ZERO
var current_velocity = Vector3.ZERO
var direction = Vector3.ZERO

const player_speed = 10
const acceleration = 15.0

# jumping
const gravity = -40.0
const jump_speed = 10
const air_acceleration = 9.0
var jump_count = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(_delta):
	window_activity()
	
func _physics_process(delta):
	
	direction = Vector3.ZERO
	
	if Input.is_action_pressed("forward"):
		direction -= camera.global_transform.basis.z
		
	if Input.is_action_pressed("backward"):
		direction += camera.global_transform.basis.z
	
	if Input.is_action_pressed("strafe_left"):
		direction -= camera.global_transform.basis.x
		
	if Input.is_action_pressed("strafe_right"):
		direction += camera.global_transform.basis.x
	
	direction = direction.normalized()
	
	# Apply gravity
	velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
	
	# smooth player movement
	var accel = acceleration if is_on_floor() else air_acceleration
	var target_velocity = direction * player_speed
	current_velocity = current_velocity.linear_interpolate(target_velocity, accel * delta)
	
	velocity.x = current_velocity.x
	velocity.z = current_velocity.z
	
	velocity = move_and_slide(velocity, Vector3.UP, true, 4, deg2rad(45.0))
	
func _input(event):
	if event is InputEventMouseMotion:
		# Rotate the view vertically
		$CameraRoot.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		
		#Prevents camera from rotating infinitely on the x axis
		$CameraRoot.rotation_degrees.x = clamp($CameraRoot.rotation_degrees.x, -90, 90)
		
		# Rotates the view horizontally
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

# used to show/hide cursor
func window_activity():
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
