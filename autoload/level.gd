extends Node


var level = [
	"res://scene/level/L1.tscn",
	"res://scene/level/L2.tscn",
	"res://scene/level/L3.tscn"
]

#var current_scene = ''
#var current_level = 1

#func load_scene(current_scene):
#
#	var scene = load(current_scene)
#
#	get_tree().current_scene = scene

#func new_level():
#
#	var i = 0
#	for l in level:
#		if current_scene == l:
#			break
#		i += 1
#
#	current_scene = level[i]
#	load_scene(current_scene)

func load_level(number):
	
	var l = level[number-1]
	
	get_tree().change_scene(l)


#func next():
#
#	var l = load(level[current_level-1])
#
#	get_tree().current_scene = l

func reload():
	get_tree().reload_current_scene()