module Services.FileReaderServiceM where


class MonadFileReaderServiceM m readhandle where
  openFileForRead :: String -> m readhandle
  readFileContent :: readhandle -> m String
