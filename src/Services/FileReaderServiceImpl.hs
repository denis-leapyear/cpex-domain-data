module Services.FileReaderServiceImpl where

import Control.Monad.IO.Class (MonadIO, liftIO)
import qualified System.IO as IO

import Services.FileReaderService


createFileReaderService
  :: (Monad m, MonadIO m, handle ~ IO.Handle)
  => m (FileReaderService m handle)
createFileReaderService = pure
  FileReaderService
    { openFileForRead = liftIO . (`IO.openFile` IO.ReadMode)
    , readFileContent = liftIO . IO.hGetContents
    }
