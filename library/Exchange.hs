-- | Main executable
module Exchange (main) where
import Conversion
import Turtle
import qualified Data.Text as Text

description :: Description
description = "Converts input csv file into a json file."

fileArgs :: Parser (Text, Text)
fileArgs = ((,) <$> (optText "input" 'i'  "input csv file.")
                <*> (optText "output" 'o'  "output json file."))

-- | Reads input parameters and copies input file path to output file path while
-- | changin the format from csv to json.
main :: IO ()
main = do
  (inFile, outFile) <- options description fileArgs
  copyFiles (fromString $ Text.unpack inFile) (fromString $ Text.unpack outFile)
