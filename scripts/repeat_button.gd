extends Area2D

var card1 = preload("res://scenes/round_button.tscn")
signal button_clicked(button)
class_name Repeat_button

var rows = 4 
var cols = 4

var buttonStack = [card1.instance(), card1.instance()]
var flipped_buttons = []


func _ready():
	place_cards()
	

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			emit_signal("button_clicked", self)


func place_cards():
	var numOfCards = len(buttonStack)
	for i in range(0, rows):
		for j in range(0, numOfCards/rows): 
			var card: Card = buttonStack.pop_front()
			self.add_child(card)
			card.position += Vector2(pos_x, pos_y)
			card.flip()
			pos_x += 256 + 10
			card.connect("card_clicked", self, "on_card_clicked")
		pos_x = get_viewport_rect().size[0]/2 - (256 + 20) * rows/2
		pos_y += 256 + 10
		
func check_pairs():
	var numofButtons = len (buttonStack)
		for i in range (0,)


func on_card_clicked(card:Card):
	print(flipped_buttons)
	if not card.pair:
		if not card.flipped:
			if len(flipped_buttons) == 1:
				flip_card_array(flipped_buttons)
				flipped_buttons = []
				card.flip()
				flipped_buttons.append(card)
			
			elif len(flipped_buttons) == 0:
				card.flip()
				flipped_buttons.append(card)
				check_pairs()
		else:
			card.flip()
			flipped_buttons.erase(card)


func check_pairs():
	if flipped_buttons[0].card_name == flipped_buttons[1].card_name:
		flipped_buttons = []
		check_if_won()
		
func check_if_won():
	var won = true
	for card in get_children():
		if card.pair == false:
			won = false
			
	if won:
		print("youve won")
		
func flip_card_array(array):
	for card in array:
		card.flip()
		
		
