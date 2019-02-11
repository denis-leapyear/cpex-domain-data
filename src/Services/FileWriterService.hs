module Services.FileWriterService where


data FileWriterService m handle = FileWriterService
  { openFileForWrite :: !(String -> m handle)
  , writeFileContent :: !(handle -> String -> m ())
  }