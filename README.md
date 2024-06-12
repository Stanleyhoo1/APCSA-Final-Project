# APCSA-Final-Project

# Introduction
Period: 2

Group Members: Stanley Hoo

Group Name: Solar

Project Title: Space Simulator


# Description
Project Overview: This project will simulate our solar system. The user can make changes to it by changing the mass of planets, changing size of planets, and the distance between planets. This will help us visualize how impactful some changes in our solar system can be over time. Every time a change is made, the simulation will be reset with the new changes. 

# Functionalities
Planetary Orbits: Accurate depiction of planetary orbits around the sun based on gravitational forces.

Information Panels: Display details about each celestial body, including name, size, distance from the sun, and orbital period.

User Controls: Allow users to adjust the simulation speed, change the sizes of planets, and distance from the sun. Can change by using drag bars or the input box.

Time Control: Enables users to speed up or slow down time to observe planetary movements in different time scales by pressing “+” to speed up time or “-” to slow down time.

Libraries Needed: ControlP5

Additional Information: The simulation will scale down the vast distances and sizes in the solar system to fit within a manageable view, ensuring a balance between accuracy and usability.

# UML Diagram
[UML Diagram.png](https://github.com/Stanleyhoo1/APCSA-Final-Project/blob/5c199c6ecdb1340bbab465b9590181054fd2b06f/UML%20Diagram.png)

# How Does It Work?
Running the Simulation

Setup: Download and open the Processing IDE. Load the provided code files into the IDE.

Execution: Run the main simulation file to start the program.

User Controls:

Viewing Information: Click on any planet to display its information panel with details about the planet body.

Increasing Time: Increases the rate at which time is passing by using “+” or “-” keys, in other words the simulation can be run faster or slower.

Adjusting Planet Properties: Users will be able to change the distance of planets to each other and the sun by using sliders or input boxes. They can also increase the mass of a planet by using an input box or drag bar. Mass will be measured in units of Earths. In order to change a planet’s properties, you must first select the planet then you can change it using the drag bars or input box.

# Functionalities / Issues (for Meeting 1 and 2 documents)
Functionalities: 
Planets are orbiting

Data for planet is displayed when it is clicked

Issues:
Scaling is too small

Will probably try to fix by adding a zoom method to zoom into specific areas

Functionalities to add by next meeting:
A way to change a planet’s mass

A time display at the top

Text showing up on screen instead of console

Way to change the time passage

Meeting 2:

Functionalities: 

Planets are orbiting

Data for planets is displayed when clicked on screen

Can speed up or slow down time with “+” and “-”

Planet backgrounds are transparent

Time display at top

A way to change planet mass and size (you have to click on the planet then drag the bar to change the size or mass)

Issues: 

Scaling - not sure how to fix this because the planets need to be visible but I also need to them to interact with each other, maybe just a dummy display and have the real values stored in the code

Functionalities to add by next meeting:

The changed planet interacting with the other planets and sun

Final:

Functionalities:

Planets are orbiting

Data for planets is displayed when clicked on screen

Can speed up or slow down time with “+” and “-”

Planet backgrounds are transparent

Time display at top

A way to change planet mass and size (you have to click on the planet then drag the bar to change the size or mass)

Scaling is accurate and fits

Planet interaction based on the forces they exert on each other

Issues:

Planet interaction is a little inaccurate, the calculations of the vectors are a bit off, not sure how to fix


Issues during project development and how I approached them:

For the scaling problem, the scale was far too large and couldn’t fit within the screen, the planets were also really small and hard to select. I fixed this by square rooting all the distance and size so they are still accurate but not so much affected by the magnitude of the numbers.


# Log (for the final document)
Stanley Hoo: Everything
