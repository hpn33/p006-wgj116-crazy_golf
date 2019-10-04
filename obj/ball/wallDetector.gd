extends Area2D

onready var smoke = preload("res://obj/smoke/smoke.tscn")

signal camera_shake_requested

func _on_wallDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group('wall'):
		emit_signal('camera_shake_requested')
		owner.play('hit2')
		make_smoke()
		

func make_smoke():
	var ins = smoke.instance()
	
	owner.get_parent().add_child(ins)
	
	ins.position = global_position
	ins.emitting = true
	ins.z_index = 10
	