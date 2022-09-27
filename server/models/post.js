const mongoose = require('mongoose');

const postScheme = mongoose.Schema({
    message: {
        required: true,
        type: String, 
    },
    ownedby: {
        required: true,
        type: String
    },
    createdAt: {
        type: Date, 
        default: Date.now, 
        setDefaultsOnInsert: true,
    },
    likes: {
        type: Number,
        default: 0,
        setDefaultsOnInsert: 0,
    }
})

const post = mongoose.model('Post', postScheme);
module.exports = post;