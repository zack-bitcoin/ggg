setInterval(board_display, 200);

function board_display() {
    var src = document.getElementById("img");
    src.src = "board.png?" + new Date().getTime();
}
