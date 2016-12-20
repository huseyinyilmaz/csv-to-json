-- | An example module.
module Exchange (main) where

-- import qualified Data.ByteString.Lazy as BL
-- import qualified Data.ByteString as B

-- import qualified Data.Csv as Csv
import qualified Data.Vector as V
import Pipes
-- import qualified Pipes.Safe.Prelude as PSP
import qualified Pipes.Prelude as P
import qualified System.IO as IO
-- import qualified Pipes.Safe as PS
import qualified Pipes.ByteString as PB
import qualified Data.Text as Text
import qualified Pipes.Csv as PCsv
-- import Pipes.Text.IO (fromHandle)
import Control.Monad (forever)
--import Control.Pipe.Common
-- import qualified Data.Text as Text
-- | An example function.
-- main :: IO ()
-- main = do
--   -- csvData <- BL.readFile "/Users/huseyinyilmaz/radius/RADIUS_US_EXTRACT_10_2016.txt"
--   csvData <- BL.readFile "/Users/huseyinyilmaz/test.csv"
--   case decode NoHeader csvData of
--     Left err -> putStrLn err
--     Right v -> putStrLn $ show $ (v::V.Vector (V.Vector BL.ByteString))

-- unpack :: Proxy () Text.Text () String IO ()
-- unpack = forever $ do
--     x <- await
--     yield $ Text.unpack x


showPipe :: Proxy () (Either String (V.Vector Text.Text)) () String IO b
showPipe = forever $ do
    x::(Either String (V.Vector Text.Text)) <- await
    yield $ show x


main :: IO ()
main = do
  IO.withFile "/Users/huseyinyilmaz/test.csv"
              IO.ReadMode
              (\handle -> do
                  let producer = (PCsv.decode PCsv.NoHeader (PB.fromHandle handle))
                  headers <- P.head producer
                  putStrLn "Header"
                  putStrLn $ show headers
                  putStrLn $ "Rows"
                  runEffect ( producer>->
                              (showPipe) >->
                              P.stdoutLn)
               )
  -- csvData <- BL.readFile "/Users/huseyinyilmaz/test.csv"
  -- case Csv.decode Csv.NoHeader csvData of
  --   Left err -> putStrLn err
  --   Right v -> putStrLn $ show $ (v::V.Vector (V.Vector Text.Text))
