module Optic.Snoc
  ( Snoc
  , (|>)
  , _Snoc
  , init
  , last
  , snoc
  , unsnoc
  ) where

  import Control.Lens.Equality (simply)
  import Control.Lens.Fold ((^?))
  import Control.Lens.Prism (prism)
  import Control.Lens.Review (review)
  import Control.Lens.Tuple (_1, _2)
  import Control.Lens.Type (Prism(), TraversalP())

  import Data.Either (Either(..))
  import Data.Maybe (Maybe())
  import Data.Tuple (curry, uncurry, Tuple(..))

  import qualified Data.Array as A
  import qualified Data.Array.Unsafe as AU

  infixl 5 |>

  class Snoc s t a b where
    _Snoc :: Prism (s a) (t b) (Tuple (s a) a) (Tuple (t b) b)

  instance snocArray :: Snoc [] [] a b where
    _Snoc = prism (uncurry A.snoc) go
      where
        go [] = Left  []
        go xs = Right (Tuple (AU.init xs) (AU.last xs))

  (|>) :: forall a s. (Snoc s s a a) => s a -> a -> s a
  (|>) = curry (simply review _Snoc)

  snoc :: forall a s. (Snoc s s a a) => s a -> a -> s a
  snoc = curry (simply review _Snoc)

  unsnoc :: forall a s. (Snoc s s a a) => s a -> Maybe (Tuple (s a) a)
  unsnoc xs = xs ^? _Snoc

  init :: forall a s. (Snoc s s a a) => TraversalP (s a) (s a)
  init sa2fsa sa = _Snoc (_1 sa2fsa) sa

  last :: forall a s. (Snoc s s a a) => TraversalP (s a) a
  last sa2fsa sa = _Snoc (_2 sa2fsa) sa
