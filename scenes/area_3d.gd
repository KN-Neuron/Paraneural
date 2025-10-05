extends Area3D

# 1. Declare the variable for the array here, but don't fill it yet.
var spawn_positions = []

# 2. Use the _ready() function to safely get the nodes.
# This function is called automatically by Godot after the node enters the scene tree.
func _ready():
	# Now that we are inside a function and the node is "ready",
	# we can safely use the '$' shorthand to get the child nodes
	# and populate our array.
	spawn_positions = [
		$Area3D,
		$Area3D2,
		$Area3D3,
		$Area3D4,
		$Area3D5,
		$Area3D6
	]

# 3. This function will now work perfectly because the array was set up in _ready().
func _on_body_entered(body):
	if not spawn_positions.is_empty():
		var random_position_node = spawn_positions.pick_random()
		body.global_position = random_position_node.global_position
