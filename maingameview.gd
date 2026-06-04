extends Node

@onready var subviewport_emotion:SubViewport =  $PlayerViewports/SubViewportContainerEmotion/SubViewportEmotion
@onready var subviewport_reason:SubViewport = $PlayerViewports/SubViewportContainerReason/SubViewportReason

@onready var subviewport_container_emotion:SubViewportContainer =  $PlayerViewports/SubViewportContainerEmotion
@onready var subviewport_container_reason:SubViewportContainer = $PlayerViewports/SubViewportContainerReason

@onready var players_midpoint = $PlayerViewports/SubViewportContainerEmotion/SubViewportEmotion/Node2D/PlayersMidPoint
@onready var camera = $PlayerViewports/SubViewportContainerEmotion/SubViewportEmotion/Node2D/Camera2DEmotion
@onready var pEmotion = $PlayerViewports/SubViewportContainerEmotion/SubViewportEmotion/Node2D/PlayerEmotion

@onready var camera_split = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	subviewport_reason.world_2d = subviewport_emotion.world_2d


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if camera_split:
		subviewport_container_reason.visible = true
		camera.switch_target(pEmotion)
	else:
		subviewport_container_reason.visible = false
		camera.switch_target(players_midpoint)


func _on_button_button_down() -> void:
	if camera_split:
		camera_split = false
	else:
		camera_split = true
