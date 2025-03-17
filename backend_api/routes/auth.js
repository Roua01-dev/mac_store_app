

const express = require('express');
const User = require('../models/user');
const authRouter=express.Router();
const jwt = require('jsonwebtoken');

const bcrypt = require('bcryptjs');

//signup endpoint
authRouter.post('/api/signup', async (req, res) => {
    try {
        const { fullname, email, password } = req.body;
        const existingEmail = await User.findOne({ email });
        if (existingEmail) {
            return res.status(400).json({ msg: 'Email already exists' });
        }
    else {
        // generate a salt with  a cost factor of 10
        const salt = await bcrypt.genSalt(10);
        // hash the password using the generated salt
        const hashedPassword = await bcrypt.hash(password, salt);
        const user = new User({ fullname, email, password: hashedPassword });

        await user.save();
        res.status(200).json({ user });
    }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

//sign in endoint

authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: 'User not found' });
        }
        else {
        // compare the entered password with the hashed password stored in the database
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: 'Invalid password' });
        }
        else {
        // generate a token
       const token = jwt.sign({ _id: user._id }, process.env.JWT_SECRET, { expiresIn: '1h' });
       //remove sensitive information password
       const { password,...rest } = user._doc;
       // send the user object and the token to the client
       res.json({...rest, token });
    }}
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
module.exports = authRouter;