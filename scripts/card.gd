extends Area2D

var card_name: String
var pair: bool = false
var flipped: bool = true

class_name Card

signal card_clicked(card)

# Called when the node enters the scene tree for the first time.
func _ready():
	self.card_name = get_child(0).name

func get_name():
	return self.card_name
	
func flip():
	print(self.flipped)
	if flipped:
		get_child(1).show()
		get_child(0).hide()
		flipped = false
	else:
		get_child(0).show()
		get_child(1).hide()
		flipped = true

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			emit_signal("card_clicked", self)
