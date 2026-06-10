extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2DEmotion.max_height = 0
	$Camera2DEmotion.min_height = 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
