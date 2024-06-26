//import package express
const express = require("express");

//init
const PORT = 3000;
const app = express();
const db = "mongodb+srv://amazon-jamond:BP9WH-3HdhPHnz8@cluster0.p9wmn1d.mongodb.net/?retryWrites=true&w=majority";
const mongoose = require('mongoose');

//import from other files which is auth.js
const AuthRouter = require("./routes/auth");

//middleware
//client -> middleware(bridge) -> server -> client
//sequence is important here
const bodyParser = require("body-parser");
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Methods", "GET,PUT,PATCH,POST,DELETE");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
  });
app.use(AuthRouter);



//connections
mongoose.connect(db).then(() => {
    console.log("Connect Successful");
}).catch((e) => {
    console.log(e);
});

app.listen(PORT, "0.0.0.0",() => {
    console.log(`Connected at port ${PORT}`);
});


