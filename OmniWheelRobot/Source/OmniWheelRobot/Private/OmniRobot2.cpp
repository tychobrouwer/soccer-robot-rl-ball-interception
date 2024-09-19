// Fill out your copyright notice in the Description page of Project Settings.

#include "OmniRobot2.h"

// Sets default values
AOmniRobot2::AOmniRobot2()
{
	// Set this actor to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;

	// Create the Robot Body Mesh component
	RobotBodyMesh = CreateDefaultSubobject<UStaticMeshComponent>(TEXT("RobotBodyMesh"));
	RobotBodyMesh->SetupAttachment(RootComponent);

	// Set the mesh for the Robot Body (make sure to set the correct path to your mesh)
	static ConstructorHelpers::FObjectFinder<UStaticMesh> RobotBodyMeshAsset(TEXT("StaticMesh'/Game/SimBlank/Blueprints/simple-body'"));
}

// Called when the game starts or when spawned
void AOmniRobot2::BeginPlay()
{
	Super::BeginPlay();
}

// Called every frame
void AOmniRobot2::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);
}
