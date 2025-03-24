extends Control

@onready var processed_scene : Control = $PanelContainer/Processed
@onready var shader_scene : Control = $PanelContainer/Shader

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func button(id : int):
	if id == 0:
		processed_scene.show()
		shader_scene.hide()
		processed_scene.set_process_mode(PROCESS_MODE_INHERIT)
		shader_scene.set_process_mode(PROCESS_MODE_DISABLED)
	elif id == 1:
		processed_scene.hide()
		shader_scene.show()
		processed_scene.set_process_mode(PROCESS_MODE_DISABLED)
		shader_scene.set_process_mode(PROCESS_MODE_INHERIT)
