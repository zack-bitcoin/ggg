refresh();

function refresh() {
    var spend_button = document.createElement("BUTTON");
    spend_button.id = "refresh_button";
    var spend_button_text = document.createTextNode("refresh board");
    spend_button.appendChild(spend_button_text);
    spend_button.onclick = function() {
	get(["refresh"]);
    };
    document.body.appendChild(document.createElement("br"));
    document.body.appendChild(spend_button);
    board_display();
}
