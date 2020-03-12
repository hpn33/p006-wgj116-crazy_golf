extends Node2D


func _unhandled_input(event: InputEvent) -> void:
	
	
	if event is InputEventScreenTouch:
		if event.pressed:
			pass
		
		print(event.index, '\t', event.position)
		
		pass
	elif event is InputEventScreenDrag:
		print(event.index, '\t', event.position)
	
	pass
