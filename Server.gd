extends Node

var network = NetworkedMultiplayerENet.new()
var ip = '127.0.0.1'
var port = 4099

func _ready():
	network.connect("peer_connected", self, "_Peer_Connected")

func StartServer():
	network.create_server(port, 2)
	get_tree().set_network_peer(network)
	get_tree().change_scene("res://HostScreen.tscn")
	
func _Peer_Connected(player_id):
	print("Player " + str(player_id) + ' Connected')
	get_tree().change_scene("res://Game.tscn")

func ConnectToServer():
	network.create_client(ip, port)
	get_tree().set_network_peer(network)
