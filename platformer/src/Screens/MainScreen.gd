extends Control

onready var scene_tree: = get_tree()
onready var nameText: = get_node("nameText")
onready var playButton: Button = get_node("Menu/PlayButton")
onready var quitButton: Button = get_node("Menu/QuitButton")
onready var buttons: = [playButton, quitButton]


func _ready():
	nameText.text = PlayerData.player_name
	nameText.grab_focus()
	PlayerData.reset()
	
func _process(delta):	
	if PlayerData.player_name == "":
		playButton.disabled = true
	else:
		playButton.disabled = false
		
		

func _on_nameText_text_changed(new_text):
	PlayerData.player_name = new_text
