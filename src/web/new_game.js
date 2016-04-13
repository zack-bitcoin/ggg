new_game();

function new_game2() {
    get(["new_game"]);
}

function new_game() {
    var spend_button = document.createElement("button");
    spend_button.id = 'new_game_button';
    var spend_button_text = document.createTextNode("new game");
    spend_button.appendChild(spend_button_text);
    //f = function() {get(["new_game"]);};
    spend_button.onclick = new_game2;
    spend_button.ontouchend = new_game2;
    //spend_button.addEventListener('touchend', new_game2, false);
    //spend_button.addEventListener('click', new_game2, false);
    document.body.appendChild(spend_button);
    board_display();
}
