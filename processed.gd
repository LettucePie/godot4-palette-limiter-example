extends Control
## Processed method for Palette Limiting
## LettucePie

@export var color_palette : PackedColorArray
@export var image_a : Texture2D
@export var image_b : Texture2D
@export var image_c : Texture2D

@onready var color_square_preset : ColorRect = $Vert/Top/Colors/ColorSquare
@onready var color_square_list : Control = $Vert/Top/Colors
@onready var hue_toggle : Button = $Vert/Top/HueToggle
@onready var result_a_node : TextureRect = $Vert/Work/SampleA/AfterImage
@onready var result_b_node : TextureRect = $Vert/Work/SampleB/AfterImage
@onready var result_c_node : TextureRect = $Vert/Work/SampleC/AfterImage

var prioritize_hue : bool = false
var skip_sat_val : bool = false

#var a_built : bool = false
#var b_built : bool = false
#var c_built : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	build_color_squares()
	build_images()


func build_images():
	result_a_node.texture = limit_image(image_a, color_palette)
	result_b_node.texture = limit_image(image_b, color_palette)
	result_c_node.texture = limit_image(image_c, color_palette)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func toggle_hue(val : bool):
	prioritize_hue = val
	build_images()


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
	var result : Texture2D = tex
	
	var img : Image = tex.get_image()
	var w : int = img.get_width()
	var h : int = img.get_height()
	for x in w:
		for y in h:
			var pix_color : Color = img.get_pixel(x, y)
			if prioritize_hue:
				img.set_pixel(x, y, closest_hue(pix_color, pal))
			else:
				img.set_pixel(x, y, closest_color(pix_color, pal))
	var new_tex : Texture2D = ImageTexture.create_from_image(img)
	result = new_tex
	
	return result


func closest_color(target : Color, pool : PackedColorArray) -> Color:
	var result = pool[0]
	
	var target_vec : Vector3 = Vector3(target.r, target.g, target.b)
	var shortest_distance : float = 4096
	for c in pool:
		var color_vec : Vector3 = Vector3(c.r, c.g, c.b)
		var distance : float = target_vec.distance_to(color_vec)
		if distance < shortest_distance:
			shortest_distance = distance
			result = c
	
	return result


func closest_hue(target : Color, pool : PackedColorArray) -> Color:
	var result = pool[0]
	
	var target_hue : float = target.h
	var smallest_difference : float = 4096
	for c in pool:
		var color_hue : float = c.h
		var diff : float = absf(target_hue - color_hue)
		## but what about 0.1 being red and 1.0 being red?
	
	return result
