const mongoose=require('mongoose');
const userSchema=mongoose.Schema({
    fullname:{
        type:String,
        required:true,
        trim :true
    },
    email:{
        type:String,
        required:true,
        unique:true,
        trim :true,
        lowercase:true,
        //validate an email address format regex
        validate:{
            validator: (value)=>{
                const result=       /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
                return result.test(value);
            },
            message: "Invalid email address"

        }
     
    },
    password:{
        type:String,
        required:true,
        //validate
        //password should be at least 8 characters long 
        validate:{
            validator: (value)=>{
                return value.length>=8;
            },
            message: "Password should be at least 8 characters long"
        }
         
    },
   
    state:
    {
        type: String,
        default :"",
    }, 
    city:
    {
        type: String,
        default :"",
    },
    locality:
    {
        type: String,
        default :"",
    },
   

});

const User=mongoose.model('User',userSchema);

module.exports=User;