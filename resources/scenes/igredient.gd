extends Node2D

@export var igredient_name: String
@export var rest_pos: Vector2

var dragging = false
var inShaker = false

func Grabbed(viewport, event, shape_idx):
	if (Input.is_action_just_pressed("LMB") && $"../../..".GetTotalIgredientsNum() < 20):
		dragging = true

func _physics_process(delta):
	if (dragging):
			global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
			global_position.x = clamp(global_position.x, 732, 1228)
			global_position.y = clamp(global_position.y, 226, 498)
	else:
		if(inShaker):
			$"../../../sfx".stream = load("res://resources/Exported_Sounds/audiogroup_default/addingredient.ogg")
			$"../../../sfx".play()
			match igredient_name:
				"karmotrine":
					$"../../..".karmotrine += 1
					for i in range(1, $"../../..".karmotrine + 1):
						if(i <= 10):
							get_node("../../karmotrine/slot" + str(i)).modulate = "ffffff"
						else:
							get_node("../../karmotrine/slot" + str(i)).visible = true
					print($"../../..".karmotrine)
				"adelhyde":
					$"../../..".adelhyde += 1
					for i in range(1, $"../../..".adelhyde + 1):
						if(i <= 10):
							get_node("../../adelhyde/slot" + str(i)).modulate = "ffffff"
						else:
							get_node("../../adelhyde/slot" + str(i)).visible = true
					print($"../../..".adelhyde)
				"flanergide":
					$"../../..".flanergide += 1
					for i in range(1, $"../../..".flanergide + 1):
						if(i <= 10):
							get_node("../../flanergide/slot" + str(i)).modulate = "ffffff"
						else:
							get_node("../../flanergide/slot" + str(i)).visible = true
					print($"../../..".flanergide)
				"bronson":
					$"../../..".bronson += 1
					for i in range(1, $"../../..".bronson + 1):
						if(i <= 10):
							get_node("../../bronson/slot" + str(i)).modulate = "ffffff"
						else:
							get_node("../../bronson/slot" + str(i)).visible = true
					print($"../../..".bronson)
				"delta":
					$"../../..".delta += 1
					for i in range(1, $"../../..".delta + 1):
						if(i <= 10):
							get_node("../../delta/slot" + str(i)).modulate = "ffffff"
						else:
							get_node("../../delta/slot" + str(i)).visible = true
						print($"../../..".delta)
			for i in range(1, $"../../..".GetTotalIgredientsNum() + 1):
				if(i > 0):
					get_node("../../totalIngs/slot" + str(i)).visible = true
					
		global_position = rest_pos
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			dragging = false


