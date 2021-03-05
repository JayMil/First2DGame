extends Node

signal score_updated
signal player_died

const highscore_filename: = "user://first2dgamehs.dat"
const max_high_scores: = 5
var score: = 0 setget set_score
var deaths: = 0 setget set_deaths
var player_name: = "" setget set_player_name
var levels: = []

# sorted high scores
var high_scores: = []

# dict of scores to names
var high_scores_lookup: = {}


func _ready():
	load_high_scores()
	
func save_high_scores():
	print("save_high_scores")
	print("high_scores: ", high_scores)
	print("high_scores_lookup: ", high_scores_lookup)

	var file = File.new()
	file.open(highscore_filename, File.WRITE)
	file.store_line(to_json(high_scores_lookup))
	file.close()

func load_high_scores():
	print("loading high scores")
	var file = File.new()
	if file.file_exists(highscore_filename):
		file.open(highscore_filename, File.READ)
		var line = file.get_line()
		print("Loading line: ", line)
		if line == "":
			return
			
		high_scores_lookup = parse_json(line)
		file.close()
		
		for score in high_scores_lookup.keys():
			high_scores.append(int(score))
			
		print("loaded_high_scores")
		print("high_scores: ", high_scores)
		print("high_scores_lookup: ", high_scores_lookup)


		
func add_high_score(score):
	print("add_high_score: ", score, " for ", player_name)
	print("high_scores: ", high_scores)
	print("high_scores_lookup: ", high_scores_lookup)
	# if high score matches existing update
	if score in high_scores:
		high_scores_lookup[str(score)] = player_name
		return
	
	# if room for more scores - just add
	if len(high_scores) < max_high_scores:
		high_scores.append(score)
		high_scores_lookup[str(score)] = player_name
		return
		
		
	# remove lowest score and add new score
	high_scores.sort()
	var lowest: int = high_scores[0]
	high_scores.erase(lowest)
	high_scores_lookup.erase(str(lowest))
	high_scores.append(score)
	high_scores_lookup[str(score)] = player_name
	
		
	
	
		
func is_high_score(score):
	print("is_high_score: ", score)
	print("high_scores: ", high_scores)
	print("high_scores_lookup: ", high_scores_lookup)
	
	if len(high_scores) < max_high_scores:
		return true
		
	if score in high_scores:
		return true
		
	for hs in high_scores:
		if hs < score:
			return true
			
	return false
			

func set_score(value: int):
	score = value
	emit_signal("score_updated")

func set_deaths(value: int):
	deaths = value
	emit_signal("player_died")
	
func set_player_name(value: String):
	player_name = value
	
func end_level():
	levels.append(score)
	reset_level()
	
func reset_level():
	print("reseting level")
	print("Levels: ", levels)
	var currentLevel = len(levels) + 1
	print("current level: ", currentLevel)
	if (currentLevel != 1):
		self.score = levels[currentLevel-2]
	else:
		self.score = 0
	
func total_score() -> int :
	return levels[len(levels)-1]
	
func reset():
	score = 0
	deaths = 0
	levels = []
