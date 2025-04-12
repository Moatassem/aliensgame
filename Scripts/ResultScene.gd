extends Control



func _on_Play_Again_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")


func _on_Exit_pressed():
	get_tree().quit()
