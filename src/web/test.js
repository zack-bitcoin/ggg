

var test_var = document.createElement("div");
test_var.id = "test_var";
document.body.appendChild(test_var);
console.log("test here ");
function t2(x) {
    console.log("in t2");
    console.log(x);
    var h = document.getElementById("test_var");
    h.innerHTML = "test output: ".concat(x);
}
variable_get(["example"], t2);
