extends RigidBody2D

onready var force = $Force
onready var sound = $sound/AnimationPlayer






func _physics_process(delta: float) -> void:
	
#	print(get_colliding_bodies())
	pass


func play(sound_name:String):
	sound.play(sound_name)

func be_slow():
	linear_velocity *= 0.01

func text(tx):
	$Label.text = str(tx)