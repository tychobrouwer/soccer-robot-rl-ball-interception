// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "OmniRobot2.generated.h"

UCLASS(Blueprintable, BlueprintType)
class OMNIWHEELROBOT_API AOmniRobot2 : public AActor
{
	GENERATED_BODY()

public:
	// Sets default values for this actor's properties
	AOmniRobot2();

protected:
	// Called when the game starts or when spawned
	virtual void BeginPlay() override;

public:
	// Called every frame
	virtual void Tick(float DeltaTime) override;

	UPROPERTY(VisibleAnywhere)
	UStaticMeshComponent *RobotBodyMesh;
};
