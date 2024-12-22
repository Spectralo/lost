extends MarginContainer

@onready var button_scene = preload("res://scenes/input_btn.tscn")
@onready var action_list = $VBoxContainer

var is_remapping = false
var action_to_remap = null
var remapping_button = null

func _ready():
	_create_action_list()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _create_action_list():
	InputMap.load_from_project_settings()
	
	for item in action_list.get_children():
		item.queue_free()
		
	for action in InputMap.get_actions():
		var button = button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_label = button.find_child("LabelInput")
		
		action_label.text = action
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
			
		if not action_label.text.contains("ui"):
			action_list.add_child(button)
			button.pressed.connect(_on_input_button_pressed.bind(button,action))

func _on_input_button_pressed(button,action):
	print("hery0")
	if !is_remapping:
		print("remazppig")
		is_remapping = true
		action_to_remap = action 
		remapping_button = button
		button.find_child("LabelInput").text = "Press key to bind..."
		
func _input(event):
	if is_remapping:
		if (
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_list(remapping_button, event)
			
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			
			accept_event()
			
func _update_list(button, event):
	button.find_child("LabelInput").text = event.as_text().trim_suffix(" (Physical)")
