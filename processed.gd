extends Control
## Processed method for Palette Limiting
## LettucePie


@export var color_palette : PackedColorArray
@export var image_a : Texture2D
@export var image_b : Texture2D
@export var image_c : Texture2D
@export_range(0.1, 0.5, 0.01) var hue_threshold : float = 0.25
@export_range(0.0, 2.0, 0.01) var gray_threshold : float = 1.1

@onready var color_square_preset : ColorRect = $Vert/Top/Colors/ColorSquare
@onready var color_square_list : Control = $Vert/Top/Colors
@onready var hue_toggle : Button = $Vert/Top/HueToggle

@onready var before_a_node : TextureRect = $Vert/Work/SampleA/BeforeImage
@onready var before_b_node : TextureRect = $Vert/Work/SampleB/BeforeImage
@onready var before_c_node : TextureRect = $Vert/Work/SampleC/BeforeImage
@onready var result_a_node : TextureRect = $Vert/Work/SampleA/AfterImage
@onready var result_b_node : TextureRect = $Vert/Work/SampleB/AfterImage
@onready var result_c_node : TextureRect = $Vert/Work/SampleC/AfterImage

var prioritize_hue : bool = false
var skip_sat_val : bool = false
var apply_alpha : bool = false

#var a_built : bool = false
#var b_built : bool = false
#var c_built : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	set_before()
	build_color_squares()
	call_deferred("build_images")


func set_before():
	before_a_node.texture = image_a
	before_b_node.texture = image_b
	before_c_node.texture = image_c


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


func toggle_alpha(val : bool):
	apply_alpha = val
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
	var result : Color = pool[0]
	
	var target_vec : Vector3 = Vector3(target.r, target.g, target.b)
	var shortest_distance : float = 4096
	for c in pool:
		var color_vec : Vector3 = Vector3(c.r, c.g, c.b)
		var distance : float = target_vec.distance_to(color_vec)
		if distance < shortest_distance:
			shortest_distance = distance
			result = c
	if apply_alpha:
		result.a = target.a
	
	return result


func closest_hue(target : Color, pool : PackedColorArray) -> Color:
	## Thank-you pauldrewett
	## https://forum.godotengine.org/t/how-to-calculate-the-difference-between-two-values-that-wrap-around/106354/2
	var result : Color = pool[0]
	
	var target_hue : float = target.h
	var target_sat : float = target.s
	var target_val : float = target.v
	#var grayscale : bool = target_sat + target_val <= 1.0
	var smallest_difference : float = 4096
	var largest_difference : float = 0.0
	var color_stats : Array = []
	for c in pool:
		var color_hue : float = c.h
		var diff : float = min(absf(target_hue - color_hue), 1 - absf(target_hue - color_hue))
		if diff < smallest_difference:
			smallest_difference = diff
		if diff > largest_difference:
			largest_difference = diff
		color_stats.append([c, diff])
	var threshold : float = lerpf(smallest_difference, largest_difference, hue_threshold)
	smallest_difference = 4096
	for stat in color_stats:
		var c_sat_val : float = stat[0].s + stat[0].v
		var t_sat_val : float = target.s + target.v
		var diff : float = min(absf(t_sat_val - c_sat_val), 2 - absf(t_sat_val - c_sat_val))
		if diff < smallest_difference:
			if t_sat_val <= gray_threshold and c_sat_val <= gray_threshold:
				smallest_difference = diff
				result = stat[0]
			elif stat[1] <= threshold:
				smallest_difference = diff
				result = stat[0]
	if apply_alpha:
		result.a = target.a
	
	return result
