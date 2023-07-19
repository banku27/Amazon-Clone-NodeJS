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
        const CategoryProducts= await Product.find({category:req.query.category});
        res.json(CategoryProducts);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
});

productRouter.get("/api/products/search/:name",auth,async (req,res)=>{
    try {
        const products=await Product.find({
            name:{$regex: req.params.name, $options:"m"},
        });
        res.json(products);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
});

productRouter.post("/api/rate-product", async (req,res)=>{
    try {
        const {id,rating}=req.body;

        let product= await Product.findById(id);

       for(let i=0;i<product.ratings.length;i++){
        if (product.ratings[i].userId==req.user) {
            product.ratings.splice(i,1);
            break;
        }
       }
       const ratingSchema={
        userId:req.user,
        rating:rating,
       };

       product.ratings.push(ratingSchema);
       product = await  product.save();
       res.json(product);
        
        
// product.rating:::----
        // {
//          userId:"adadafa",
//          rating:2.5
        // }
        // {
//          userId:"afaffad",
//          rating:3
        // }
    } catch (error) {
        res.status(500).json({error:error.message});
        
    }
});
module.exports=productRouter;