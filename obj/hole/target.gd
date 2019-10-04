extends Area2D

func _on_target_body_entered(body: PhysicsBody2D) -> void:
	
	if body.is_in_group('ball'):
		owner.sound.play()
		body.be_slow()
