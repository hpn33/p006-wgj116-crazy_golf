extends Node2D

var speed = Vector2(250, 0)
var rot := 0.0

var force := Vector2()
var max_force := Vector2(-120, 0)
var max_force_rot := Vector2()

var force_point := Vector2()

var gmp := Vector2()
var omp := Vector2()

var coefficient := Vector2()

func _process(delta: float) -> void:
	
	get_mouse_position()
	
	if Input.is_action_pressed('cl'):
		
		force_point = lerp(force_point, omp, 10 * delta)
		
		max_force_rot = max_force.rotated(rot)
		var x = max_force_rot
		
		var signx = sign(x.x)
		var signy = sign(x.y)
		
		force_point.x = clamp(force_point.x, -signx * x.x, signx * x.x)
		force_point.y = clamp(force_point.y, -signy * x.y, signy * x.y)
		
	elif Input.is_action_just_released('cl'):
		coefficient = force_point / max_force_rot
		
		force = speed.rotated(rot) * coefficient
		
		owner.linear_velocity = force
	else:
		
		force_point = lerp(force_point, Vector2(), 15 * delta)
	
	force = lerp(force, Vector2(), delta)
	
	update()


func get_mouse_position():
	
	gmp = get_global_mouse_position()
	
	# mouse pos of owner
	omp = gmp - owner.position
	
	# rotation of owner position and global position
	rot = owner.position.angle_to_point(gmp)


func _draw() -> void:
	
	# force line
	draw_line(Vector2(), force_point.rotated(-owner.rotation), Color.white, 5)
	
	# force point
	draw_circle(force_point.rotated(-owner.rotation + PI), 5, Color.red)
	
	# mouse point of owner
	draw_circle(omp.rotated(-owner.rotation), 5, Color.blue)





