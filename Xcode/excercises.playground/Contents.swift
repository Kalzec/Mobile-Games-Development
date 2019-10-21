import Darwin

// Exercise 1: VARIABLES, CONSTANTS, EXPRESSIONS AND PRINTING

// Create a short program, in XCode Playgrounds,that calculates the volume of a sphere based on a given diameter, and outputs the result.

// Note: you can use the guidance comment below (if you wish) to help you write the code.

// declare a variable called 'diameter' to hold the diameter of a Sphere as a whole number

// declare a variable called 'volume' to hold the volume of a Sphere as a real number

// declare a constant that stores the value for PI as 3.142

// set diameter of sphere to  (e.g.) 20cm

// calculate the radius

// use the formula (4/3*PI*radius^3) to calculate the volume of the Sphere.

// Note: there is no ^ operator in Swift! So you may wish to import the 'Darwin' library and use it's 'pow(Double, Double)' function

// display the result as: "A Sphere of radius ..cm, has a volume of ... cm cubed"

///////////////////////////////////////////////////////////////////////////////////

//Excercise 1
var diameter = 20
var volume:Double
let pi = 3.142


var radius = Double(diameter)/2

var realRadius = pow(radius, 3)

volume  = (4/3*pi*realRadius)

print ("A Sphere of radius \(radius) cm, has a volume of  \(volume) cm")



// Exercise 2: OPTIONALS

// Modify the code from Exercise 1 to use Optionals for the diameter and volume variables - and then test by setting / forgetting to set a value for the diameter before calculating the volume. If there is no valid diameter availalbe, your program should not attempt the calcualtion and display an 'error' type message instead of the volume.

//Excercise 2

var diameter2:Int?
var volume2:Double?
let pi2 = 3.142

diameter2 = 20;

var radius2 = Double(diameter2!)/2

var realRadius2 = pow(radius, 3)

volume2  = (4/3*pi2*realRadius2)

print ("A Sphere of radius \(radius2) cm, has a volume of  \(volume2) cm")


///////////////////////////////////////////////////////////////////////////////////

// Exercise 3: ARRAYS AND LOOPS

// Modify the code from Exercise 1 or 2 to allow the volume to be calculated for a set of Spheres, whose diameters are stored in an Array variable called diameters - e.g. [10,5,2,20] - before calculating the results, adjust the diameters array so that the results are printed in largest-first - smallest-last order

///////////////////////////////////////////////////////////////////////////////////


//Excercise 3
var diameterArray = [20, 10, 30]
var volume3:Double
let pi3 = 3.142

diameterArray.sort(by: <)

for i in 0...2
{
    var radius3 = Double(diameterArray[i])/2
    
    var realRadius3 = pow(radius, 3)
    
    volume3  = (4/3*pi3*realRadius3)
    
    print ("A Sphere of radius \(radius3) cm, has a volume of  \(volume3) cm")
}


// Exercise 4: DICTIONARIES AND TUPLES

// Modify the code from Exercise 3 to allow the results of your calculations to be stored in a Dictionary that stores the diameter as the Key and the calculated volume as the Value. Then use Tuples to display the results.

///////////////////////////////////////////////////////////////////////////////////

// Exercise 5: CONDITIONS

// Modify the code from Exercise 4 to allow the classification of Spheres by size - such that any sphere of volume less than 10 cm cubed is considered 'Small', between 10 - 100 cm cubed is considered 'Normal' and larger than 100 cm cubed is considered 'Large'. Modify the output to append the words "This is a ...... Sphere!", where '......' is 'Small', 'Medium' or 'Large'.

///////////////////////////////////////////////////////////////////////////////////

// Exercise 6: FUNCTIONS

// Modify the code from Exercise 3 (Arrays), to convert the code into a function named 'CalcSphereVolume' or something similar, that takes as it's only parameter a single diameter, and returns the calculated Volume. The code that calls this function can then iterate through the array of diameters - repeatedly calling the function and outputting the returned volume message.

///////////////////////////////////////////////////////////////////////////////////
