extends AnimatedSprite2D

var stopAnim: bool = false

func _ready():
	while(!stopAnim):
		play("default")
		await get_tree().create_timer(6.0).timeout

func _on_animation_finished():
	frame = 0
	stop()
