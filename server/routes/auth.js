// import { initializeApp } from 'firebase/app';

const express = require("express");
const User = require("../models/user");
const Verification = require("../models/verification");
const bycrypt = require("bcryptjs");
const AuthRouter = express.Router();
const jwt = require("jsonwebtoken");

// const firebaseConfig = {
//     apiKey: "API_KEY",
//     authDomain: "PROJECT_ID.firebaseapp.com",
//      // The value of `databaseURL` depends on the location of the database
//     databaseURL: "https://DATABASE_NAME.firebaseio.com",
//     projectId: "clone-d803b",
//     storageBucket: "PROJECT_ID.appspot.com",
//     messagingSenderId: "SENDER_ID",
//     appId: "APP_ID",
//     // For Firebase JavaScript SDK v7.20.0 and later, `measurementId` is an optional field
//     measurementId: "G-MEASUREMENT_ID",
// };
  
// const app = initializeApp(firebaseConfig);



AuthRouter.post("/api/signup", async (req, res) => {
    try {
    //get data from client
    const { name, email, pass } = req.body;
    //post data into database
    const userExist = await User.findOne({ email });
    //generate random 6 digits number
    const validationNumber = Math.floor(100000 + Math.random() * 900000);

    if (userExist) {
        return res.status(400).json({msg: "User with same email already exist"});
    }

    const newHashPass = await bycrypt.hash(pass, 15);
    const newHashValidation = await bycrypt.hash(validationNumber.toString(), 15);

    let user = new User({
        email, 
        pass: newHashPass, 
        name,
    });

    let verification = new Verification({
        email, 
        validationNumber: newHashValidation,
    });

    user = await user.save();
    verification = await verification.save();
    res.json(user);
    res.json(verification);
} catch (e) {
    res.status(500).json({error: e.message});
}
    //return data to user
});

AuthRouter.post("/api/signin", async (req, res) => {
    try {

    //get data from client
    const { email, pass } = req.body;
    //post data into database
    const user = await User.findOne({ email });

    if (!user) {
        return res.status(400).json({msg: "User not exist"});
    }

    const isMatch = await bycrypt.compare(pass, user.pass);
    if (!isMatch) {
        return res.status(400).json({msg: "Invalid password or email"});
    }

    const token = jwt.sign({id: user._id}, "passwordKey");
    res.json({token, ...user._doc});
    //{
    //  "name": "jamond",
    //  "email": "ja@gmail.com" 
    //}

    //become
    //{ 
    //  "token": "tokenJWT"
    //}
} catch (e) {
    res.status(500).json({error: e.message});
}
    //return data to user
});

module.exports = AuthRouter;

