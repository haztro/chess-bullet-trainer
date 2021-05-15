extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func show_and_hold(value, win):
	visible = 1
	disabled = 0
	$Label.text = value
	$Label.rect_position.x = -$Label.rect_size.x / 2 + rect_size.x / 2
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 1, 0.2, 0, 1)
	$Tween.start()

func hide_button():
	disabled = 1
	visible = 0
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 0, 0.2, 0, 1)
	$Tween.start()
