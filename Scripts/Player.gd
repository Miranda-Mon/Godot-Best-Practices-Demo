extends KinematicBody

export var _mouse_sensitivity:float = 0.1
export var _move_speed := 3.0

func _ready()->void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) #oculta o rato e mesmo fora do canvas, ele mantem-se ativo



func _input(event)->void:
	aim(event)


func _physics_process(delta):
	movement()


func aim(event: InputEvent)->void:
	var mouse_motion = event as InputEventMouseMotion
	if mouse_motion:
		self.rotation_degrees.y -= mouse_motion.relative.x * _mouse_sensitivity
		var currentCamRotation = $Camera.rotation_degrees.x
		currentCamRotation -= mouse_motion.relative.y * _mouse_sensitivity
		$Camera.rotation_degrees.x = clamp(currentCamRotation,-90,90)


func movement()->void:
	var movement_vector :Vector3
	var movementSideways_vector :Vector3
	if Input.is_action_pressed("move_forward"):
		movement_vector = self.transform.basis.z
	elif Input.is_action_pressed("move_backward"):
		movement_vector = -self.transform.basis.z
	
	if Input.is_action_pressed("move_left"):
		movementSideways_vector = self.transform.basis.x
	elif Input.is_action_pressed("move_right"):
		movementSideways_vector = -self.transform.basis.x
	
	move_and_slide((movement_vector.normalized()+movementSideways_vector.normalized())*_move_speed)
