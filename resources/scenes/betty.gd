extends DialogicPortrait

func _update_portrait(betty:DialogicCharacter, betty_emote:String) -> void:
	if betty_emote == "":
		betty_emote = betty['default_portrait']
	
	if $"2D/base".sprite_frames.has_animation(betty_emote):
		$"2D/base".play(betty_emote)
		$"2D/lips".play(betty_emote)
	if $"2D/eyes".sprite_frames.has_animation(betty_emote):
		$"2D/eyes".play(betty_emote)


func _ready():
	%dialog_text.started_revealing_text.connect(start_talking)
	%dialog_text.finished_revealing_text.connect(stop_talking)

func start_talking():
	$"2D/lips".play()

func stop_talking():
	$"2D/lips".stop()
	$"2D/lips".frame = 0
