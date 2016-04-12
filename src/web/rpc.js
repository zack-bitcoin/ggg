function getter(t, u, callback){
    t = JSON.stringify(t);
    var xmlhttp=new XMLHttpRequest();
    xmlhttp.onreadystatechange = callback;
    xmlhttp.open("POST",u,true);
    xmlhttp.send(t);
    return xmlhttp
}
var PORT = parseInt(document.URL.substring(17, 21), 10);
function url(port, ip) { return "http://".concat(ip).concat(":").concat(port.toString().concat("/")); }
function get(t, callback) {
    u = url(PORT, "localhost");
    return getter(t, u, callback);
}
function xml_check(x) { return ((x.readyState === 4) && (x.status === 200)); };
function xml_out(x) { return x.responseText; }
function refresh_helper(x, callback) {
    if (xml_check(x)) {callback(xml_out(x));}
    else {setTimeout(function() {refresh_helper(x, callback);}, 1000);}
};
my_status = "nil";
function variable_get(cmd, callback) {
    var x = get(cmd);
    var_get(x, callback);
}
function var_get(x, callback) {
    refresh_helper(x, function(){
	p = JSON.parse(xml_out(x));
	callback(p);
    });
}

