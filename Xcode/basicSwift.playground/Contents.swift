//: Playground - noun: a place where people can play

//Variables
var str = "Hello, playground"

var int = 2

//printing stuff
print("Hi "  + String(int)) //either use + sign and conversion

print ("my age is \(int)") // or use interpolation

//basic if statement
if int < 3
{
    print ("Woop")
}
else
{
    print ("Oof")
}

//Optionals
var frazerSucks:String? //add a ? to create an optional

//unwrapping the optional
if let boop = frazerSucks
{
    print ("false")
}
else
{
    print ("true")
}

for i in 0...10
{
    i
}

for (i = 0; i <= 10; i++)
{
    i
}
