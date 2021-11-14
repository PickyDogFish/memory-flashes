extends Node2D

var lineColor := Color.darkorange
var antialiased := true

var connectionPointRadius := 20.0
var connectionPointColor := Color.darkcyan
var startPointColor := Color.green
var endPointColor := Color.red

var connectionPointsCount := 20
var connectionPoints := []

var currentLinePoints := []

var solutionLine := [0,5,6,10,14,9,7,3,2,6,11]
var levels := [3,5,8,11]
var level := 0
var showingSolution := true
var solutionDelay := 300
var timeLeft := 0

func _ready():
	randomize()
	var bounds := get_viewport_rect()
	connectionPoints = generatePointGrid()
	#generateRandomPath(4)
	timeLeft = solutionDelay
	showingSolution = true


func show_solution():
	timeLeft = solutionDelay
	showingSolution = true
	currentLinePoints = []
	

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var clickedConnectionPoint = findClosestConnectionPointTo(get_global_mouse_position(), connectionPointRadius)
			if not clickedConnectionPoint:
				return
			updateCurrentLineWith(clickedConnectionPoint)
			checkLastPoint()
			update()


func _process(delta):
	timeLeft -= delta
	if timeLeft <= 0:
		showingSolution = false
	update()


func _draw():
	var lineWidth = connectionPointRadius
	#if we are still showing the solution
	if showingSolution:
		var n := 0
		for connectionPoint in connectionPoints:
			if n == 0:
				draw_circle(connectionPoint, connectionPointRadius, startPointColor)
			else:
				draw_circle(connectionPoint, connectionPointRadius, connectionPointColor)
			n += 1
		#drawing solution lines
		for i in range(1, levels[level]):
			draw_line(connectionPoints[solutionLine[i-1]], connectionPoints[solutionLine[i]], lineColor, lineWidth, antialiased)
	#if it is time for the player to draw lines
	else:
		for connectionPoint in connectionPoints:
			draw_circle(connectionPoint, connectionPointRadius, connectionPointColor)
		
		if currentLinePoints.size() % 2 == 1 or true and currentLinePoints.size() > 0:
			var globalMousePosition = get_global_mouse_position()
			var lineEndpoint = findClosestConnectionPointTo(globalMousePosition, connectionPointRadius)
			if not lineEndpoint:
				lineEndpoint = globalMousePosition
			draw_line(currentLinePoints[-1], lineEndpoint, lineColor, lineWidth, antialiased)
		
		if currentLinePoints.size() > 1:
			for i in range(1, currentLinePoints.size()):
				draw_line(currentLinePoints[i-1], currentLinePoints[i], lineColor, lineWidth, antialiased)

#generates a 4x4 grid of points
func generatePointGrid():
	var points := []
	var startX = 448
	var startY = 192
	for i in range(4):
		for j in range(4):	
			var point := Vector2(startX,startY)
			points.push_back(point)
			startX += 340
		startX = 448
		startY += 224
	return points


func findClosestConnectionPointTo(aPoint: Vector2, maxDistance: float):
	var closestPoint = null
	var closestDistance = INF
	for connectionPoint in connectionPoints:
		var distance = connectionPoint.distance_to(aPoint)
		if distance <= maxDistance:
			if not closestPoint or distance < closestDistance:
				closestPoint = connectionPoint
				closestDistance = distance
	return closestPoint


func updateCurrentLineWith(position: Vector2):
	currentLinePoints.push_back(position)

func checkLastPoint():
	var checkPoint = currentLinePoints[-1]
	if levels[level] < currentLinePoints.size() or checkPoint != connectionPoints[solutionLine[currentLinePoints.size()-1]]:
		print(checkPoint, solutionLine[currentLinePoints.size()-1])
		$mistake_sound.play()
		level = 1
		show_solution()
	else:
		$correct_sound.play()
		if level == 3:
			you_have_won()
		elif levels[level] == currentLinePoints.size():
			level += 1
			show_solution()

func generateRandomPath(length):
	randomize()
	connectionPoints.shuffle()
	for i in range(min(connectionPoints.size(), length)):
		solutionLine.append(connectionPoints[i])
		
func you_have_won():
	timeLeft = 99999
	showingSolution = true
	pass
		
