extends "res://src/Actors/Actor.gd"

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

export var score: = 100
export var dieing: = false

func _ready():
	set_physics_process(false)
	_velocity.x = -speed.x
	
func _on_StompDetector_body_entered(body: PhysicsBody2D):
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	die()
	
func _physics_process(delta):
	if not dieing:
		_velocity.y += gravity * delta
		
		if is_on_wall():
			_velocity.x *= -1.0
		
		_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y	
	
func die():
	#queue_free()
	dieing = true
	PlayerData.score += score
	anim_player.play("Die")
