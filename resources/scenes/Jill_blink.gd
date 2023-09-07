extends AnimatedSprite2D

var stop_anim = false


func _ready():
	while(!stop_anim):
		play("default")
		await get_tree().create_timer(6.0).timeout


func _on_animation_finished():
	frame = 0
	stop()
