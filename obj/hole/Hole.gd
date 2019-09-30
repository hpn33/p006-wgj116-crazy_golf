extends Area2D

func _on_Hole_body_entered(body: PhysicsBody2D) -> void:
	
	if body.is_in_group('ball'):
		get_tree().reload_current_scene()
	
	pass # Replace with function body.
