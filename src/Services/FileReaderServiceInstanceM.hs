module Services.FileReaderServiceInstanceM where

import MonadConfigurationProvider
import Services.FileReaderServiceM
import Services.FileReaderServiceMData

instance (Monad m, MonadConfigurationProvider m readhandle)
    => MonadFileReaderServiceM m readhandle where
  openFileForRead path = getFileReaderServiceMData >>= (`openFileForReadImpl` path)
  readFileContent handle = getFileReaderServiceMData >>= (`readFileContentImpl` handle)
