extends Node2D

var speed = Vector2(500, 0)
var rot := 0.0
var force := Vector2()

var force_point := Vector2()
var mx_force_line := Vector2(190, 0)
var mx_force_line_rot := Vector2()


func _process(delta: float) -> void:
	
	if Input.is_action_pressed('cl'):
		
		force_point = lerp(force_point, get_local_mouse_position(), 10* delta)
		
		mx_force_line_rot = mx_force_line.rotated(rot)
		var x = mx_force_line_rot
		
		var signx = sign(x.x)
		var signy = sign(x.y)
		
		force_point.x = clamp(force_point.x, -signx * x.x, signx * x.x)
		force_point.y = clamp(force_point.y, -signy * x.y, signy * x.y)
		
	elif Input.is_action_just_released('cl'):
		
		var coefficient = force_point / mx_force_line_rot

		var rev_rot = rot - deg2rad(180)
		var op_speed = speed.rotated(rev_rot) * coefficient
		
		force = op_speed
		
#		owner.move_and_slide(force)
		owner.linear_velocity = force
	else:
		
		force_point = lerp(force_point, Vector2(), 15 * delta)
	
	force = lerp(force, Vector2(), delta)
	
#	owner.move_and_slide(force)
#	owner.linear_velocity = force
	update()


func _draw() -> void:
	
	draw_line(Vector2(), force_point, Color.white, 5)
	
	var lmp = get_local_mouse_position()
	
	rot = atan2(lmp.y, lmp.x)




