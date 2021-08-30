extends Node


var testData

#var	chatGlobalCode
#var	chatNo
#var	chatBackground
#var	chatType
#var	chatLine
#var	chatCharName
#var	chatCharFrame
#var	chatPost
#var	chatJump
#var	chatReturnValue
#var	chatText


func _ready():
	testData = LoadFileData("res://data/test01.json")
#	print(testData)	
#	print(testData["111"] )

	
func LoadFileData(FilePath):
	var DataFile = File.new()
	var DataJSon

	DataFile.open(FilePath, File.READ)
	DataJSon = JSON.parse(DataFile.get_as_text())
	DataFile.close()
	return DataJSon.result
	
func getMaxChatNo(chatGlobalCode :String):
	return len(testData[chatGlobalCode])

func getChatType(chatGlobalCode: String , chatNo: int):
	return testData[chatGlobalCode][chatNo]["chatType"]

func getMaxChatLine(chatGlobalCode: String , chatNo: int): 
	return len(testData[chatGlobalCode][chatNo]["dialog"]) - 1

func getChatCharName(chatGlobalCode: String , chatNo: int, chatLine: int): 
	return testData[chatGlobalCode][chatNo]["dialog"][chatLine]["chatCharName"]

func getChatText(chatGlobalCode: String , chatNo: int, chatLine: int): 
	return testData[chatGlobalCode][chatNo]["dialog"][chatLine]["chatText"]

func checkKeyChatLineExist(keyName:String, chatGlobalCode: String , chatNo: int, chatLine: int):
	return keyName in testData[chatGlobalCode][chatNo]["dialog"][chatLine]
	
func getChatJump(chatGlobalCode: String , chatNo: int, chatLine: int): 
	return testData[chatGlobalCode][chatNo]["dialog"][chatLine]["chatJump"]
