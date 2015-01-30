-- selectSource.hs
{-# LANGUAGE OverloadedStrings #-}

import           Control.Monad.IO.Class      (MonadIO, liftIO)
import           Control.Monad.Logger
import           Data.Conduit                (Conduit, Sink, await, leftover,
                                              yield, ($$), (=$))
import qualified Data.Conduit.List           as CL
import           Database.Persist            (Entity, entityVal, selectSource)
import           Database.Persist.Postgresql
import           Specs                       (MyRecord (..), myRecordValue)

-- |Unpacks incoming values from upstream from MyRecord to Int
entityToValue :: Monad m => Conduit (Entity MyRecord) m Int
entityToValue = CL.map (myRecordValue . entityVal)

-- |Converts pairwise tuples of Ints into String
showPairs :: Monad m => Conduit Int m String
showPairs = do
  mi1 <- await -- get the next value from the input stream
  mi2 <- await
  case (mi1, mi2) of
    (Just i1, Just i2) -> do
      yield $ show (i1, i2) -- pass tuple of Ints converted
                            -- to String downstream
      leftover i2           -- pass the second component of
                            -- the tuple back to itself (to
                            -- the upstream)
      showPairs
    _ -> return ()

-- |Prints input String
printString :: (Monad m, MonadIO m) => Sink String m ()
printString = CL.mapM_ (liftIO . putStrLn)

db = "dbname=test host=localhost user=postgres port=5432"

main :: IO ()
-- main = runSqlite "test.sqlite" $ do
main = runNoLoggingT $ withPostgresqlPool db 10 $ \pool -> do
  -- Create test DB and populate with values
    liftIO $ flip runSqlPersistMPool pool $ do
        -- Select all records from DB and return them as a Source
        selectSource [] [] $$ entityToValue =$ showPairs =$ printString
