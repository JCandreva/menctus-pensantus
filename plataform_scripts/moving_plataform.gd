extends AnimatableBody2D

@onready var target: Sprite2D = $target


func _ready() -> void:
	
	target.visible = false
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"global_position",target.global_position,3)
	tween.tween_property(self,"global_position",global_position,3)
	tween.set_loops()
