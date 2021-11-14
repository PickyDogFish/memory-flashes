extends Area2D

export (String) var change_to_scene

signal object_clicked(node)

func _ready():
	pass # Replace with function body.

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			get_tree().change_scene(change_to_scene)
