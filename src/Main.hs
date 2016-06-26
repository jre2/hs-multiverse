import qualified Config as CFG
import Multiverse
import qualified Data.Map as M

{-
procStream ts = do
  orders <- getOrders (absNow ts) (relNow ts)
  let events = determineEvents (state ts) orders
  undefined
-}

mkEmptyState :: State
mkEmptyState = State { num=5 }

mkNewSim :: SimState
mkNewSim = SimState { timeWindow=tw, timeStreams=ts, rawOrders=ros, timeline=tline }
  where tw = TimeWindow { present=0, start=0, end=CFG.timeWindowLength }
        ts = [ TimeStream { timeStreamId=0, relNow=0, absNow=0, speed=CFG.naturalTimeStreamSpeed, state=mkEmptyState } ]
        ros = [] -- no orders
        tline = M.fromList [ (0,M.empty) ] -- no events

renderTimeStream :: TimeStream -> String
renderTimeStream ts = tsid ++ " " ++ padding ++ valstr
  where tsid = show $ timeStreamId ts
        val = num $ state ts
        valstr = if val < 10 then " " ++ show val else show val
        time = relNow ts
        paddingAmt = 2 * time
        padding = replicate paddingAmt ' '

render :: SimState -> IO ()
render sim = do
  putStrLn $ "----- Absolute time " ++ (show . present . timeWindow) sim ++ " -----"
  putStrLn $ "  " ++ relTimes
  putStrLn $ unlines $ map renderTimeStream (timeStreams sim)
    where relTimes = unwords $ map f ( [0..25] :: [Int] )
          f n | n < 10 = " " ++ show n
          f n = show n

main :: IO ()
main = do
  let st = mkNewSim
  render st
