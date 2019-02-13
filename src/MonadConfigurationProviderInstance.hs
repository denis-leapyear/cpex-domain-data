module MonadConfigurationProviderInstance where

import Control.Monad.IO.Class (MonadIO)
import qualified System.IO as IO

import MonadConfigurationProvider
import Services.FileReaderServiceMImpl

instance (Monad m, MonadIO m, readhandle ~ IO.Handle)
    => MonadConfigurationProvider m readhandle where

  getFileReaderServiceMData = createFileReaderServiceMData
