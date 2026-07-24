extends CharacterBody2D


const SPEED = 300.0

var last_direction: Vector2 = Vector2.RIGHT	

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


@export var cooldown = 0.25
@export var bullet_scene : PackedScene
var can_shoot = true

func _ready():
	start()

func start():
	#position = Vector2(screensize.x / 2, screensize.y - 64)
	$GunCooldown.wait_time = cooldown

func shoot():
	print("Start shoot")
	if not can_shoot:
		return
	can_shoot = false
	$GunCooldown.start() 
	
	print("Spawn bullet")
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(position + Vector2(0, -8))

func _process(_delta):
	if Input.is_action_pressed("shoot"):
	#if Input.is_key_pressed(KEY_Z):
		shoot()
		

func _on_gun_cooldown_timeout():
	can_shoot = true



func _physics_process(_delta: float) -> void:
	process_movement()
	process_animation()
	move_and_slide()

func process_movement() -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction = direction
	else:
		velocity = Vector2.ZERO
	
	
func process_animation() -> void:
	if velocity != Vector2.ZERO:
		play_animation("run", last_direction)
	else:
		play_animation("idle", last_direction)
	
	
func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x != 0:
		animated_sprite_2d.flip_h = dir.x < 0
		animated_sprite_2d.play(prefix + "_right")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_up")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_down")
