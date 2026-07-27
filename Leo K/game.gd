extends Node2D

var enemy = preload("res://Leo K/umbrella_2.tscn")
var score = 0

var viewportSize

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewportSize = get_viewport_rect().size
	print(viewportSize)
	#spawn_enemies()

func spawn_enemies():
	for x in range (4): ##for x in range(9):
		for y in range(3):
			var e = enemy.instantiate()
			var pos = Vector2(x * (16 + 8) + 24, 16 * 4 + y * 16)
			add_child(e)
			e.start(pos)
			e.died.connect(_on_enemy_died)

func _on_enemy_died(value):
	score += value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	# Spawn here
	var e = enemy.instantiate()
	var pos = Vector2(randf_range(-viewportSize.x/2, viewportSize.x/2), -viewportSize.y/2)
	add_child(e)
	#e.start(pos)
	e.position = pos
	e.speed = 75
	e.died.connect(_on_enemy_died)
