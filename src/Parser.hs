module Parser where

import Prologue hiding (Constructor)
import Data.Record
import Data.Text (pack)
import Category
import Info
import Range
import Syntax
import Term
import qualified Data.Set as Set
import Source

-- | A function that takes a source file and returns an annotated AST.
-- | The return is in the IO monad because some of the parsers are written in C
-- | and aren't pure.
type Parser fields = Source Char -> IO (Term Text (Record fields))

-- | Categories that are treated as fixed nodes.
fixedCategories :: Set.Set Category
fixedCategories = Set.fromList [ BinaryOperator, Pair ]

-- | Should these categories be treated as fixed nodes?
isFixed :: Category -> Bool
isFixed = flip Set.member fixedCategories

-- | Given a function that maps production names to sets of categories, produce
-- | a Constructor.
termConstructor :: (HasField fields Category, HasField fields Range) => Source Char -> (Record fields) -> [Term Text (Record fields)] -> Term Text (Record fields)
termConstructor source info children = cofree (info :< syntax)
  where
    syntax = construct children
    construct [] = Leaf . pack . toString $ slice (characterRange info) source
    construct children | isFixed (category info) = Fixed children
    construct children = Indexed children
