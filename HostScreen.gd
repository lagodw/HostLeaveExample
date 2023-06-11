extends CanvasLayer

func _ready():
	$MainMenu.connect("clicked", self, "main_menu")
	$LobbyName.text = "Game Name: \n" + Gotm.lobby.name

func main_menu():
	Gotm.lobby.leave()
	Server.network.close_connection() 
	get_tree().change_scene("res://MainMenu.tscn")
