extends Node2D


var panel = preload("res://ui/BackgroundPanel.tscn")
var num_tiles = 16
var target = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	var window_size = OS.get_window_size()
	$GridContainer.columns = num_tiles
	var tile_size = ceil(OS.get_window_size().x / (num_tiles - 1))
	
	for y in range(num_tiles):
		for x in range(num_tiles):
			var p = panel.instance()
			if (x + y) % 2 == 0:
				p.modulate = Color(0.34375, 0.225586, 0.171875)
			else:
				p.modulate =Color(0.953125, 0.876568, 0.778137)
			$GridContainer.add_child(p)

	get_tree().get_root().connect("size_changed", self, "_on_viewport_size_changed")
	_on_viewport_size_changed()
	
	var d = get_global_mouse_position() - (OS.get_window_size() / 2)
	d *= 0.05
	target = -d
	$GridContainer.rect_position = target
	
func _on_viewport_size_changed():
	var tile_size = ceil(OS.get_window_size().x / num_tiles) 
	$GridContainer.rect_size.x = OS.get_window_size().x + tile_size * 2
	$GridContainer.rect_size.y = OS.get_window_size().x + tile_size * 2
	position = -Vector2.ONE * tile_size
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var d = get_global_mouse_position() - (OS.get_window_size() / 2)
	d *= 0.05
	target = -d
	
	$GridContainer.rect_position += (target - $GridContainer.rect_position) * 0.1
