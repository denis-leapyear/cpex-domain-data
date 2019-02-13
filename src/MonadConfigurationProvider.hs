module MonadConfigurationProvider where

import Services.FileReaderServiceMData

class MonadConfigurationProvider m readhandle where

  getFileReaderServiceMData :: m (FileReaderServiceMData m readhandle)
