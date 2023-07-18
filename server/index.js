const express= require("express");
const mongoose=require("mongoose")
const dotenv= require('dotenv');
const authRouter=require("./routes/auth");
const adminRouter = require("./routes/admin");
dotenv.config();

mongoose.connect(
    process.env.MONGO_URL
    ).then(()=>console.log('Database connected')).catch((err)=>{console.log(err)});

const app=express();
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.listen(process.env.PORT,()=>{
    console.log(`Connected at port ${process.env.PORT}`);
});
