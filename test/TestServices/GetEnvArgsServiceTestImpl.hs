module TestServices.GetEnvArgsServiceTestImpl where

import Services.GetEnvArgsService (GetEnvArgsService(..))

createGetEnvArgsTestService :: Monad m => [String] -> m (GetEnvArgsService m)
createGetEnvArgsTestService args = pure
  GetEnvArgsService
    { getArgs = pure args
    }
