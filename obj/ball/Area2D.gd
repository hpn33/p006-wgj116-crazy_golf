extends Area2D


func _on_Area2D_mouse_entered() -> void:
	owner.force.touchable = true

func _on_Area2D_mouse_exited() -> void:
	owner.force.touchable = false
