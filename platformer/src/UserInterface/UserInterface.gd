extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("PauseOverlay")
onready var scoreLabel: Label = get_node("ScoreLabel")
onready var deathsLabel: Label = get_node("DeathsLabel")
onready var nameLabel: Label = get_node("NameLabel")
onready var pause_title: Label = get_node("PauseOverlay/Title")
onready var retryButton: Button = get_node("PauseOverlay/PauseMenu/RetryButton")
onready var mainScreenButton: Button = get_node("PauseOverlay/PauseMenu/MainScreenButton")
onready var quitButton: Button = get_node("PauseOverlay/PauseMenu/QuitButton")
onready var buttons: = [retryButton, mainScreenButton, quitButton]

var paused: = false setget set_paused

var index: = 0 setget set_index

func _process(delta):
	var btn: Button = buttons[index]
	btn.grab_focus()

func _ready():
	PlayerData.connect("score_updated", self, "update_interface")
	PlayerData.connect("player_died", self, "_on_PlayerData_player_died")
	nameLabel.text = PlayerData.player_name
	update_interface()
	
func _on_PlayerData_player_died():
	self.paused = true
	pause_title.text = "You died"

func _unhandled_input(event):
	if event.is_action_pressed("pause") and pause_title.text != "You died":
		self.paused = not paused
		scene_tree.set_input_as_handled()
	elif self.paused:
		if event.is_action_released("Down"):
			self.index += 1
			scene_tree.set_input_as_handled()
		elif event.is_action_released("Up"):
			self.index -= 1
			scene_tree.set_input_as_handled()
		elif event.is_action_released("Enter"):
			handler_enter()
			scene_tree.set_input_as_handled()

func update_interface():
	scoreLabel.text = "Score: %s" % PlayerData.score
	deathsLabel.text = "Deaths: %s" % PlayerData.deaths

func handler_enter():
	var btn: Button = buttons[index]
	btn.emit_signal("button_up")
	
func set_paused(value: bool):
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

func set_index(value: int):
	if value < 0:
		index = len(buttons) - 1
	elif value > len(buttons) - 1:
		index = 0	
	else:
		index = value
