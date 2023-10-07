extends Node2D

@export var igredient_name: String
@export var rest_pos: Vector2

var dragging = false
var inShaker = false

func Grabbed(viewport, event, shape_idx):
	if Input.is_action_just_pressed("LMB"):
		dragging = true

func _physics_process(delta):
	if (dragging):
			global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
			global_position.x = clamp(global_position.x, 732, 1228)
			global_position.y = clamp(global_position.y, 226, 498)
	else:
		if(inShaker):
			$"../../sfx".stream = load("res://resources/Exported_Sounds/audiogroup_default/addingredient.ogg")
			$"../../sfx".play()
			match igredient_name:
				"karmotrine":
					$"../..".karmotrine += 1
					print($"../..".karmotrine)
				"adelhyde":
					$"../..".adelhyde += 1
					print($"../..".adelhyde)
				"flanerhyde":
					$"../..".flanerhyde += 1
					print($"../..".flanerhyde)
				"bronson":
					$"../..".bronson += 1
					print($"../..".bronson)
				"delta":
					$"../..".delta += 1
					print($"../..".delta)
		global_position = rest_pos
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			dragging = false


