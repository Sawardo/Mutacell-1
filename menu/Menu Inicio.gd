extends MarginContainer

onready var play= $PanelContainer/VBoxContainer/Play
onready var quit= $PanelContainer/VBoxContainer/Quit

func _ready():
	play.connect("pressed",self, "_on_play_pressed")
	quit.connect("pressed",self,"_on_quit_pressed")

func _on_play_pressed():
	var _e = get_tree().change_scene("res://.import/Pincipal.tscn")

func _on_quit_pressed():
	get_tree().quit()
