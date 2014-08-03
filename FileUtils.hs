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

parseExtras :: Parser ExtraElem
parseExtras = do
    indent
    nameOption <- many1 letter
    char ' '
    typeOption <- many1 letter
    char ' '
    valueOption <- many letter
    eol <|> eof
    return (ExtraElem typeOption valueOption)

wholeFile = do
    activityDecl <- parseActivityName
    extraDecl <- parseExtras
    return (TopLevelActivity activityDecl [extraDecl])

writeActivityFile elements = do
                              let nameActivity = case elements of
                                    Right (ActivityElem e) -> e
                                    Left _                 -> error "Error"
                              content <- getActivityStringTemplate nameActivity $ loadActivityStringTemplate "activity_template"
                              writeFile (nameActivity ++ ".java") (byteStringToString content)

printDebug elements = do
                       let extraStatement = case elements of 
                                  Right (TopLevelActivity (ActivityElem a) e) -> generateCode a
                                  Left _  -> error "Error extra"
                       print extraStatement

generateCode actElem = do
                  putStrLn actElem

byteStringToString :: ByteString -> String
byteStringToString = unpack . decodeUtf8 

eol :: Parser ()
eol = do oneOf "\n\r"
         return ()
      <?> "end of line"

indent :: Parser ()
indent = do oneOf "\t"
            return ()
         <?> "no indent"

main :: IO ()
main = do
        args <- getArgs
        defs <- openFile $ head args
        let elements = (parse wholeFile "Error" defs)
        printDebug elements
        --writeActivityFile elements