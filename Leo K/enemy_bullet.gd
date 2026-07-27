extends Area2D

var bullet_scene = preload("res://Leo K/Single projectile.png")

@export var speed = 150

func start(pos):
	position = pos

func _process(delta):
	position.y += speed * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area.name == "Player":
		queue_free()

func _on_shoot_timer_timeout():
	var b = bullet_scene.instantiate()
	get_tree().root.add_child(b)
	b.start(position)
	$ShootTimer.wait_time = randf_range(4, 20)
	$ShootTimer.start()
