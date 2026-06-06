extends CharacterBody2D

@export var speed = 400.0 # How fast the player will move (pixels/sec).
@export var jump_velocity = -600.0 # Negative because up is negative in Godot Y-axis

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var screen_size # Size of the game window.
@onready var pReason = $"../PlayerReason"
@onready var cameraEmotion = $"../Camera2DEmotion"
@onready var mainView = $"../../../../.."
@onready var spritePlayerEmotion = $SpritePlayerEmotion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	spritePlayerEmotion.play()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("emotion_move_up") and is_on_floor():
		velocity.y = jump_velocity

	var direction = 0
	if Input.is_action_pressed("emotion_move_right"):
		direction += 1
	if Input.is_action_pressed("emotion_move_left"):
		direction -= 1
		
	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if mainView.camera_split:
		move_and_slide()
	else:
		var next_x = position.x + velocity.x * delta
		if abs(next_x - pReason.position.x) < (mainView.get_viewport().size.x) - 100:
			move_and_slide()
		else:
			var temp_velocity_x = velocity.x
			velocity.x = 0 
			move_and_slide()
			velocity.x = temp_velocity_x

	if velocity.x > 0:
		spritePlayerEmotion.flip_h = false
		spritePlayerEmotion.animation = "walk"
	elif velocity.x < 0:
		spritePlayerEmotion.flip_h = true
		spritePlayerEmotion.animation = "walk"
	else:
		spritePlayerEmotion.animation = "idle"
