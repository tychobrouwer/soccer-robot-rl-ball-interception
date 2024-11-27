// Fill out your copyright notice in the Description page of Project Settings.

#include "ReadWriteTextFile.h"

#include "HAL/PlatformFileManager.h"

FString UReadWriteTextFile::ReadStringFromFile(const FString &FilePath,
                                               bool &bOutSuccess,
                                               FString &OutInfoMessage)
{
  if (!FPlatformFileManager::Get().GetPlatformFile().FileExists(*FilePath))
  {
    bOutSuccess = false;
    OutInfoMessage = FString::Printf(
        TEXT("Read String From File Failed - File doesn't exist - '%s'"),
        *FilePath);

    UE_LOG(LogTemp, Error, TEXT("File doesn't exist"));

    return "";
  };

  FString RetString = "";

  if (!FFileHelper::LoadFileToString(RetString, *FilePath))
  {
    bOutSuccess = false;
    OutInfoMessage =
        FString::Printf(TEXT("Read String From File Failed - Was not able to "
                             "read file. Is this a text file? - '%s'"),
                        *FilePath);

    UE_LOG(LogTemp, Error,
           TEXT("Was not able to read file. Is this a text file?"));

    return "";
  }

  bOutSuccess = true;
  OutInfoMessage = FString::Printf(
      TEXT("Read String From File Succeeded - '%s'"), *FilePath);

  return RetString;
}

TArray<float> UReadWriteTextFile::ReadLineFromInput(const FString &FilePath,
                                                    const int32 LineIndex,
                                                    bool &bOutSuccess,
                                                    FString &OutInfoMessage)
{
  const FString FileContent =
      ReadStringFromFile(FilePath, bOutSuccess, OutInfoMessage);

  if (!bOutSuccess)
  {
    return TArray<float>();
  }

  TArray<FString> Lines;
  const int32 LineCount = FileContent.ParseIntoArrayLines(Lines, true);

  if (LineIndex >= LineCount)
  {
    bOutSuccess = false;
    OutInfoMessage = FString::Printf(
        TEXT("Read Line From Input Failed - Line index out of bounds - '%s'"),
        *FilePath);

    UE_LOG(LogTemp, Error, TEXT("Line index out of bounds"));

    return TArray<float>();
  }

  const FString InputLineString = Lines[LineIndex];

  TArray<FString> InputStringValues;

  const int32 InputCount =
      InputLineString.ParseIntoArray(InputStringValues, TEXT(","), true);

  TArray<float> InputValues;
  for (int32 i = 0; i < InputCount; i++)
  {
    if (InputStringValues.IsValidIndex(i))
    {
      float Value = FCString::Atof(*InputStringValues[i]);
      InputValues.Add(Value);
    }
    else
    {
      UE_LOG(LogTemp, Error,
             TEXT("Index %d out of bounds for InputStringValues"), i);
    }
  }

  if (InputCount < 10)
  {
    bOutSuccess = true;
    OutInfoMessage = FString::Printf(
        TEXT("Input file did not contain all setpoint variables"));

    UE_LOG(LogTemp, Error,
           TEXT("Input file did not contain all setpoint variables"));

    return TArray<float>();
  }

  bOutSuccess = true;
  OutInfoMessage =
      FString::Printf(TEXT("Read Line From Input Succeeded - '%s'"), *FilePath);

  return InputValues;
}

TArray<float> UReadWriteTextFile::ReadLinesFromInput(const FString &FilePath,
                                                     bool &bOutSuccess,
                                                     FString &OutInfoMessage)
{
  const FString FileContent =
      ReadStringFromFile(FilePath, bOutSuccess, OutInfoMessage);

  if (!bOutSuccess)
  {
    return TArray<float>();
  }

  TArray<FString> Lines;
  const int32 LineCount = FileContent.ParseIntoArrayLines(Lines, true);

  TArray<float> AllInputValues;
  for (int32 i = 0; i < LineCount; i++)
  {
    if (!Lines.IsValidIndex(i))
    {
      UE_LOG(LogTemp, Error, TEXT("Index %d out of bounds for Lines"), i);
      continue;
    }

    const FString InputLineString = Lines[i];

    TArray<FString> InputStringValues;
    const int32 InputCount =
        InputLineString.ParseIntoArray(InputStringValues, TEXT(","), true);

    if (InputCount < 10)
    {
      bOutSuccess = true;
      OutInfoMessage = FString::Printf(
          TEXT("Input file did not contain all setpoint variables"));

      UE_LOG(LogTemp, Error,
             TEXT("Input file did not contain all setpoint variables"));

      return TArray<float>();
    }

    for (int32 j = 0; j < InputCount; j++)
    {
      if (InputStringValues.IsValidIndex(j))
      {
        float Value = FCString::Atof(*InputStringValues[j]);
        AllInputValues.Add(Value);
      }
      else
      {
        UE_LOG(LogTemp, Error,
               TEXT("Index %d out of bounds for InputStringValues"), j);
      }
    }
  }

  bOutSuccess = true;
  OutInfoMessage = FString::Printf(
      TEXT("Read All Lines From Input Succeeded - '%s'"), *FilePath);

  return AllInputValues;
}

void UReadWriteTextFile::WriteStringToFile(const FString &FilePath,
                                           const FString &String,
                                           bool &bOutSuccess,
                                           FString &OutInfoMessage)
{
  if (!FFileHelper::SaveStringToFile(String, *FilePath,
                                     FFileHelper::EEncodingOptions::AutoDetect,
                                     &IFileManager::Get(), FILEWRITE_Append))
  {
    bOutSuccess = false;
    OutInfoMessage = FString::Printf(
        TEXT("Write String To File Failed - Was not able to write to file. Is "
             "your file read-only? Is the path valid? - '%s'"),
        *FilePath);

    UE_LOG(LogTemp, Error,
           TEXT("Was not able to write to file. Is your file read-only? Is the "
                "path valid?"));

    return;
  }

  bOutSuccess = true;
  OutInfoMessage = FString::Printf(
      TEXT("Write String To File Succeeeded - '%s'"), *FilePath);
}

void UReadWriteTextFile::WriteLinesFromOutput(const FString &FilePath,
                                              const TArray<float> &OutputValues,
                                              bool &bOutSuccess,
                                              FString &OutInfoMessage)
{
  FString OutputString = "";

  for (int32 i = 0; i < OutputValues.Num(); i += 9)
  {
    for (int32 j = 0; j < 9; j++)
    {
      if (OutputValues.IsValidIndex(i + j))
      {
        OutputString += FString::SanitizeFloat(OutputValues[i + j]);
        if (j < 8)
        {
          OutputString += ",";
        }
      }
      else
      {
        UE_LOG(LogTemp, Error,
               TEXT("Index %d out of bounds for OutputValues"), i + j);

        bOutSuccess = false;
        OutInfoMessage = FString::Printf(
            TEXT("Write Lines From Output Failed - Index out of bounds - '%s'"),
            *FilePath);

        return;
      }
    }
    OutputString += "\n";
  }

  WriteStringToFile(FilePath, OutputString, bOutSuccess, OutInfoMessage);
}