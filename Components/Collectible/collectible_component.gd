class_name CollectableComponent
extends Area2D  # Detects physics bodies entering pickup range

@export var item: Item  
# The Item resource this pickup represents (data-driven design)

@export var amount: int = 1  
# How many of the item this pickup gives


func _on_body_entered(body) -> void:
	# Triggered when another physics body enters this Area2D.
	# Requires signal "body_entered" to be connected to this method.

	if body is AstroClassName:
		# Ensures only the player (or specific class) can collect it.
		# Prevents enemies or other bodies from triggering pickup logic.

		if body.inventory.add_item(item, amount):
			# Attempt to add item to player's inventory.
			# add_item() returns true if successful (stacked or placed in empty slot).
			# Returns false if inventory is full.

			get_parent().queue_free()
			# Removes the world object ONLY if the item was successfully added.
			# Prevents losing items when inventory is full.
