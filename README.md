![graph](Targets/CatFactsApp/Resources/Media.xcassets/AppIcon.appiconset/180.png)

# CatFacts
An example of an app architecture with concepts such as:
- Modular 
- Unidirectional 
- Domain Driven 
- with Data-Driven UI
- automated by Tuist

# Contents
## Tuist
- Module.swift contains an enum with declarative desciption of all modules and their dependencies

## CatFactsDomain
- Contains separated Business Logic of the Cat Facts domain
- Modeled with a strong type system and pure functions
- Must not have any dependencies except Foundation to keep its cleanness

## CatFactsNetworkService
- A microservice working with https://catfact.ninja/fact API

## CatFactsUI
- Framework with Data-Driven UI layer

## CatFactsApp
- A root node of a modular tree, combining other modules, passing inputs and outputs between them, and performing effects

# Graph
```
tuist graph --skip-test-targets
```
![graph](graph.png)

# Bootstrap
- To generate .xcproject and .xcrowkspace files use
```
tuist generate
```
- Find more info on https://docs.tuist.io/
