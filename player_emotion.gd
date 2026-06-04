extends CharacterBody2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("emotion_move_right"):
		velocity.x += 1
	if Input.is_action_pressed("emotion_move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("emotion_move_down"):
		velocity.y += 1
	if Input.is_action_pressed("emotion_move_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$SpritePlayerEmotion.play()
	else:
		$SpritePlayerEmotion.stop()
	position += velocity * delta
	if velocity.x != 0:
		$SpritePlayerEmotion.animation = "walk"
	else:
		$SpritePlayerEmotion.animation = "idle"
