extends VSlider

func _on_value_changed(value):
	$"../../../2D/page".region_rect = Rect2(0, value, 199, 260 )
