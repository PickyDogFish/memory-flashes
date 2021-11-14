extends Area2D


var pressed: bool = true

class_name Repeat_button

signal button_pressed(card)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func flip():
	if pressed:
		get_child(1).show()
		get_child(0).hide()
		pressed = false
	else:
		get_child(0).show()
		get_child(1).hide()
		pressed = true

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			emit_signal("button_pressed", self)

func press():
	if not pressed:
		get_child(0).show()
		get_child(1).hide()
		pressed = true
		
func unpress():
	if pressed:
		get_child(1).show()
		get_child(0).hide()
		pressed = false
