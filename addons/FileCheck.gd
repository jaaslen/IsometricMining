@tool
extends EditorScript

func _run():
	var scene_root = EditorInterface.get_edited_scene_root()
	if not scene_root:
		print("No scene is currently open.")
		return

	var null_issues = []
	_check_nulls(scene_root, null_issues)

	if null_issues.size() == 0:
		print("✅ All nodes are valid!")
	else:
		print("⚠️ Null references detected:")
		for issue in null_issues:
			print(" • " + issue)

func _check_nulls(node: Node, null_issues: Array) -> void:
	# Check children
	for child in node.get_children():
		if child == null:
			null_issues.append(str(node) + " has a null child!")
		else:
			_check_nulls(child, null_issues)

	# Check NodePath variables in attached script (if any)
	var script = node.get_script()
	if script != null:
		for v in script.get_property_list():
			if v.name.ends_with("_path"):
				var path = node.get(v.name)
				if typeof(path) == TYPE_NODE_PATH and not node.has_node(path):
					null_issues.append(str(node) + ": missing node at path '" + str(path) + "'")
