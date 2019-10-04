extends Area2D

export var next_level := 0

onready var sound = $AudioStreamPlayer2D

func _on_AudioStreamPlayer2D_finished() -> void:
	
		level.load_level(next_level)
