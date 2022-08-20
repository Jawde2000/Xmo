// import { initializeApp } from 'firebase/app';

const express = require("express");

const AuthRouter = express.Router();

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



AuthRouter.post("/api/signup", (req, res) => {
    //get data from client
    const {name, email, pass} = req.body;
    //post data into database
    
    //return data to user
});

module.exports = AuthRouter;

