new_game();

function new_game() {
    var spend_button = document.createElement("BUTTON");
    spend_button.id = "new_game_button";
    var spend_button_text = document.createTextNode("new game");
    spend_button.appendChild(spend_button_text);
    spend_button.onclick = function() {
	get(["new_game"]);
    };
    document.body.appendChild(spend_button);
    board_display();
}
