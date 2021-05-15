extends MarginContainer

signal countdown_finished

var time = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(delta):
	rect_size = get_parent().rect_size
	rect_position = Vector2.ZERO

func start():
	time = 3
	mouse_filter = Control.MOUSE_FILTER_STOP
	show_label()
	$Timer.start()

func show_label():
	$Label.text = str(time)
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 1, 0.3, 0, 1)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 1, 0.3, 0, 1)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 0, 0.3, 0, 1)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	
	if time <= 1:
		emit_signal("countdown_finished")
		time = 3
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		$Timer.stop()
		

func _on_Timer_timeout():
	time -= 1
	show_label()

	
