const express = require("express");
const productRouter = express.Router();
const auth = require("../middlewares/auth");
const { Product } = require("../models/product");

// case 1:
// /api/products?category=Essentials----> req.query.category (category is name of the thing we want to search)
//  /api/amazon?theme=dark ----> req.query.theme

//case 2:
// api/products:category=Essentials ----> req.params.category

productRouter.get("/api/products",auth,async(req,res)=>{
    try {
        // console.log(req.query.category);
        const CategoryProducts= Product.find({category:req.query.category});
        res.json(CategoryProducts);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
});

module.exports=productRouter;