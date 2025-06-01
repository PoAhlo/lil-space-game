extends Camera2D

@export var player_path: NodePath
@onready var player: CharacterBody2D = get_node(player_path)

func _ready() -> void:
	set_process(true)

func _process(delta) -> void:
	if player:
		global_position = player.global_position
