// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "ReadWriteTextFile.generated.h"

/**
 *
 */
UCLASS()
class OMNIWHEELROBOT_API UReadWriteTextFile : public UBlueprintFunctionLibrary {
  GENERATED_BODY()
 public:
  UFUNCTION(BlueprintCallable, Category = "Read Write File")
  static FString ReadStringFromFile(const FString& FilePath, bool& bOutSuccess,
                                    FString& OutInfoMessage);

  UFUNCTION(BlueprintCallable, Category = "Read Write File")
  static void WriteStringToFile(const FString& FilePath, const FString& String,
                                bool& bOutSuccess, FString& OutInfoMessage);
};
