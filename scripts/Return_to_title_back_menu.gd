extends Control

var scene

func _on_Back_Button_pressed():
	get_tree().change_scene("res://scenes/Main Menu.tscn")


func _on_Continue_Button_pressed():
	get_tree().change_scene("res://scenes/room1.tscn")


func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://scenes/room1.tscn")
	$FadeIn.show()
	$FadeIn.fade_in()
