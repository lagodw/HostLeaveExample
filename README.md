# HostLeaveExample

https://gotm.io/lagodw/hostleaveexample

Example project to show weird behavior when hosting and then leaving a GOTM lobby. Although the host leaves the lobby, it continues to show up in the fetched lobby list when hosted on gotm.io; however, when tested locally the host lobby disappears from the list. Scene structure is

1. MainMenu - starting screen where players can see the list of available lobbies or choose to host their own
2. HostScreen - a waiting scene for when a player hosts a lobby and is waiting for others to join, with a button to return to the main menu and leave the lobby
3. Game - placeholder for where the actual game would take place once another player has joined the lobby

To reproduce the behavior, start the game and host a lobby and then click on main menu button in the host waiting screen. After a few seconds the lobby list should refresh and the exited lobby will appear.
