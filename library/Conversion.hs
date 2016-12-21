module Conversion where

import qualified Data.Vector as V
import Pipes
import qualified Pipes.Prelude as P
import qualified System.IO as IO
import qualified Pipes.ByteString as PB
import qualified Pipes.Text.IO as PTIO
import qualified Data.Text as Text
import qualified Data.Text.Lazy.Encoding as Encoding
import qualified Data.Text.Lazy as LazyText
import qualified Pipes.Csv as PCsv
import Control.Monad (forever)
import qualified Data.HashMap.Strict as HM
import qualified Data.Aeson as Aeson

addNewLine :: Text.Text -> Text.Text
addNewLine t = Text.concat [t, "\n"]

toJSON :: V.Vector Text.Text ->  Proxy () (V.Vector Text.Text) () Text.Text IO ()
toJSON headers = forever $ do
  vals <- await
  let res = Aeson.Object $ HM.fromList (V.toList $ V.zip headers (V.map Aeson.String vals))
  (yield .
   addNewLine .
   LazyText.toStrict .
   Encoding.decodeUtf8 .
   Aeson.encode) res

copyFiles :: FilePath -> FilePath -> IO ()
copyFiles inFile outFile =
  IO.withFile inFile IO.ReadMode
  (\hin -> IO.withFile outFile IO.WriteMode (handleFile hin))
  where
    handleFile hin hout = do
      -- producer :: Producer (Either String (V.Vector Text.Text)) IO ()
      let eitherProducer :: Producer (Either String (V.Vector Text.Text)) IO ()
          eitherProducer = (PCsv.decode PCsv.NoHeader (PB.fromHandle hin))
          producer :: Producer (V.Vector Text.Text) IO ()
          producer = eitherProducer >-> P.concat
          consumer = PTIO.toHandle hout
      e <- next producer
      case e of
        Left () -> putStrLn "No lines!"
        Right (headers, bodyProducer) -> do
          runEffect ( bodyProducer >-> (toJSON headers) >-> consumer)
