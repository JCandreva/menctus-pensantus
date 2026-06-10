extends Camera2D

@export var target: Node2D = null  # Change to Node3D for 3D games
@export var smooth_speed: float = 5.0

@onready var max_height:float = 0.0
@onready var min_height:float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target and is_instance_valid(target):
		# Linear interpolation creates a smooth "catch-up" effect
		var new_y: float
		if target.global_position.y > max_height:
			new_y = max_height
		elif target.global_position.y < min_height:
			new_y = min_height
		else:
			new_y = target.global_position.y
		global_position = global_position.lerp(Vector2(target.global_position.x, new_y), smooth_speed * delta)

func switch_target(new_target: Node2D) -> void:
	target = new_target


func _on_exit_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
