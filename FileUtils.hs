import System.Environment
import Text.Parsec
import Text.Parsec.String
import Ast.AdomAst
import Templates.HActivityStringTemplate
import Control.Monad
import Data.ByteString.Lazy (ByteString) 
import Data.Text.Lazy (unpack)
import Data.Text.Lazy.Encoding (decodeUtf8)


openFile :: String -> IO String
openFile filename = readFile filename 

parseActivityName :: Parser ActivityElem
parseActivityName = do
    typeElem <- many1 letter
    char ' '
    nameElem <- many1 letter
    eol <|> eof
    return (ActivityElem nameElem)

writeActivityFile elements = do
                              let nameActivity = case elements of
                                    Right (ActivityElem e) -> e
                                    Left _                 -> error "Error"
                              content <- getActivityStringTemplate nameActivity $ loadActivityStringTemplate "activity_template"
                              writeFile (nameActivity++".java") (byteStringToString content)
                                      
byteStringToString :: ByteString -> String
byteStringToString = unpack . decodeUtf8 

eol :: Parser ()
eol = do oneOf "\n\r"
         return ()
      <?> "end of line"

main :: IO ()
main = do
        args <- getArgs
        defs <- openFile $ head args
        let elements = (parse parseActivityName "Error" defs)
        writeActivityFile elements