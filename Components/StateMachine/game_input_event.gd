class_name GameInputEvent

static var direction: Vector2

static func movement_input() -> Vector2:
	direction = Vector2.ZERO
	
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("up"):
		direction.y -= 1
	if Input.is_action_pressed("down"):
		direction.y += 1
	
	# Normalize so diagonal isn't faster
	direction = direction.normalized()
	
	return direction


static func is_movement_input() -> bool:
	return direction != Vector2.ZERO
		
static func use_tool() -> bool:
	var use_tool_value: bool = Input.is_action_just_pressed("action")
	
	return use_tool_value
