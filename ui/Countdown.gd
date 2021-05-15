extends Label

signal countdown_finished

var time = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func start():
	$Timer.start()

func show_label():
	text = str(time)
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 1, 0.3, 0, 1)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 1, 0.3, 0, 1)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 0, 0.3, 0, 1)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	
	if time < 1:
		emit_signal("countdown_finished")
		time = 3
		$Timer.stop()
		


func _on_Timer_timeout():
	show_label()
	time -= 1

	
