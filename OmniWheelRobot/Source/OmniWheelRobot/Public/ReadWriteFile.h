// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "Kismet/BlueprintFunctionLibrary.h"
#include "ReadWriteFile.generated.h"

UCLASS()
class UReadWriteFile : public UBlueprintFunctionLibrary {
  GENERATED_BODY()

 public:
  UFUNCTION(BlueprintCallable, Category = "Read Write File")
  static FString ReadStringFromFile(const FString& FilePath, bool& bOutSuccess,
                                    FString& OutInfoMessage);

  UFUNCTION(BlueprintCallable, Category = "Read Write File")
  static void WriteStringFromFile(const FString& FilePath,
                                  const FString& String, bool& bOutSuccess,
                                  FString& OutInfoMessage);
};
