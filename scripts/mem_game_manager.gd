extends Node2D

var rows = 4

var card1 = preload("res://scenes/cards/card1.tscn")
var card2 = preload("res://scenes/cards/card2.tscn")
var card3 = preload("res://scenes/cards/card3.tscn")
var card4 = preload("res://scenes/cards/card4.tscn")
var card5 = preload("res://scenes/cards/card5.tscn")
var card6 = preload("res://scenes/cards/card6.tscn")
var card7 = preload("res://scenes/cards/card7.tscn")
var card8 = preload("res://scenes/cards/card8.tscn")
var card9 = preload("res://scenes/cards/card9.tscn")
var card10 = preload("res://scenes/cards/card10.tscn")


var cardStack = [card1.instance(), card1.instance(), card2.instance(), card2.instance(), card3.instance(), card3.instance(), card4.instance(), card4.instance(), card5.instance(), card5.instance(), card6.instance(), card6.instance(), card7.instance(), card7.instance(), card8.instance(), card8.instance(), card9.instance(), card9.instance(), card10.instance(), card10.instance(),]
var flipped_cards = []


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	cardStack.shuffle()
	for card in cardStack:
		card.scale.x = 0.2
		card.scale.y = 0.2
	place_cards()
	

func place_cards():
	var pos_x = get_viewport_rect().size[0]/2 - (256 + 20) * rows/2
	var pos_y = get_viewport_rect().size[1]/2 - (256 + 10) - 128
	var numOfCards = len(cardStack)
	for i in range(0, rows):
		for j in range(0, numOfCards/rows):
			var card: Card = cardStack.pop_front()
			self.add_child(card)
			card.position += Vector2(pos_x, pos_y)
			card.flip()
			pos_x += 256 + 10
			card.connect("card_clicked", self, "on_card_clicked")
		pos_x = get_viewport_rect().size[0]/2 - (256 + 20) * rows/2
		pos_y += 256 + 10


func on_card_clicked(card:Card):
	print(flipped_cards)
	if not card.pair:
		if not card.flipped:
			if len(flipped_cards) == 2:
				flip_card_array(flipped_cards)
				flipped_cards = []
				card.flip()
				flipped_cards.append(card)
			
			elif len(flipped_cards) == 1:
				card.flip()
				flipped_cards.append(card)
				check_pairs()
			elif len(flipped_cards) == 0:
				card.flip()
				flipped_cards.append(card)
		else:
			card.flip()
			flipped_cards.erase(card)


func check_pairs():
	if flipped_cards[0].card_name == flipped_cards[1].card_name:
		flipped_cards = []
		check_if_won()
		
func check_if_won():
	var won = true
	for card in get_children():
		if card.pair == false:
			won = false
			
	if won:
		you_have_won()
		
func flip_card_array(array):
	for card in array:
		card.flip()
		
		
		
func you_have_won():
	$TextureButton.show()
			
