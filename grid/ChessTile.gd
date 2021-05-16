extends TextureButton


signal button_pressed(btn)


var safe = 0
var pos = Vector2.ZERO
var colour1 = Color(1, 1, 1, 1)
var colour2 = Color(0, 0, 0, 1)

var piece = null


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.color = colour1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ColorRect.rect_size = rect_size - Vector2(1, 1)

func spawn():
	pass

func _on_TextureButton_pressed():
	emit_signal("button_pressed", self)
