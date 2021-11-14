extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for node in $Clickable.get_children():
		node.connect("object_clicked", self, "on_click");
		
		
		
func on_click(node):
	print(node.name)

		
		
		



func _on_TextureButton_pressed():
	get_tree().change_scene("res://scenes/room3.tscn")
