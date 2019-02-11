module Main where

import Services.FileCopyService

import Services.GetEnvArgsServiceImpl
import Services.FileReaderServiceImpl
import Services.FileWriterServiceImpl
import Services.FileCopyServiceImpl

main :: IO ()
main = do
  fileReaderSvc       <- createFileReaderService
  fileWriterSvc       <- createFileWriterService
  getEnvArgsSvc       <- createGetEnvArgsService
  FileCopyService{..} <- createFileCopyService getEnvArgsSvc fileReaderSvc fileWriterSvc
  copyFileSpecifiedInArgs
