extends Camera2D
class_name SCam


enum mode {
	free,
	ball,
	shoot,
	follow
}

export(mode) var cmode := mode.free


var ball
var dir := Vector2()
var speed := 400.0
var zom := 0
var zom_speed := 0.5


var gmp := Vector2()
var omp := Vector2()

var rot := 0.0



var target_position := Vector2()

var follow_zoom = Vector2.ONE * 0.57
var ball_zoom = Vector2.ONE * 0.5
var shoot_zoom = Vector2.ONE * 0.7



func _ready() -> void:
	change_mode(mode.ball)


func _enter_tree() -> void:
	
	var b = get_tree().get_nodes_in_group('ball')
	
	if b.size() > 0:
		ball = b[0]


func _process(delta: float) -> void:
	
	get_mouse_position()
	
#	print(cmode)
	
	match cmode:
		mode.free:
			freee(delta)
		mode.ball:
			ball(delta)
		mode.shoot:
			shoot(delta)
		mode.follow:
			follow(delta)
	
	
	if Input.is_action_just_pressed('ui_focus_next'):
		if cmode == mode.ball:
			change_mode(mode.free)
		else:
			change_mode(mode.ball)
	





func change_mode(new_mode):
	cmode = new_mode
	
	enter(cmode)

func enter(enter_mode):
	match enter_mode:
		mode.free:
#			set_freee()
			pass
		mode.ball:
			set_ball()
		mode.shoot:
			pass
		mode.follow:
			pass


func freee(delta):
	
	# move
	var r = int(Input.is_action_pressed('ui_right'))
	var l = int(Input.is_action_pressed('ui_left'))
	var u = int(Input.is_action_pressed('ui_up'))
	var d = int(Input.is_action_pressed('ui_down'))
	
	dir.x = r - l
	dir.y = d - u
	
	position += zoom * speed * dir * delta
	
	# zoom
	
	var zi = int(Input.is_action_pressed('zoom_in'))
	var zo = int(Input.is_action_pressed('zoom_out'))
	
	zom = zo - zi
	
	zoom += Vector2.ONE * zom_speed * zom * delta
	
	
	# reset
	
	if Input.is_action_just_pressed('reset_zoom'):
		zoom = Vector2.ONE
	



func set_ball():
#	target_position = ball.position
	pass


var rang := Vector2()
var rang_rot := Vector2()
var rang_point := Vector2()

func ball(delta):
	
	position = lerp(position, ball.position, delta)
	zoom = lerp(zoom, ball_zoom, delta)
	
	rang_point = omp - offset
	
	# set offset
	
	var vp = get_tree().root.get_viewport().size
	var min_weight = min(vp.x, vp.y)
	var half_min_weight = min_weight / 2
	rang.x = half_min_weight * 0.35
	
	
	
	rang_rot = rang.rotated(rot) *zoom
	
	var signx = sign(rang_rot.x)
	var signy = sign(rang_rot.y)
	
	rang_point.x = clamp(rang_point.x, -signx * rang_rot.x, signx *rang_rot.x)
	rang_point.y = clamp(rang_point.y, -signy * rang_rot.y, signy *rang_rot.y)
	
	offset = lerp(offset, rang_point, 0.1*delta)
#	print(offset)
	
	if ball.force.touched:
		change_mode(mode.shoot)
	
	update()


func shoot(delta):
	
	position = lerp(position, ball.position, delta)
	zoom = lerp(zoom, shoot_zoom, delta)
	
	rang_point = omp - offset
	
	# set offset
	
	var vp = get_tree().root.get_viewport().size
	var min_weight = min(vp.x, vp.y)
	var half_min_weight = min_weight / 2
	rang.x = half_min_weight * 0.45
	
	
	
	rang_rot = rang.rotated(rot) *zoom
	
	var signx = sign(rang_rot.x)
	var signy = sign(rang_rot.y)
	
	rang_point.x = clamp(rang_point.x, -signx * rang_rot.x, signx *rang_rot.x)
	rang_point.y = clamp(rang_point.y, -signy * rang_rot.y, signy *rang_rot.y)
	
	offset = lerp(offset, -rang_point, 1.2*delta)
#	print(offset)
	
	if not ball.force.touched:
		change_mode(mode.follow)
	
	update()
	pass



func follow(delta):
	
	position = lerp(position, ball.position, 7*delta)
	zoom = lerp(zoom, follow_zoom, 7*delta)
	offset = lerp(offset, Vector2(), 40*delta)
	
	if ball.linear_velocity < Vector2.ONE * 1:
		change_mode(mode.ball)
	
	update()
	pass






func get_mouse_position():
	
	gmp = get_global_mouse_position()
	
	# mouse pos of owner
	omp = gmp - position
	
	# rotation of owner position and global position
	rot = Vector2().angle_to_point(omp)




export var debug := false

func _draw() -> void:
	
	if not main.debug:
		return
	
	# 
	draw_circle(Vector2(), 5, Color.greenyellow)
	
	#
	draw_line(Vector2(), rang_point, Color.white, 2)
	
	# 
	draw_circle(rang_point, 5, Color.green)
	
	
	draw_line(Vector2(), offset, Color.yellow, 2)
	pass





