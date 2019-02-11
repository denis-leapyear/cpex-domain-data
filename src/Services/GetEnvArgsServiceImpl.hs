module Services.GetEnvArgsServiceImpl where

import Control.Monad.IO.Class (MonadIO, liftIO)
import qualified System.Environment as IO

import Services.GetEnvArgsService


createGetEnvArgsService :: (Monad m, MonadIO m) => m (GetEnvArgsService m)
createGetEnvArgsService = pure
  GetEnvArgsService
    { getArgs = liftIO IO.getArgs
    }