tool
extends StaticBody2D


#export var size := Vector2() setget set_size
#
#onready var sprite = $Sprite
#onready var coll = $CollisionShape2D
#
#func _ready() -> void:
##	self.size = Vector2.ONE * 10
#	pass
#
#func set_size(value):
#	size = value
#
#	sprite.scale = size
#
#	coll.new_coll(size / 2)