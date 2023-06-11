extends Control

onready var _fetch = GotmLobbyFetch.new()
var network = NetworkedMultiplayerENet.new()
var ip = '127.0.0.1'
var port = 4099

func _ready():
	$LobbyList/HostButton.connect("clicked", self, "start_server")
	$LobbyList/Timer.connect("timeout", self, "refresh_lobbies")
	Gotm.connect("lobby_changed", self, "_on_lobby_changed")
	randomize()

func start_server():
	Gotm.host_lobby(false)
	Gotm.lobby.hidden = false
	var gamename = $LobbyList/HostName.get_text()
	if gamename == "":
		var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		for _i in range(4):
			gamename += chars[randi() % 26]
	Gotm.lobby.name = gamename
	
	Server.StartServer()
	
func join_game(lobby):
	var success = yield(lobby.join(), "completed")
	if success:
		network.create_client(ip, port)
		Server.ConnectToServer()
		get_tree().change_scene("res://Game.tscn")
	else:
		print("Error joining lobby")

func refresh_lobbies():
	var lobbies = yield(_fetch.first(10), "completed")

	for lobby in $LobbyList/Lobbies.get_children():
		if not lobby in lobbies:
			lobby.queue_free()
	
	for i in range(lobbies.size()):
		var lobby = lobbies[i]
		var node = $LobbyList/LobbyEntry.duplicate()
		node.show()
		$LobbyList/Lobbies.add_child(node)
		node.set_lobby(lobby)
		node.rect_position.y += i * 80
		node.get_node("Button").connect("clicked", self, "join_game", [lobby])

func _on_lobby_changed():
	print("lobby changed")
