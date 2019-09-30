extends StaticBody2D

onready var t = $Tween

var p1 := Vector2()
var p2 := Vector2()

export var offset := Vector2()
export var time := 2.0

var sw = true

func _ready() -> void:
	
	p1 = position
	p2 = position
	
	p2 += offset
	
	play(p1, p2, true)
	


func play(p1, p2, bol):
	
	t.interpolate_property(self, 'position', p1, p2, time,Tween.TRANS_LINEAR, Tween.EASE_IN)
	t.start()
	sw = bol



func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if sw:
		play(p2, p1, false)
	else:
		play(p1, p2, true)
