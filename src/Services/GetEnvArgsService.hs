module Services.GetEnvArgsService where

data GetEnvArgsService m = GetEnvArgsService
  { getArgs :: !(m [String])
  }
