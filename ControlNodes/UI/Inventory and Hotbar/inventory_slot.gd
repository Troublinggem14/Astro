extends Control  # Each inventory slot is its own UI control node

signal slot_clicked(item, amount)
# Emitted when this slot is clicked.
# Passes the item + amount so parent UI doesn't need to inspect internal variables.


@onready var icon: TextureRect = $Icon
@onready var label: Label = $Amount
# Cached references to child UI elements for performance and cleaner code


var item: Item = null   # The resource stored in this slot
var amount: int = 0     # Quantity of that item


func set_item(new_item: Item, new_amount: int):
	# Updates this slot with new data from inventory
	
	item = new_item
	amount = new_amount

	# Assign the icon texture from the Item resource
	icon.texture = item.icon
	
	# Convert amount to string for label display
	label.text = str(amount)

	# Ensure visuals are visible when slot contains data
	icon.visible = true
	label.visible = true


func clear():
	# Resets slot to empty state
	
	item = null
	amount = 0

	# Remove visual data
	icon.texture = null
	label.text = ""

	# Hide visuals instead of leaving empty placeholders
	icon.visible = false
	label.visible = false


func _gui_input(event):
	# _gui_input only fires when interacting with this Control node
	# Unlike _input, this is UI-specific and respects mouse filtering

	if event is InputEventMouseButton and event.pressed:
		if item != null:
			# Emit signal upward instead of handling logic here.
			# This keeps the slot reusable and logic-agnostic.
			emit_signal("slot_clicked", item, amount)
		else:
			print("Null")
