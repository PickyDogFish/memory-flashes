extends TextureButton
export (String) var scene_to_load

	
func _pressed():
	get_tree().change_scene(scene_to_load)
