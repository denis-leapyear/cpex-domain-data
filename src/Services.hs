module Services where

import Services.FileReaderServiceMData

data Services m readhandle = Services
  { fileReaderServiceMData :: FileReaderServiceMData m readhandle
  }
