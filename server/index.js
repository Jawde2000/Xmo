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
app.use(AuthRouter)

//connections
mongoose.connect(db).then(() => {
    console.log("Connect Successful");
}).catch((e) => {
    console.log(e);
});

app.listen(PORT, () => {
    console.log(`Connected at port ${PORT}`);
});


