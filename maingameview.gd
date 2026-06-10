extends Node

# Drag and drop these 3 nodes from your Scene Tree into the Inspector!
@onready var subviewport_emotion: SubViewport = $PlayerViewports/SubViewportContainerEmotion/SubViewportEmotion
@onready var subviewport_reason: SubViewport = $PlayerViewports/SubViewportContainerReason/SubViewportReason
@onready var subviewport_container_reason: SubViewportContainer = $PlayerViewports/SubViewportContainerReason

# The camera lives permanently under SubViewportReason
@onready var cameraReason = subviewport_reason.get_node("Camera2DReason")

# We track the level root node dynamically
@onready var current_level: Node2D = $PlayerViewports/SubViewportContainerEmotion/SubViewportEmotion/Node2D

# References inside the changing level
var players_midpoint: Node2D
var cameraEmotion: Camera2D
var pEmotion: CharacterBody2D
var pReason: CharacterBody2D

var camera_split: bool = false

func _ready() -> void:
	# Double check you didn't forget to link them in the Inspector
	if not subviewport_emotion or not subviewport_reason:
		push_error("Missing Viewport references in the Inspector!")
		return
		
	# Share the world resource safely
	subviewport_reason.world_2d = subviewport_emotion.world_2d
	
	_update_level_references(current_level)
	
	if !camera_split:
		subviewport_container_reason.visible = false
		if cameraReason and pReason:
			cameraReason.switch_target(pReason)
		if cameraEmotion and players_midpoint:
			cameraEmotion.switch_target(players_midpoint)



func _change_camera() -> void:
	camera_split = !camera_split # Quickly toggles true/false
	
	if camera_split:
		subviewport_container_reason.visible = true
		if cameraEmotion and pEmotion:
			cameraEmotion.switch_target(pEmotion)
		if cameraReason and pReason:
			cameraReason.switch_target(pReason)
	else:
		subviewport_container_reason.visible = false
		if cameraEmotion and players_midpoint:
			cameraEmotion.switch_target(players_midpoint)


func _change_scene(new_scene: Node2D) -> void:
	if not new_scene:
		return
		
	# 1. Safely delete the old level
	current_level.queue_free()
	
	# 2. Attach the new level into the Emotion SubViewport
	subviewport_emotion.add_child(new_scene)
	current_level = new_scene 
	
	# 3. Wait a single frame for Godot to initialize the new nodes inside the tree
	await get_tree().process_frame
	
	# 4. Grab the new camera/player references from the new level layout
	_update_level_references(new_scene)
	
	# 5. Re-sync the shared 2D world
	subviewport_reason.world_2d = subviewport_emotion.world_2d
	
	# 6. Push correct targets to the cameras based on current split-screen mode
	if camera_split:
		if cameraEmotion and pEmotion: cameraEmotion.switch_target(pEmotion)
	else:
		if cameraEmotion and players_midpoint: cameraEmotion.switch_target(players_midpoint)
		
	if cameraReason and pReason:
		cameraReason.switch_target(pReason)


# Helper function to prevent repeating code when grabbing internal level nodes
func _update_level_references(level_node: Node2D) -> void:
	cameraEmotion = level_node.get_node_or_null("Camera2DEmotion")
	pEmotion = level_node.get_node_or_null("PlayerEmotion")
	pReason = level_node.get_node_or_null("PlayerReason")
	players_midpoint = level_node.get_node_or_null("PlayersMidPoint")

func _on_button_button_down() -> void:
	_change_camera()
	
	
func change_scene_by_path(scene_path) -> void:
	var next_scene = load(scene_path).instantiate()
	_change_scene(next_scene)
	
