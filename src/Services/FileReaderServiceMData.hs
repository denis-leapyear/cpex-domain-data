module Services.FileReaderServiceMData where

data FileReaderServiceMData m readhandle = FileReaderServiceMData
  { openFileForReadImpl :: !(String -> m readhandle)
  , readFileContentImpl :: !(readhandle -> m String)
  }