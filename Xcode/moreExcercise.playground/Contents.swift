import Darwin

// Exercise 7: ENUMERATED TYPES

// Create a short program, in XCode Playgrounds, that allows an enumerated type to be created to hold the essential colours of the spectrum (Red, Orange, Yellow, Green, Blue, Indigo, Violet). A method called 'Description' should be implemented to return a string to represnt the color. Test the enumerated type by creating a variable called shapeColour - to represent a selected colour (e.g. Green).

// CHALLENGE!!: [Very difficult - ignore if not sure!] Look at the UIKit and CoreGraphics libraries (developer.apple.com) and the Web forums (e.g. stackoverflow.com) to see if you can find out how create a UIButton or UIView object and get it to draw with the chosen color and title (e.g. "BLUE" on the tilte for a Blue Button / View)

enum Spectrum
{
    case Red, Orange, Yellow, Green, Blue, Indigo, Violet
    
    func description()->String
    {
        switch self
        {
            case.Red: return "Red"
            case.Orange: return "Orange"
            case.Yellow: return "Yellow"
            case.Green: return "Green"
            case.Blue: return "Blue"
            case.Indigo: return "Indigo"
            case.Violet: return "Violet"
        }
    }
}

let shapeColour: Spectrum

shapeColour = .Green

let desc = shapeColour.description()


///////////////////////////////////////////////////////////////////////////////////

// Exercise 8: STRUCTURES

//Use the code you created in the 'Basics of Swift' exercises last week - e.g. modify exercise 6 - to create a structure (struct) that represents a Sphere. It should have at least 4 attributes - Diameter (Int), Volume(Double), Colour(usig your enumerated type from, exercise 7) and PI(Double, Constant). It should encapsulate a 'CalcVolume()->Double' method that accepts no parameters (uses the attributes of the structure), and calculates and returns the Volume of the Sphere (as a Double).

//You could then use the code from your previous exercises to create an array of diameters for spheres and calculate their volumes to be output.

struct Sphere
{
    var diameter = 20
    var volume:Double
    let pi = 3.142
    let colour: Spectrum
    
    
    mutating func CalcVolume()->Double
    {

        let radius = Double(diameter)/2
        
        let realRadius = pow(radius, 3)
        
        volume = (4/3*pi*realRadius)
        
        return volume
    }
    
}


var sphere:Sphere = Sphere(diameter: 20, volume: 0, colour: .Red)
var sphere2:Sphere = Sphere(diameter: 10, volume: 0, colour: .Green)


sphere.CalcVolume()
sphere2.CalcVolume()



///////////////////////////////////////////////////////////////////////////////////

// Exercise 9: SIMPLE CLASSES AND PROTOCOLS

// Modify the code created for exercise 8, and convert the Sphere structure into a class. The class should have the same attributes and method as the structure, with the addition of a non-default Constructor that accepts a Diameter as it's only parameter.

// You should also add a method called 'Print()' that is implemented from a Protocol called 'Printable' - it should simply return all the attributes of the class in a (String) readable format

///////////////////////////////////////////////////////////////////////////////////

//Exercise 10: INHERITANCE AND ABSTRACTION

// Based (loosely) around the UML Class diagram given below - implement as much of the class hierarchy as you can (you may be able to reuse the 'Sphere' class's code created for Exercise 9). Pay particular attention to the 'Abstract' methods (e.g. 'CalcArea' in '2DShape', or 'CalcVolume' in '3DShape') - how would you implement these - note there is no 'abstract' classifier in Swift (unlike Java or C#).
