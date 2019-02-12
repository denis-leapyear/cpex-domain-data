module Services.FileSystemAndEnvServices where

import Services.GetEnvArgsService
import Services.FileReaderService
import Services.FileWriterService


data FileSystemAndEnvServices m readhandle writehandle = FileSystemAndEnvServices
  { getProgramArguments :: m [String]
  , readFile :: String -> m String
  , writeFile :: String -> String -> m ()
  }

createFileSystemAndEnvServices
  :: Monad m
  => GetEnvArgsService m
  -> FileReaderService m readhandle
  -> FileWriterService m writehandle
  -> m (FileSystemAndEnvServices m readhandle writehandle)
createFileSystemAndEnvServices GetEnvArgsService{..} FileReaderService{..} FileWriterService{..} =
  pure FileSystemAndEnvServices
    { getProgramArguments = getArgs
    , readFile = (readFileContent =<<) . openFileForRead
    , writeFile = writeFileImpl
    }
    where
      writeFileImpl path content = openFileForWrite path >>= (`writeFileContent` content)
