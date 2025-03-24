extends Control
## Shader Designer
## DrManatee
## https://godotshaders.com/shader/palette-limiter-shader/

## Palette Designer
## GrafxKid
## https://lospec.com/palette-list/sweetie-16

@export var palette_strip : Texture
@export var color_count : int = 16
@export var image_a : Texture
@export var image_b : Texture
@export var image_c : Texture

@onready var result_a_node : TextureRect = $Vert/Work/SampleA/AfterImage
@onready var result_b_node : TextureRect = $Vert/Work/SampleB/AfterImage
@onready var result_c_node : TextureRect = $Vert/Work/SampleC/AfterImage


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
