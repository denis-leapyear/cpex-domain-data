module Services.FileReaderService where

data FileReaderService m handle = FileReaderService
  { openFileForRead :: !(String -> m handle)
  , readFileContent :: !(handle -> m String)
  }
