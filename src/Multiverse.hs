module Multiverse where

--import Control.Concurrent.STM
import qualified Data.Map as M

-- Time
type Time    = Int
type AbsTime = Time -- how many (real world) turns since the start of the game
type RelTime = Time -- how many turns since the start of the game relative to a time stream

-- TimeStreams, TimeWindow, and overall Sim
type TimeStreamId = Int

data TimeStream = TimeStream {
  timeStreamId :: TimeStreamId,
  relNow :: RelTime,
  absNow :: AbsTime,
  speed :: Time,
  state :: State
  } deriving Show

data TimeWindow = TimeWindow {
  present :: AbsTime,
  start :: AbsTime,
  end :: AbsTime
  } deriving Show

data SimState = SimState {
  timeWindow :: TimeWindow,
  timeStreams :: [TimeStream],
  rawOrders :: RawOrders,
  timeline :: Timeline
  } deriving Show

-- State
type RawOrders = [ (AbsTime, RelTime, Order) ] -- from this, we generate [Order] for a given RelTime, skipping any beyond sim's abs time
type Timeline = M.Map RelTime ( M.Map TimeStreamId ( AbsTime, [Event] ) )

data State = State { num :: Int } deriving Show
data Order = Order | Chronoport deriving Show
data Event = Event deriving Show
