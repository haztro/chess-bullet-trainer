extends PanelContainer


export(String) var text = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = text


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func show_tip():
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 1, 0.2, 0, 1)
	$Tween.start()
	
func hide_tip():
	$Tween.interpolate_property(self, "modulate:a", modulate.a, 0, 0.2, 0, 1)
	$Tween.start()
