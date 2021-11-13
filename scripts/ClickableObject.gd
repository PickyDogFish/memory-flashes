extends Area2D

signal object_clicked(node)

func _ready():
	pass # Replace with function body.

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			emit_signal("object_clicked", self)
