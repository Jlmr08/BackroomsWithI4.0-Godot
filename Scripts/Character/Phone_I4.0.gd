class_name Phone_I40 extends Node

enum PromptUtility
{
	File_FromLocalStorage,
	File_TakePicture,
	Conversation_Delete,
	Tool_SearchTxt,
	Tool_SearchImg
}

@export_category("Prompt area")
@export var Prompt_Text: TextEdit = null
@export var Prompt_UtilitiesBtn: MenuButton = null
@export var Prompt_Utilities: Dictionary[int, PromptUtility] = {}
@export var Prompt_FilesContainer: Container = null
@export var Prompt_SendMsg: Button = null
var CurrentText: String = ""
var CurrentFiles: Array[PackedByteArray] = []

@export_category("Message area")
@export var MessagesContainer: Container = null

@export_category("Conversation")
var Conversation: Array = []

func __on_pressed_utilities_btn__(PressedIdx: int) -> void:
	if (Prompt_UtilitiesBtn.get_popup().is_item_checkable(PressedIdx)):
		Prompt_UtilitiesBtn.get_popup().set_item_checked(PressedIdx, !Prompt_UtilitiesBtn.get_popup().is_item_checked(PressedIdx))
	
	var utility = Prompt_Utilities.get(PressedIdx, null)
	
	if (utility == null):
		push_warning("Button %s is not in the utility list. Ignoring." % PressedIdx)
		return
	
	if (utility == PromptUtility.File_FromLocalStorage):
		pass  # TODO
	elif (utility == PromptUtility.File_TakePicture):
		pass  # TODO
	elif (utility == PromptUtility.Conversation_Delete):
		pass  # TODO
	elif (utility == PromptUtility.Tool_SearchTxt):
		pass  # TODO
	elif (utility == PromptUtility.Tool_SearchImg):
		pass  # TODO
	else:
		push_warning("Invalid utility.")
		return

func __on_pressed_send_btn__() -> void:
	for fileNode in Prompt_FilesContainer.get_children(false):
		if (fileNode.name == "FilePlaceholder"):
			continue
		
		fileNode.queue_free()
	
	Prompt_Text.text = ""
	
	#await __send_to_I40__()  # TODO
	
	CurrentText = ""
	CurrentFiles.clear()

func __create_message__(Role: StringName, TextContent: String, Files: Array[PackedByteArray]) -> void:
	var clonedMsg = MessagesContainer.find_child("MessagePlaceholder", false, true).duplicate()
	clonedMsg.name = "Message %s" % MessagesContainer.get_children(false).size()
	
	var roleLbl: Label = clonedMsg.get_child(0).get_child(0)
	var contentTxt: RichTextLabel = clonedMsg.get_child(0).get_child(1)
	var contentImgContainer: Control = clonedMsg.get_child(0).get_child(2).get_child(0)
	
	roleLbl.text = Role
	contentTxt.text = ""
	
	for file in Files:
		pass  # TODO
	
	MessagesContainer.add_child(clonedMsg)

func __send_to_I40__(Conversation: Array) -> void:
	pass  # TODO

func _ready() -> void:
	Prompt_UtilitiesBtn.get_popup().id_pressed.connect(__on_pressed_utilities_btn__)
