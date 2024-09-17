# Omni Wheel Motion Platform Modelling in Unreal Engine 5

This project is a simulation of a three wheeled omni wheel motion platform in Unreal Engine 5 for my Bachelor's final project. The goal of this project is to create an accurate simulation of an omni wheel motion platform for the purose of testing and validating control algorithms. The simulation will be validated using an real omni wheel motion platform used by for the RoboCup Middle Size League.

## Stage 1

The first stage of the project is to create a simulation of the omni wheel motion platform without simulating the physics of the omni wheels such as slip and friction effects. This will act as a baseline for validating the simlation performance improvement made by adding additional physics effects in the future.

For the first stage, the movement of the robot is purely based on the inverse kinematics of the motion platform. The inverse kinematics is calculated using the following equations:

```(math)
dx/dt = (r/3) * (2ω_1 - ω_2 - ω_3)
dy/dt = (r/3) * (-sqrt(3) * ω_2 + sqrt(3) * ω_3)
dtheta/dt = (r/3d) * (ω_1 + ω_2 + ω_3)
```

Where `r` is the radius of the omni wheel, `ω_1`, `ω_2`, and `ω_3` are the angular velocities of the omni wheels, and `d` is radius of the circle that the passes through the center of the omni wheels.

![Omni Wheel Motion Platform](/Images/omni_wheel_motion_platform.png)
