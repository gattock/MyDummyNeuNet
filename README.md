# MyDummyNeuNet:

The task asked to the NN is to command the acceleration of a point (hunter) in order to follow another point (prey) (the cost is the integral of the distance in dt).
The "hunted"point should move random. For now I'll train the NN with a Lissajous trajectory (something enough complicated, maybe with ratio of 16/17 or smth)
Then I'll train it by Dropout method and see if the NN will be sufficiently resilient to follow a random-trajectory prey.
You can run it by main.m file, at the end of computation the cmd window asks which one you want to plot, choose 1, and see how behaves the best of the n random "point-hunters"

Actual State: Gradient descent -> work in progress



