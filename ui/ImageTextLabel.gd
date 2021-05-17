extends MarginContainer


export(Texture) var tex = null
export(String) var label = ""

func _ready():
	$HBoxContainer/TextureRect.texture = tex
	$HBoxContainer/Label.text = label

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_value(value):
	$HBoxContainer/Label2.text = str(value)
