extends Control
## Processed method for Palette Limiting
## LettucePie

@export var color_palette : PackedColorArray = [Color.AQUA, Color.CORAL, Color.DARK_GOLDENROD, Color.BEIGE]
@export var image_a : Texture2D
@export var image_b : Texture2D
@export var image_c : Texture2D

@onready var color_square_preset : ColorRect = $Vert/Colors/ColorSquare
@onready var color_square_list : Control = $Vert/Colors
@onready var result_a_node : TextureRect = $Vert/Work/SampleA/AfterImage
@onready var result_b_node : TextureRect = $Vert/Work/SampleB/AfterImage
@onready var result_c_node : TextureRect = $Vert/Work/SampleC/AfterImage


# Called when the node enters the scene tree for the first time.
func _ready():
	build_color_squares()
	result_a_node.texture = limit_image(image_a, color_palette)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func build_color_squares():
	var count : int = 0
	for c in color_palette:
		if count == 0:
			color_square_preset.color = c
		else:
			var new_square : ColorRect = color_square_preset.duplicate()
			new_square.color = c
			color_square_preset.get_parent().add_child(new_square)
		count += 1


func limit_image(tex : Texture2D, pal : PackedColorArray) -> Texture:
	var result : Texture = null
	
	var img : Image = tex.get_image()
	
	
	return result
