extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2DEmotion.max_height = 650
	$Camera2DEmotion.min_height = -10000000
	$"../../../SubViewportContainerReason/SubViewportReason/Camera2DReason".max_height = 1700
	$"../../../SubViewportContainerReason/SubViewportReason/Camera2DReason".min_height = 650
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
