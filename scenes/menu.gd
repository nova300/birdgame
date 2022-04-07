extends Control

func _ready():
	$VBoxContainer/start.grab_focus()


func _on_start_pressed():
	get_tree().change_scene("res://scenes/field1.tscn")




func _on_quit_pressed():
	get_tree().quit()
