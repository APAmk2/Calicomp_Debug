extends Node2D

@export var igredient_name: String
@export var rest_pos: Vector2

var dragging = false
var inShaker = false

func Grabbed(viewport, event, shape_idx):
	if (Input.is_action_just_pressed("LMB") && $"../../..".GetTotalIgredientsNum() < 20 && !$"../../..".GetDrinkInCurrSlot()):
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
					if($"../../../Hud/slot1Btn".button_pressed):
						$"../../..".drink_a[4] += 1
					else:
						$"../../..".drink_b[4] += 1
					$"../../..".CalcVis(false)
				"adelhyde":
					if($"../../../Hud/slot1Btn".button_pressed):
						$"../../..".drink_a[0] += 1
					else:
						$"../../..".drink_b[0] += 1
					$"../../..".CalcVis(false)
				"flanergide":
					if($"../../../Hud/slot1Btn".button_pressed):
						$"../../..".drink_a[3] += 1
					else:
						$"../../..".drink_b[3] += 1
					$"../../..".CalcVis(false)
				"bronson":
					if($"../../../Hud/slot1Btn".button_pressed):
						$"../../..".drink_a[1] += 1
					else:
						$"../../..".drink_b[1] += 1
					$"../../..".CalcVis(false)
				"delta":
					if($"../../../Hud/slot1Btn".button_pressed):
						$"../../..".drink_a[2] += 1
					else:
						$"../../..".drink_b[2] += 1
					$"../../..".CalcVis(false)
					
		global_position = rest_pos
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			dragging = false
