extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show_label(value):
	text = value
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 1, 0.2, 0, 1)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 1, 0.1, 0, 1)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 0, 0.2, 0, 1)
	$Tween.start()
	yield($Tween, "tween_all_completed")

func show_and_hold(value):
	text = value
	$Tween.stop_all()
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 1, 0.2, 0, 1)
	$Tween.start()

func hide_label():
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 0, 0.2, 0, 1)
	$Tween.start()
