var express = require('express');
var cors = require('cors');
var app = express();
var fs = require("fs");
var bodyParser = require('body-parser')

// Enable CORS for all routes and origins
app.use(cors());

app.use( bodyParser.json() );
app.use(bodyParser.urlencoded({  extended: true }));


app.get('/', function (req, res) {
    res.send({"msg":"Hey"})
})



var server = app.listen(5000, function () {
   console.log("Express App running at http://127.0.0.1:5000/");
})