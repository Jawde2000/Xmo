const mongoose = require("mongoose");

const verificationScheme = mongoose.Schema({
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
    validationNumber: {
        required: true,
        type: String,
        trim: true
    },
    createdAt: { type: Date, index: { expires: '1m' }, default: Date.now, setDefaultsOnInsert: true },
})

const verification = mongoose.model("Verification", verificationScheme);
module.exports = verification;