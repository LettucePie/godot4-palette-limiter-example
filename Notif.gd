extends Control

@onready var spinner : TextureProgressBar = $TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spinner.radial_initial_angle += 0.1


func _on_processed_start():
	self.show()


func _on_processed_done():
	self.hide()
