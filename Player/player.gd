extends CharacterBody2D


const SPEED = 110.0
const JUMP_VELOCITY = -300.0
const SLIDE_SPEED = 150.0

@onready var animated_sprite_2d = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle Movement Input
	var input_axis = Input.get_axis("ui_left", "ui_right")
	if input_axis:
		velocity.x = input_axis * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Check for sliding on slopes
	if is_on_floor() and get_floor_normal().y < 1.0:  # Verifica se está em rampa
		velocity.x += get_floor_normal().x * SLIDE_SPEED  # Ajusta a velocidade para escorregar

	move_and_slide()
	update_animations(input_axis)


func update_animations(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = input_axis < 0
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
		
	if not is_on_floor():
		animated_sprite_2d.play("jump")
