extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass





func _on_Button_button_up():
#	print(LoaderText.getLenGlobalChat("111"))
#	var x = LoaderText.getLenDialogChat("111",0)
#	for loop in range(0,x+1):
#		print(LoaderText.getCharNameChat("111",0,loop) , " says : ", LoaderText.getCharTextChat("111",0,loop))
#	
	get_node("../dialogSys").startProcess("111")
	
