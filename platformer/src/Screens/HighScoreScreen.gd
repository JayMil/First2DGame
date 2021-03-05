extends Control

onready var scene_tree: = get_tree()
onready var newHighScoreLabel: Label = get_node("NewHighScoreLabel")
onready var playButton: Button = get_node("Menu/PlayButton")
onready var quitButton: Button = get_node("Menu/QuitButton")
onready var mainMenuButton: Button = get_node("Menu/MainMenuButton")
onready var buttons: = [playButton, quitButton, mainMenuButton]
onready var highScoreContainer: GridContainer = get_node("HighScores")

var index: = 0 setget set_index

func _ready():
	var score: = PlayerData.total_score()
	
	if PlayerData.is_high_score(score):
		PlayerData.add_high_score(score)
		PlayerData.save_high_scores()
		newHighScoreLabel.text = "New High Score of %s for %s!" % [str(score), PlayerData.player_name]
	else:
		newHighScoreLabel.text = "New Score of %s for %s" % [str(score), PlayerData.player_name]
		
	PlayerData.high_scores.sort()
	PlayerData.high_scores.invert()
	var rank: = 1
	for hs in PlayerData.high_scores:
		name = PlayerData.high_scores_lookup[str(hs)]
		add_high_score_row(rank, hs, name)
		rank += 1
		
	PlayerData.reset()
	
func add_high_score_row(rank, score, name):
	print("Adding high score row for rank: ", rank, " score: ", score, " name: ", name)
	var rankLabel: Label = Label.new()
	rankLabel.text = str(rank)+"."
	
	
	var nameLabel: Label = Label.new()
	nameLabel.text = name

	var scoreLabel: Label = Label.new()
	scoreLabel.text = str(score)
	scoreLabel.align = Label.ALIGN_RIGHT
	
	
	highScoreContainer.add_child(rankLabel)
	highScoreContainer.add_child(nameLabel)
	highScoreContainer.add_child(scoreLabel)
		
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

