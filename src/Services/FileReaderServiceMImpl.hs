module Services.FileReaderServiceMImpl where

import Control.Monad.IO.Class (MonadIO, liftIO)
import qualified System.IO as IO

import Services.FileReaderServiceMData


createFileReaderServiceMData
  :: (Monad m, MonadIO m, readhandle ~ IO.Handle)
  => m (FileReaderServiceMData m readhandle)
createFileReaderServiceMData = pure
  FileReaderServiceMData
    { openFileForReadImpl = liftIO . (`IO.openFile` IO.ReadMode)
    , readFileContentImpl = liftIO . IO.hGetContents
    }