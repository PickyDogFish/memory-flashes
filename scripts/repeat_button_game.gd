extends Node2D

var btn1 = preload("res://scenes/buttons/bt_1.tscn")
var btn2 = preload("res://scenes/buttons/bt_2.tscn")
var btn3 = preload("res://scenes/buttons/bt_3.tscn")
var btn4 = preload("res://scenes/buttons/bt_4.tscn")
var btn5 = preload("res://scenes/buttons/bt_5.tscn")
var btn6 = preload("res://scenes/buttons/bt_6.tscn")
var btn7 = preload("res://scenes/buttons/bt_7.tscn")
var btn8 = preload("res://scenes/buttons/bt_8.tscn")
var btn9 = preload("res://scenes/buttons/bt_9.tscn")
var btn10 = preload("res://scenes/buttons/bt_10.tscn")
var btn11 = preload("res://scenes/buttons/bt_10.tscn")
var btn12 = preload("res://scenes/buttons/bt_10.tscn")
var btn13 = preload("res://scenes/buttons/bt_10.tscn")
var btn14 = preload("res://scenes/buttons/bt_10.tscn")
var btn15 = preload("res://scenes/buttons/bt_10.tscn")
var btn16 = preload("res://scenes/buttons/bt_10.tscn")

var rows = 4 
var cols = 4

var buttonStack = [btn1.instance(),btn2.instance(),btn3.instance(),btn4.instance(),btn5.instance(),btn6.instance(),btn7.instance(),btn8.instance(),btn9.instance(),btn10.instance(),btn11.instance(), btn12.instance(),btn13.instance(), btn14.instance(),btn15.instance(), btn16.instance()]
var flipped_buttons = []

var solution = []

func _ready():
	print(len(buttonStack))
	place_buttons()
	

func place_buttons():
	var numOfCards = len(buttonStack)
	var pos_x = get_viewport_rect().size[0]/2 - (200 + 20) * rows/2
	var pos_y = get_viewport_rect().size[1]/2 - (200 + 10) - 200
	for i in range(0, rows):
		for j in range(0, cols):
			var button: Repeat_button = buttonStack.pop_front()
			self.add_child(button)
			button.position += Vector2(pos_x, pos_y)
			button.flip()
			pos_x += 256 + 10
			button.connect("button_clicked", self, "on_button_clicked")
		pos_x = get_viewport_rect().size[0]/2 - (200 + 20) * rows/2
		pos_y += 256 + 10
		

func on_button_clicked(card:Repeat_button):
	print(flipped_buttons)
	if not card.flipped:
		if len(flipped_buttons) == 1:
			flip_card_array(flipped_buttons)
			flipped_buttons = []
			card.flip()
			flipped_buttons.append(card)
		
		elif len(flipped_buttons) == 0:
			card.flip()
			flipped_buttons.append(card)
	else:
		card.flip()
		flipped_buttons.erase(card)
		

		
func flip_card_array(array):
	for card in array:
		card.flip()
		
		
