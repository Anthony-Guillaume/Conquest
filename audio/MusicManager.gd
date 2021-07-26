extends Node

const pathToAudio : String = "res://audio/musics/"
const musicExtension : String = "ogg"
const importExtension : String = "import"

var currentMusic : String = ""

func _ready() -> void:
	loadMusicFilesInDirectory(pathToAudio)
	for music in get_children():
		music.connect("finished", self, "playRandomMusic")

func loadMusicFilesInDirectory(path : String) -> void:
	for musicFile in getFilesInDirectory(path):
		loadMusicFile(musicFile)

func loadMusicFile(file : String) -> void:
	if not file.begins_with(".") and file.get_extension() == musicExtension:
		addMusic(pathToAudio, file)

func getFilesInDirectory(path : String) -> Array:
	var directory = Directory.new()
	directory.open(path)
	directory.list_dir_begin()
	var files : Array = []
	var file : String = directory.get_next()
	while file != "":
		if file.get_extension() == importExtension: # IMPORTANT POUR L'EXPORTATION DE PROJET !!!
			file = file.get_basename() # Retire l'extention .import
		if not files.has(file):
			files.push_back(file)
		file = directory.get_next()
	directory.list_dir_end()
	return files

func addMusic(path : String, file : String) -> void:
	var music : AudioStreamPlayer = AudioStreamPlayer.new()
	music.set_bus("Music")
	music.set_stream(load(path + file))
	music.name = file.get_basename()
	add_child(music)

func playRandomMusic() -> void:
	var musicIndex : int = randi() % get_child_count()
	currentMusic = get_child(musicIndex).name
	get_child(musicIndex).play()

func play(musicName : String) -> void:
	print("Playing ", musicName)
	currentMusic = musicName
	var music : AudioStreamPlayer = get_node(musicName)
	music.play()

func stop() -> void:
	if currentMusic != "":
		get_node(currentMusic).stop()

func _on_music_finished() -> void:
	playRandomMusic()
