const mongoose = require('mongoose');

const userScheme = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: "Please enter a valid email"
        }
    },
    pass: {
        required: true,
        type: String,
    },
    address: {
        type: String,
        default: "",
    },
    type: {
        type: String, 
        default: "user",
    },
});

const user = mongoose.model('User', userScheme);
module.exports = user;