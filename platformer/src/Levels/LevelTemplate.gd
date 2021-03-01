extends Node2D

onready var player: KinematicBody2D = get_node("Elements/Player")
onready var portal: Area2D = get_node("Elements/Portal2D")

func _ready():
	portal.connect("on_teleport", player, "on_teleport")
