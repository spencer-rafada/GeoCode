# Overview

GeoCode is an iOS mobile app developed to view all of the countries and display information such as capital, population, official name, etc. As a Software Engineer, I do my best to work on problems and challenges and  have fun to enhance my problem solving skills. In the process of doing so, I get to think of the problem more thoroughly and become a better problem solver. One of the purpose of this project is to further my knowledge in Mobile App Development and GIS Mapping. To use the app, you just have to wait for the data to be fetched from an API then you will be able to navigate through the map and see different countries by clicking next or previous or just discovering them in the map. The source of all the data that I use is from https://restcountries.com/ version 3.1. There are a lot of data included, but I only chose a couple for the View Model that I want to display.

One of the challenges that I have encountered is fetching data from the API endpoint using Swift. I learned that there are different ways of fetching data asynchronously such as Closure, Combine, and Async/Await. I implemented my fetch data through the Combine library, but got stuck due to lack of knowledge of concurrency and use of Swift pipeline. I did more research and was able to implement a simpler way using Async/Await. Another problem that I encountered is by creating a model based off the JSON response. This is something new since I am used to just parsing through the JSON response. However, you have to create a Model that conforms to the JSON response which should also be Codable protocol.

{Provide a link to your YouTube demonstration.  It should be a 4-5 minute demo of the software running and a walkthrough of the code.}

[Software Demo Video](http://youtube.link.goes.here)

# Development Environment

- Swift / SwiftUI / MapKit
- Xcode
- REST API

# Useful Websites

{Make a list of websites that you found helpful in this project}
* [QuickyType](https://app.quicktype.io/) - This website saved a lot of time for me to create a Data Model that conforms to the JSON response.
* [Async/Await JSON Fetching with AsyncImages](https://www.youtube.com/watch?v=bxCDL3kY8XA)
* [Swiftful Thinking](https://www.youtube.com/c/SwiftfulThinking)

# Future Work

* I want to add a Search bar on top of the screen to add more interactivity
* Add more pins on the map like tourist spots, etc.
* Have the user be able to create their own pins and categorize the pins and be able to save it in a cloud database
