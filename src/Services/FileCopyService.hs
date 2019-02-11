module Services.FileCopyService where

data FileCopyService m = FileCopyService
  { copyFileSpecifiedInArgs :: !(m ())
  }