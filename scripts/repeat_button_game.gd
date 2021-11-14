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
var btn11 = preload("res://scenes/buttons/bt_3.tscn")
var btn12 = preload("res://scenes/buttons/bt_6.tscn")
var btn13 = preload("res://scenes/buttons/bt_2.tscn")
var btn14 = preload("res://scenes/buttons/bt_1.tscn")
var btn15 = preload("res://scenes/buttons/bt_9.tscn")
var btn16 = preload("res://scenes/buttons/bt_10.tscn")

var rows = 4 
var cols = 4

var buttonStack = [btn1.instance(),btn2.instance(),btn3.instance(),btn4.instance(),btn5.instance(),btn6.instance(),btn7.instance(),btn8.instance(),btn9.instance(),btn10.instance(),btn11.instance(), btn12.instance(),btn13.instance(), btn14.instance(),btn15.instance(), btn16.instance()]
var flippedButtons = []

var level := 1
var solutionDelay := 300
var BETWEEN_PRESS_DELAY = 30
var timeLeft := 0
var showingSolution := true
var levelCount = 4

var solution = []

func _ready():
	print(len(buttonStack))
	place_buttons()
	create_solution()
	timeLeft = solutionDelay
	
	
func _process(delta):
	timeLeft -= delta
	if timeLeft <= 0 and showingSolution:
		showingSolution = false
		for i in range(0, level * 2):
			solution[i].unpress()
	if showingSolution and level <= levelCount:
		for i in range(0, level * 2):
			solution[i].press()


func place_buttons():
	var numOfCards = len(buttonStack)
	var pos_x = get_viewport_rect().size[0]/2 - (200 + 20) * rows/2
	var pos_y = get_viewport_rect().size[1]/2 - (200 + 10) - 200
	for i in range(0, rows):
		for j in range(0, cols):
			var button: Repeat_button = buttonStack.pop_front()
			self.add_child(button)
			button.position += Vector2(pos_x, pos_y)
			button.unpress()
			pos_x += 256 + 10
			button.connect("button_pressed", self, "on_button_clicked")
			buttonStack.append(button)
		pos_x = get_viewport_rect().size[0]/2 - (200 + 20) * rows/2
		pos_y += 256 + 10


func on_button_clicked(button:Repeat_button):
	flippedButtons.append(button)
	button.press()
	#checkLastButton()
	checkIfLastInSolution()
	

func checkLastButton():
	print(flippedButtons)
	var checkButton = flippedButtons[-1]
	if checkButton == solution[len(flippedButtons)-1]:
		checkButton.get_child(2).play()
	else:
		$mistake_sound.play()
		level = 1
		flippedButtons = []
	if len(flippedButtons) == level*2:
		level += 1
		unpress_all_buttons()
		show_solution()
		
		
func checkIfLastInSolution():
	var checkButton = flippedButtons[-1]
	var found = false
	for i in range(0, level*2):
		if checkButton == solution[i]:
			found = true
			checkButton.get_child(2).play()
	if not found:
		$mistake_sound.play()
		level = 1
		flippedButtons = []
		create_solution()
		unpress_all_buttons()
	if found and len(flippedButtons) == level*2:
		if level == levelCount:
			you_have_won()
		else:
			level += 1
			unpress_all_buttons()
			show_solution()

func show_solution():
	timeLeft = solutionDelay
	showingSolution = true
	flippedButtons = []
	
		
func flip_card_array(array):
	for card in array:
		card.flip()
		
func create_solution():
	solution = []
	var indexes = range(16)
	randomize()
	indexes.shuffle()
	for i in range(levelCount * 2):
		solution.append(buttonStack[indexes.pop_back()])

func unpress_all_buttons():
	for button in buttonStack:
		button.unpress()
		
func you_have_won():
	timeLeft = 99999
	showingSolution = true
	$TextureButton.show()
	
		
