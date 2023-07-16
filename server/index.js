const express= require("express");
const mongoose=require("mongoose")
const dotenv= require('dotenv');
const authRouter=require("./routes/auth")
dotenv.config();

mongoose.connect(
    process.env.MONGO_URL
    ).then(()=>console.log('Database connected')).catch((err)=>{console.log(err)});

const app=express();

app.use(authRouter);

app.listen(process.env.PORT,()=>{
    console.log(`Connected at port ${process.env.PORT}`);
});
