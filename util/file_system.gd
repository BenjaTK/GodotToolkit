class_name FileSystem
extends Object


const RESOURCE_EXTENSIONS := ["res", "tres"]
const SCENE_EXTENSIONS := ["tscn", "scn", "res"]

## Returns an [Array] with all [PackedScene]s from the folder in [param path] instantiated as [Node]s.
static func instantiate_scenes_in_folder(path: String, recursive: bool = false) -> Array[Node]:
	var instantiated_scenes: Array[Node] = []
	var file_paths := get_files_in_folder(path, recursive).filter(is_file_scene)
	for file in file_paths:
		var scene = load(file)
		if scene is PackedScene:
			instantiated_scenes.append(scene.instantiate())

	return instantiated_scenes


## Returns an [Array] with all [Resource]s from the folder in [param path] loaded.
static func load_resources_in_folder(path: String, recursive: bool = false) -> Array[Resource]:
	var resources: Array[Resource] = []
	var file_paths := get_files_in_folder(path, recursive).filter(is_file_resource)
	for file in file_paths:
		var resource = load(file)
		if resource is Resource:
			resources.append(resource)

	return resources


## Returns an [Array] with all files from the folder in [param path] loaded.
## The [param file_filter]'s method should take one [Variant] parameter (the file path) and return a boolean value.
## If it returns [code]true[/code], it keeps the element in the array. For example, return true if the file path ends with ".png".
static func load_files_in_folder(path: String, recursive: bool = false, file_filter: Callable = Callable()) -> Array:
	var result: Array = []
	var file_paths := get_files_in_folder(path, recursive)
	if file_filter.is_valid():
		file_paths = file_paths.filter(file_filter)

	for file in file_paths:
		var loaded = load(file)
		if loaded != null:
			result.append(loaded)

	return result


static func get_files_in_folder(path: String, recursive: bool = false) -> Array[String]:
	if not path.ends_with("/"):
		path += "/"

	var files: Array[String] = []
	var dir := DirAccess.open(path)
	if dir == null:
		push_error(error_string(DirAccess.get_open_error()))
		return []

	dir.list_dir_begin()
	var file_name := dir.get_next()
	while file_name != "":
		if file_name.ends_with(".import"):
			continue
		var file_path = path + file_name
		if dir.current_is_dir():
			if recursive:
				files.append_array(get_files_in_folder(file_path))
		else:
			files.append(file_path)
		file_name = dir.get_next()

	return files


## Returns [code]true[/code] if the [param path]'s extension is a [PackedScene] extension.
static func is_file_scene(path: String) -> bool:
	return path.get_extension() in SCENE_EXTENSIONS


## Returns [code]true[/code] if the [param path]'s extension is a [Resource] extension.
static func is_file_resource(path: String) -> bool:
	return path.get_extension() in RESOURCE_EXTENSIONS
