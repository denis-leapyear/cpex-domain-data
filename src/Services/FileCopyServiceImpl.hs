module Services.FileCopyServiceImpl where

import Control.Monad (when)
import Control.Monad.IO.Class (MonadIO, liftIO)
import qualified System.IO as IO

import Services.GetEnvArgsService
import Services.FileReaderService
import Services.FileWriterService

import Services.FileSystemAndEnvServices

import Services.FileCopyService


createFileCopyService
  :: (Monad m, MonadIO m, handle ~ IO.Handle)
  => GetEnvArgsService m
  -> FileReaderService m readhandle
  -> FileWriterService m writehandle
  -> m (FileCopyService m)
createFileCopyService GetEnvArgsService{..} FileReaderService{..} FileWriterService{..} = pure
  FileCopyService
    { copyFileSpecifiedInArgs = do
        args <- getArgs
        when (length args /= 2) $ error "there must be exactly two arguments"
        let source = head args
            target = head . drop 1 $ args
        input <- openFileForRead source
        content <- readFileContent input
        output <- openFileForWrite target
        writeFileContent output content
    }

createFileCopyServiceAggregated
  :: (Monad m, MonadIO m, handle ~ IO.Handle)
  => FileSystemAndEnvServices m readhandle writehandle
  -> m (FileCopyService m)
createFileCopyServiceAggregated FileSystemAndEnvServices{..} = pure
  FileCopyService { copyFileSpecifiedInArgs = copyFileSpecifiedInArgsImpl }
    where
      copyFileSpecifiedInArgsImpl = do
        args <- getProgramArguments
        when (length args /= 2) $ error "there must be exactly two arguments"
        let source = head args
            target = head . drop 1 $ args
        content <- readFile source
        writeFile target content
