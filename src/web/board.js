setInterval(board_display, 50);

function board_display() {
    var src = document.getElementById("img");
    src.src = "board.png?" + new Date().getTime();
}
