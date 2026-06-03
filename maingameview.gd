extends Node

@onready var subviewport_emotion:SubViewport =  $PlayerViewports/SubViewportContainerEmotion/SubViewportEmotion
@onready var subviewport_reason:SubViewport = $PlayerViewports/SubViewportContainerReason/SubViewportReason


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	subviewport_reason.world_2d = subviewport_emotion.world_2d


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
