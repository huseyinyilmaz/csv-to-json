-- | An example module.
module Exchange (main) where
import Conversion
import Turtle
import qualified Data.Text as Text

description :: Description
description = "Convert a csv file into a json file."

fileArgs :: Parser (Text, Text)
fileArgs = ((,) <$> (optText "input" 'i'  "input csv file.")
                <*> (optText "output" 'o'  "output json file."))

-- | An example function.
main :: IO ()
main = do
  (inFile, outFile) <- options description fileArgs
  copyFiles (fromString $ Text.unpack inFile) (fromString $ Text.unpack outFile)
  -- where
  --   inFile = "/Users/huseyinyilmaz/radius/RADIUS_US_EXTRACT_10_2016.txt"
  --   outFile = "/Users/huseyinyilmaz/val.json"
