module Services.FileWriterServiceImpl where

import Control.Monad.IO.Class (MonadIO, liftIO)
import qualified System.IO as IO

import Services.FileWriterService


createFileWriterService
  :: (Monad m, MonadIO m, handle ~ IO.Handle)
  => m (FileWriterService m handle)
createFileWriterService = pure
  FileWriterService
    { openFileForWrite = \path -> liftIO $ IO.openFile path IO.WriteMode
    , writeFileContent = \handle content -> liftIO $ IO.hPutStr handle content >> IO.hClose handle
    }
