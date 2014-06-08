module Templates.HActivityStringTemplate(
	getActivityStringTemplate,
    loadActivityStringTemplate
) where 

import Data.ByteString.Lazy (ByteString)
import Text.StringTemplate
import Control.Monad

getActivityStringTemplate nameActivity tpl =  do
                                t <- liftM (render . setAttribute "name" nameActivity) tpl
                                return t

loadActivityStringTemplate :: String -> IO (StringTemplate ByteString)
loadActivityStringTemplate nameTpl = do
								templates <- directoryGroup "/Users/jrm2k6/Documents/Programming/adom/androidtemplates" :: IO (STGroup ByteString)
								let res = case (getStringTemplate nameTpl templates) of
									Just t -> t
									Nothing -> error "Error"
								return res