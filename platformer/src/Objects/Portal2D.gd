tool
extends Area2D

signal on_teleport(node, caller, callback)

# could reference AnimationPlayer node with $AnimationPlayer
onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

export var next_scene: PackedScene

func _on_body_entered(body):
	teleport(body)

func _get_configuration_warning():
	return "The next scene property can't be empty" if not next_scene else ""
	
func teleport(body: Node2D):
	emit_signal("on_teleport", body, self, "finish_teleport")

func finish_teleport():
	PlayerData.end_level()
	anim_player.play("fade_in")
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_scene)
	
	

