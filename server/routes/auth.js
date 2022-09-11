// import { initializeApp } from 'firebase/app';

const express = require("express");
const User = require("../models/user");
const Verification = require("../models/verification");
const bycrypt = require("bcrypt");
const AuthRouter = express.Router();
const jwt = require("jsonwebtoken");
const { ObjectId, MongoClient }  = require("mongodb");
const nodeMailer = require("nodemailer");

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

        if (pass == undefined) {
            return res.status(400).json({msg: "Password is undefined"});
        }

        const salt = await bycrypt.genSalt(15);
        const newHashPass = await bycrypt.hash(pass, salt);

        let user = new User({
            email: email, 
            pass: newHashPass, 
            name: name,
        });    

        let verification = new Verification({
            email, validationNumber
        })

        const transporter = nodeMailer.createTransport({
            service: 'Gmail',
            auth: {
                user: 'reimeinc2022@gmail.com', // Your email id
                pass: 'pmmsvmwpcwlybktg' // Your password
            }
        });

        const text = "Dear " + name + ", \n\n" + "Your Verification code is " + validationNumber + 
        ". Please do not share with others. The Verification code is going to expired in 5 minutes.\n\nThank you\nBest regards\n\nFrom IT Team Reime"; 


        const mailOptions = {
            from: 'reimeinc2022@gmail.com', // sender address
            to: email, // list of receivers
            subject: "Account Registration", // Subject line
            text: text //, // plaintext body
            // html: '<b>Hello world ✔</b>' // You can choose to send an HTML body instead
        };

        transporter.sendMail(mailOptions, function(error, info){
            if(error){
                console.log(error);
                res.json({yo: 'error'});
            }else{
                console.log('Message sent: ' + info.response);
                res.json({yo: info.response});
            }
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

    if (user.emailVerified) {
        const token = jwt.sign({id: user._id}, "passwordKey");
        res.json({token, ...user._doc});
    } else {
        return res.status(400).json({msg: "Account is not verified"});
    }
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

AuthRouter.post("/api/verification", async (req, res) => {
    try {
       //get data from client
        const { email, validationNumber } = req.body;

        const userV = await Verification.findOne({ email });
    
        if (!userV) {
            return res.status(400).json({msg: "User not exist"});
        }

        const isMatch = await validationNumber == userV.validationNumber? true:false;

        if (!isMatch) {
            return res.status(400).json({msg: `Invalid Verification ${validationNumber}`});
        } 

        const token = jwt.sign({id: userV._id}, "VerificationKey");
        res.json({token, ...userV._doc});
    } catch (e) {
        res.status(500).json({error: e.message});
    }
})

AuthRouter.patch('/api/updateStatus/', async (req, res) => {
    try {
        const { email } = req.body;

        const user = await User.findOne({ email });
    
        if (user) {
            user.updateOne({"emailVerified": true, }, {$set: { email }})
                .then(
                    result => {res.status(200).json(result);
            })
                .catch (err => {
                res.status(500).json({error: "Could not update the information"});
            })

            const deleteV = await Verification.findOne({email});

            const result = await deleteV.deleteOne();

            if (!result) {
                return res.status(400).json({message: "Verification Code does not exist"});
            }
        } else {
            res.status(500).json({error: "Invalid Email"});
        }
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})

AuthRouter.post('/api/VerificationTimedOut', async (req, res) => {
    try {
        const { email } = req.body;

        const deleteV = await Verification.findOne({email});

        const result = await deleteV.deleteOne();

    } catch (error) {
        //res.status(500).json({error: error.message});
    }
})

AuthRouter.post('/api/resendOTP', async (req, res) => {
    try {
        const { email } = req.body;

        const user = await User.findOne({ email });

        const validationNumber = Math.floor(100000 + Math.random() * 900000);

        let verification = new Verification({
            email, validationNumber
        })

        if (!user.emailVerified) {
            const transporter = nodeMailer.createTransport({
                service: 'Gmail',
                auth: {
                    user: 'reimeinc2022@gmail.com', // Your email id
                    pass: 'pmmsvmwpcwlybktg' // Your password
                }
            });
    
            const text = "Dear " + user.name + ", \n\n" + "Your Verification code is " + validationNumber + 
            ". Please do not share with others. The Verification code is going to expired in 5 minutes.\n\nThank you\nBest regards\n\nFrom IT Team Reime"; 
    
    
            const mailOptions = {
                from: 'reimeinc2022@gmail.com', // sender address
                to: email, // list of receivers
                subject: "Account Registration", // Subject line
                text: text //, // plaintext body
                // html: '<b>Hello world ✔</b>' // You can choose to send an HTML body instead
            };
    
            transporter.sendMail(mailOptions, function(error, info){
                if(error){
                    console.log(error);
                    res.json({yo: 'error'});
                }else{
                    console.log('Message sent: ' + info.response);
                    res.json({yo: info.response});
                }
            });
    
            verification = await verification.save();
            res.json(verification);
        } else {
            return res.status(409).json({msg: 'The user is verified'});
        }
        
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})

module.exports = AuthRouter;

