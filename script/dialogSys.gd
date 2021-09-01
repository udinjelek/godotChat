extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mouseClickBtn = false
var point = 0
var maxChatNo
var maxChatLine


var	chatGlobalCode
var	chatNo
var	chatBackground
var	chatType
var	chatLine
var	chatCharName
var	chatCharFrame
var	chatPost
var	chatJump
var	chatReturnValue
var	chatText:String

var choiceChatJump = [null,-1,-1,-1]
var blackScrrenSpeed = 30

var valid_nextLinePoint
var splashScreenMode = 0 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if ( Input.is_action_just_pressed("chatTextBoxNext") or mouseClickBtn == true ) \
		 and self.visible == true \
		 and chatType == "normal" \
		 and splashScreenMode == 0:
			mouseClickBtn = false
			nextProcess()
	
	if len($TextBox/ChatText.text) < len(chatText):
		$TextBox/ChatText.text = chatText.left(len($TextBox/ChatText.text) + 1)
	
	if splashScreenMode != 0 :
#		print($BlackScreen.rect_position.x)
		$BlackScreen.rect_position.x -= blackScrrenSpeed
		if $BlackScreen.rect_position.x <= -500 and splashScreenMode == 1:
			splashScreenMode = 2
			nextProcess()
		elif $BlackScreen.rect_position.x < -2200:
			splashScreenMode = 0
			$BlackScreen.visible = false
		

func startProcess(chatGlobalCodeUse):
	chatGlobalCode = chatGlobalCodeUse
	maxChatNo = LoaderText.getMaxChatNo(chatGlobalCode)
	chatNo = 0
	maxChatLine = LoaderText.getMaxChatLine(chatGlobalCode,chatNo)
	chatLine = 0
	chatType = LoaderText.getChatType(chatGlobalCode,chatNo)
	
	self.visible = true
	if LoaderText.getMaxChatNo(chatGlobalCode) >0:
		generateChatOutput()


func nextProcess():
	#	print(choiceChatJump)
	# jika ada jump point dari step sebelumnya, maka jump di lakukan di sini, 
	# sehingga generate output chat sudah sesuai dengan data terbaru
	if choiceChatJump[0] != null :
		calculateJumpPoint()
		choiceChatJump[0] = null 
		
	#	print(maxChatNo, " ",chatNo," ",maxChatLine , " ", chatLine )
	valid_nextLinePoint = false
	calculateNextLinePoint()
	if valid_nextLinePoint == true:
		generateChatOutput()

func calculateNextLinePoint():
	## calculate chatLine + 1, if over chatNo + 1, if over again stop ##
	if chatNo + 1 > maxChatNo:
		quitProcess()
	elif maxChatLine == -1:
		maxChatLine = LoaderText.getMaxChatLine(chatGlobalCode,chatNo)
		chatType = LoaderText.getChatType(chatGlobalCode,chatNo)
		nextProcess()
	elif chatLine + 1 > maxChatLine:
		chatLine = -1
		chatNo = chatNo + 1
		maxChatLine = -1
		nextProcess()
	else:
		chatLine = chatLine + 1
		valid_nextLinePoint = true
	
func quitProcess():
	self.visible = false

func generateChatOutput():
	if chatType == "normal":
		$TextBox/ChatCharName.text	= LoaderText.getChatCharName(chatGlobalCode,chatNo,chatLine)
		chatText = LoaderText.getChatText(chatGlobalCode,chatNo,chatLine)
		$TextBox/ChatText.text	= ""
		print(LoaderText.checkKeyChatLineExist("chatJump",chatGlobalCode,chatNo,chatLine))
	elif chatType == "question":
#		print(chatGlobalCode,chatNo,chatLine)
		$TextBox/ChatCharName.text	= LoaderText.getChatCharName(chatGlobalCode,chatNo,chatLine)
		chatText = LoaderText.getChatText(chatGlobalCode,chatNo,chatLine)
		$TextBox/ChatText.text	= LoaderText.getChatText(chatGlobalCode,chatNo,chatLine)
		generateChoiceOutput()
	elif chatType == "splashScreen":
		splashScreenMode = 1
		$BlackScreen.visible = true
		$BlackScreen.rect_position.x = 1200
		
func generateChoiceOutput():
	for arrChoice in range(1,maxChatLine + 1):
		get_node("Choice0" + str(arrChoice)).visible = true
		get_node("Choice0" + str(arrChoice) + "/ChatText").text =  LoaderText.getChatText(chatGlobalCode,chatNo,arrChoice)
		choiceChatJump[arrChoice] =  int(LoaderText.getChatJump(chatGlobalCode,chatNo,arrChoice))

func _on_NextBtn_button_down():
	mouseClickBtn = true

func _on_NextBtn_button_up():
	mouseClickBtn = false

func _on_ChoiceBtn_sendChoiceAnswered(obj):
	chatType = "Normal"
	hideAllChoice()
	var choiceAnswered:int = int(obj[-1])
#	send value array choiceChatJump, based on button click,  int(obj[-1]) -> right 1 of choiceBtn Name Clicked-> noChoiceClicked
	choiceChatJump[0] = choiceChatJump[choiceAnswered]
	
	nextProcess()
	
func calculateJumpPoint():
	chatJump = choiceChatJump[0]
	if chatJump == -1:
		quitProcess()
	else:
		chatNo = chatJump
		maxChatLine = LoaderText.getMaxChatLine(chatGlobalCode,chatNo)
		chatType = LoaderText.getChatType(chatGlobalCode,chatNo)
		chatLine = -1
		
func hideAllChoice():
	for arrChoice in range(1,4):
		get_node("Choice0" + str(arrChoice) + "/ChatText").text =  "-"
		get_node("Choice0" + str(arrChoice )).visible = false
		
