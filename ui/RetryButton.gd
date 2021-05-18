extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ColorRect.rect_position.x = -rect_position.x
	$ColorRect.rect_position.y = -150
	$ColorRect.rect_size.x = get_parent().rect_size.x
	$ColorRect.rect_size.y = 220
	
	if Input.is_action_just_pressed("skip") and !disabled:
		emit_signal("pressed")


func show_and_hold(value, win):
	mouse_filter = Control.MOUSE_FILTER_STOP
	visible = 1
	disabled = 0
	$Node2D/Label.text = value
	var font = $Node2D/Label.get_font("font")
	
	$Node2D.position.x = -font.get_string_size(value).x / 2 + rect_size.x / 2
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 1, 0.2, 0, 1)
	$Tween.start()

func hide_button():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	disabled = 1
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 0, 0.2, 0, 1)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	visible = 0
