extends Area2D

@export var color_id: int = 3

signal button_activated(color_id: int)
signal button_deactivated(color_id: int)

var is_pressed: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("reason"):
		is_pressed = true
		button_activated.emit(color_id)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("reason"):
		is_pressed = false
		button_deactivated.emit(color_id)
