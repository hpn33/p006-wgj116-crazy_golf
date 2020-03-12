extends Area2D


func _on_Area2D_mouse_entered() -> void:
	owner.force.touchable = true

func _on_Area2D_mouse_exited() -> void:
	owner.force.touchable = false


func _on_toucher_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	
#	if event is InputEventScreenTouch:
#		if event.pressed:
#			owner.text(event.position)
#			owner.force.touchable = true
#
#	elif event is InputEventScreenDrag:
#		owner.text(event.position)
#		owner.force.touchable = true
#	else:
#		owner.force.touchable = false
	
	pass
	