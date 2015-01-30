-- selectList.hs
{-# LANGUAGE OverloadedStrings #-}

import           Control.Monad               (mapM_)
import           Control.Monad.IO.Class      (liftIO)
import           Control.Monad.Logger
import           Database.Persist            (entityVal, selectList)
import           Database.Persist.Postgresql
import           Specs                       (myRecordValue)


-- main :: IO ()
-- main = runSqlite "test.sqlite" $ do
db = "dbname=test host=localhost user=postgres port=5432"

main :: IO ()
-- main = runSqlite "test.sqlite" $ do
main = runNoLoggingT $ withPostgresqlPool db 10 $ \pool -> do
  -- Create test DB and populate with values
    liftIO $ flip runSqlPersistMPool pool $ do
        -- Select all records from DB and unpack into a list of Ints
        records <- selectList [] []
        let values = map (myRecordValue . entityVal) records
        mapM_ (liftIO . putStrLn . show) $ zip values $ tail values
