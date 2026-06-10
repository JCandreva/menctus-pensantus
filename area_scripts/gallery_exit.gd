extends Area2D


@onready var mainView = $"../../../../.."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		mainView.change_scene_by_path("res://scenes/plataform.tscn")
		mainView._change_camera()
		mainView.change_cameras_zoom(Vector2(0.4, 0.4))
