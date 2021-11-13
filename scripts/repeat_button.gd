extends Area2D

signal button_clicked(button)
class_name Repeat_button

func _ready():
	pass # Replace with function body.
	

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			emit_signal("button_clicked", self)


func activate():
	pass
