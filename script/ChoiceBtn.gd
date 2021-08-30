extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal sendChoiceAnswered(obj)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ChoiceBtn_button_down():
	emit_signal("sendChoiceAnswered",get_parent().name)
	
	pass # Replace with function body.
