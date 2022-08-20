const mongoose = require('mongoose');

const userScheme = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return alue.match(re);
            },
            message: "Please enter a valid email"
        }
    },
    pass: {
        required: true,
        type: String,
    },
    address: {
        required: true,
        default: '',
    },
    type: {
        type: String, 
        default: 'user',
    }
})