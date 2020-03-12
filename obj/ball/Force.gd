extends Node2D

var touchable := false
var touched := false

var speed = Vector2(300, 0)
var rot := 0.0

var force := Vector2()
var max_force := Vector2(-80, 0)
var max_force_rot := Vector2()

var force_point := Vector2()

var gmp := Vector2()
var omp := Vector2()

var coefficient := Vector2()



func _process(delta: float) -> void:
	
	get_need_position()
	
	if Input.is_action_pressed('cl') and (touchable or touched):
		
		force_point = lerp(force_point, omp, 10 * delta)
		
		max_force_rot = max_force.rotated(rot)
		var x = max_force_rot
		
		var signx = sign(x.x)
		var signy = sign(x.y)
		
		force_point.x = clamp(force_point.x, -signx * x.x, signx * x.x)
		force_point.y = clamp(force_point.y, -signy * x.y, signy * x.y)
		
		touched = true
	elif Input.is_action_just_released('cl') and touched:
		coefficient = force_point / max_force_rot
		
		force = speed.rotated(rot) * coefficient
		
		
		var avrag = avrage(coefficient)
		
		if avrag > 80:
			owner.play('hig')
		elif avrag > 40:
			owner.play('mid')
		else:
			owner.play('low')
			
		
		
		owner.linear_velocity = force
		touched = false
	else:
		
		force_point = lerp(force_point, Vector2(), 15 * delta)
	
	force = lerp(force, Vector2(), delta)
	
	update()


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
#		owner.text(event.position)
#		print('yes')
		pass
	pass

func get_need_position():
	
	gmp = get_global_mouse_position()
	
	# mouse pos of owner
	omp = gmp - owner.position
	
	# rotation of owner position and global position
	rot = owner.position.angle_to_point(gmp)


func _draw() -> void:
	
	
	# force line
	draw_line(Vector2(), force_point.rotated(-owner.rotation), Color.gray, 3)
	
	if not main.debug:
		return
	
	
	
	# force point
	draw_circle(force_point.rotated(-owner.rotation + PI), 5, Color.red)
	
	# mouse point of owner
	draw_circle(omp.rotated(-owner.rotation), 5, Color.blue)



func avrage(coefficient):
	var plus = coefficient.x + coefficient.y
	var div = plus / 2
	
	return div * 100

