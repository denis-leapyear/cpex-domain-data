
import Control.Monad

import Test.Hspec

import Services.GetEnvArgsServiceImpl
import Services.FileReaderService
import Services.FileReaderServiceImpl
import Services.FileWriterService
import Services.FileWriterServiceImpl
import Services.FileCopyService
import Services.FileCopyServiceImpl

import TestServices.GetEnvArgsServiceTestImpl

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "cp" $ do
  fileReaderSvc@FileReaderService{..} <- runIO createFileReaderService
  fileWriterSvc@FileWriterService{..} <- runIO createFileWriterService

  it "should copy a file" $ do
    let inputFileName = "test.txt"
        outputFileName = "out.txt"
    getEnvArgsSvc       <- createGetEnvArgsTestService [inputFileName, outputFileName]
    FileCopyService{..} <- createFileCopyService getEnvArgsSvc fileReaderSvc fileWriterSvc
    copyFileSpecifiedInArgs

    content <- openFileForRead outputFileName >>= readFileContent
    content `shouldBe` "abcd"
