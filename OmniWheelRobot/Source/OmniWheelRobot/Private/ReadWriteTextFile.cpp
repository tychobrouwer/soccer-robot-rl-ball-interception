// Fill out your copyright notice in the Description page of Project Settings.

#include "ReadWriteTextFile.h"

#include "HAL/PlatformFileManager.h"

FString UReadWriteTextFile::ReadStringFromFile(const FString& FilePath,
                                               bool& bOutSuccess,
                                               FString& OutInfoMessage) {
  if (!FPlatformFileManager::Get().GetPlatformFile().FileExists(*FilePath)) {
    bOutSuccess = false;
    OutInfoMessage = FString::Printf(
        TEXT("Read String From File Failed - File doesn't exist - '%s'"),
        *FilePath);

    return "";
  };

  FString RetString = "";

  if (!FFileHelper::LoadFileToString(RetString, *FilePath)) {
    bOutSuccess = false;
    OutInfoMessage =
        FString::Printf(TEXT("Read String From File Failed - Was not able to "
                             "read file. Is this a text file? - '%s'"),
                        *FilePath);

    return "";
  }

  bOutSuccess = true;
  OutInfoMessage = FString::Printf(
      TEXT("Read String From File Succeeded - '%s'"), *FilePath);

  return RetString;
}

void UReadWriteTextFile::WriteStringToFile(const FString& FilePath,
                                           const FString& String,
                                           bool& bOutSuccess,
                                           FString& OutInfoMessage) {
  if (!FFileHelper::SaveStringToFile(String, *FilePath,
                                     FFileHelper::EEncodingOptions::AutoDetect,
                                     &IFileManager::Get(), FILEWRITE_Append)) {
    bOutSuccess = false;
    OutInfoMessage = FString::Printf(
        TEXT("Write String To File Failed - Was not able to write to file. Is "
             "your file read-only? Is the path valid? - '%s'"),
        *FilePath);

    return;
  }

  bOutSuccess = true;
  OutInfoMessage = FString::Printf(
      TEXT("Write String To File Succeeeded - '%s'"), *FilePath);
}
