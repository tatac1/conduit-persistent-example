-- createDB.hs
{-# LANGUAGE OverloadedStrings #-}
import           Control.Monad.IO.Class      (liftIO)
import           Control.Monad.Logger
import           Database.Persist            (insertMany)
import           Database.Persist.Postgresql
-- import           Database.Persist.Sqlite     (runMigration, runSqlite)
import qualified Specs                       as S


db = "dbname=test host=localhost user=postgres port=5432"

dbRecordSize = 100000

main :: IO ()
-- main = runSqlite "test.sqlite" $ do
main = runNoLoggingT $ withPostgresqlPool db 10 $ \pool -> do
  -- Create test DB and populate with values
    liftIO $ flip runSqlPersistMPool pool $ do
        runMigration S.migrateAll
        _ <- insertMany $ map S.MyRecord [1..dbRecordSize]
        return ()
