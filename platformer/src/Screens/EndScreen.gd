extends Control

onready var scene_tree: = get_tree()
onready var playButton: Button = get_node("Menu/PlayButton")
onready var quitButton: Button = get_node("Menu/QuitButton")
onready var buttons: = [playButton, quitButton]
onready var label: Label = get_node("Label")

var index: = 0 setget set_index

func _ready():
	var score = 0
	for s in PlayerData.levels:
		score += s
		
	label.text = label.text % [score, PlayerData.deaths]
	
func _process(delta):
	var btn: Button = buttons[index]
	btn.grab_focus()

func _unhandled_input(event):
	if event.is_action_released("Down"):
		self.index += 1
		scene_tree.set_input_as_handled()
	elif event.is_action_released("Up"):
		self.index -= 1
		scene_tree.set_input_as_handled()
	elif event.is_action_released("Enter"):
		handler_enter()
		scene_tree.set_input_as_handled()

func handler_enter():
	var btn: Button = buttons[index]
	btn.emit_signal("button_up")

func set_index(value: int):
	if value < 0:
		index = len(buttons) - 1
	elif value > len(buttons) - 1:
		index = 0	
	else:
		index = value
