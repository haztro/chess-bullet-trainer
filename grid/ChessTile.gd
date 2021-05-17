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
	$ColorRect.rect_size = rect_size
	$Label.rect_scale = rect_size * 0.06 / 16
	$Label2.rect_scale = rect_size * 0.06 / 16
	var font = $Label.get_font("font")
	
	if pos.y == 7:
		$Label.visible = 1
		if GameData.white:
			$Label.text = "ABCDEFGH"[pos.x]
		else:
			$Label.text = "ABCDEFGH"[7 - pos.x]
		$Label.rect_position.x = rect_size.x - font.get_string_size(str(pos.x)).x * $Label.rect_scale.x - 1
		$Label.rect_position.y = rect_size.y - font.get_height() * $Label.rect_scale.x - 1
	if pos.x == 0:
		$Label2.visible = 1
		if GameData.white:
			$Label2.text = str(7 - pos.y + 1)
		else:
			$Label2.text = str(pos.y + 1)
		$Label2.rect_position.x = 1
		$Label2.rect_position.y = 1
		
	if GameData.coords == 0:
		$Label.visible = 0
		$Label2.visible = 0
	

func spawn():
	safe = 1

func _on_TextureButton_pressed():
	emit_signal("button_pressed", self)
