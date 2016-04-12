function play(event) {
    var x = event.offsetX?(event.offsetX):event.pageX-document.getElementById("img").offsetLeft;
    var y = event.offsetY?(event.offsetY):event.pageY-document.getElementById("img").offsetTop;
    a = Math.floor(x/19) + 1;
    b = 19 - Math.floor(y/19);
    console.log(a);
    console.log(b);
    get(["play", a, b]);
    board_display();
}


