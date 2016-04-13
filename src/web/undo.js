undo();

function undo() {
    var spend_button = document.createElement("BUTTON");
    spend_button.id = "undo_button";
    var spend_button_text = document.createTextNode("undo move");
    spend_button.appendChild(spend_button_text);
    spend_button.onclick = function() {
	get(["undo"]);
    };
    document.body.appendChild(document.createElement("br"));
    document.body.appendChild(spend_button);
    board_display();
}
