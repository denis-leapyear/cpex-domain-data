
import Control.Monad

import Test.Hspec

import Services.GetEnvArgsServiceImpl
import Services.FileReaderService
import Services.FileReaderServiceImpl
import Services.FileWriterService
import Services.FileWriterServiceImpl
import Services.FileCopyService
import Services.FileCopyServiceImpl

import Services.FileSystemAndEnvServices

import MonadConfigurationProviderInstance

import Services
import Services.FileReaderServiceInstanceM
import Services.FileReaderServiceMImpl

import TestServices.GetEnvArgsServiceTestImpl

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "cp" $ do
  fileReaderSvc <- runIO createFileReaderService
  fileWriterSvc <- runIO createFileWriterService
  fileReaderServiceMData <- runIO createFileReaderServiceMData

  let inputFileName = "test.txt"
      outputFileName = "out.txt"
  getEnvArgsSvc <- runIO $ createGetEnvArgsTestService [inputFileName, outputFileName]

  it "should copy a file" $ do
    FileCopyService{..} <- createFileCopyService getEnvArgsSvc fileReaderSvc fileWriterSvc

    copyFileSpecifiedInArgs

    content <- openFileForRead fileReaderSvc outputFileName >>= readFileContent fileReaderSvc
    content `shouldBe` "abcd"

  it "should copy a file (aggregated)" $ do
    fileSystemAndEnvServices@FileSystemAndEnvServices{..} <-
      createFileSystemAndEnvServices getEnvArgsSvc fileReaderSvc fileWriterSvc
    FileCopyService{..} <- createFileCopyServiceAggregated fileSystemAndEnvServices

    copyFileSpecifiedInArgs

    content <- readFile outputFileName
    content `shouldBe` "abcd"

  it "should copy a file (Configurable Monad)" $ do
    let services = Services{..}

    FileCopyService{..} <- createFileCopyServiceM getEnvArgsSvc fileWriterSvc

    copyFileSpecifiedInArgs

    content <- openFileForRead fileReaderSvc outputFileName >>= readFileContent fileReaderSvc
    content `shouldBe` "abcd"