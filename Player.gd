extends AnimatedSprite2D


const SMOOTHING_SPEED = 5
const OFFSET = Vector2(160, 112)
func _ready():
	pass # Replace with function body.

var player_target = OFFSET
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target = Vector2(
		Input.get_axis("Move_left", "Move_right"),
		Input.get_axis("Move_up", "Move_down")
	)
	player_target = player_target.lerp(target * 4 + OFFSET, SMOOTHING_SPEED * delta)
	position = player_target
	
	var v = Vector3(target.x, 0, target.y)
	v = v.normalized()
	%Body.position += v * delta
	
	%Camera3D.position.x = lerp(%Camera3D.position.x, %Body.position.x, SMOOTHING_SPEED * delta)
	%Camera3D.position.z = lerp(%Camera3D.position.z, %Body.position.z+1, SMOOTHING_SPEED * delta)
	
	
	var h_speed = Input.get_axis("Move_left", "Move_right")
	var v_speed = Input.get_axis("Move_up", "Move_down")
	
	if h_speed == 0 and v_speed == 0:
		stop()
	else:
		if v_speed != 0 and h_speed != 0:
			if v_speed > 0:
				play("walk_down")
				flip_h = 0
			else:
				play("walk_up")
				flip_h = 0
		elif h_speed != 0:
			if h_speed > 0:
				play("walk_side")
				flip_h = 0
			else:
				play("walk_side")
				flip_h = 1
		else:
			if  v_speed > 0:
				play("walk_down")
				flip_h = 0
			else:
				play("walk_up")
				flip_h = 0
