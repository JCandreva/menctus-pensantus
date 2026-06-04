extends Node2D

@onready var pEmotion = $"../PlayerEmotion"
@onready var pReason = $"../PlayerReason"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position = (pEmotion.position + pReason.position) / 2
