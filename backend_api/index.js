const express=require('express');
require('dotenv').config();

const mongoose=require('mongoose');
const db="mongodb+srv://rouainsimplo:rouainsimplo@cluster0.3zy6r.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"
const authRouter = require('./routes/auth');
mongoose.connect(db, {useNewUrlParser: true, useUnifiedTopology: true}).then(() => console.log("Connected to MongoDB"))



const app=express();
//middleware

app.use(express.json());

app.use(authRouter);
const PORT=3000 ;
app.listen(PORT,"0.0.0.0",() => console.log(`Server running on port ${PORT}`));