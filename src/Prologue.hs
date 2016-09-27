module Prologue
( module X
, lookup
, traceShowId
, (&&&)
, (***)
, hylo, cata, para
, module Data.Hashable
, last
) where

import Protolude as X
import Data.List (lookup, last)

import Control.Comonad.Trans.Cofree as X
import Control.Monad.Trans.Free as X
import Control.Comonad as X

import qualified GHC.Show as P
import qualified Debug.Trace as T

import Control.Arrow ((&&&), (***))

import Data.Functor.Foldable (hylo, cata, para)

import Data.Hashable
