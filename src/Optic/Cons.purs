module Optic.Cons
  ( Cons
  , (<|)
  , _Cons
  , cons
  , head
  , tail
  , uncons
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

  import Prelude hiding (cons)

  infixr 5 <|

  class Cons s t a b where
    _Cons :: Prism (s a) (t b) (Tuple a (s a)) (Tuple b (t b))

  instance consArray :: Cons [] [] a b where
    _Cons = prism (uncurry (:)) go
      where
        go []      = Left  []
        go (x:xs') = Right (Tuple x xs')

  (<|) :: forall a s. (Cons s s a a) => a -> s a -> s a
  (<|) = curry (simply review _Cons)

  cons :: forall a s. (Cons s s a a) => a -> s a -> s a
  cons = (<|)

  uncons :: forall a s. (Cons s s a a) => s a -> Maybe (Tuple a (s a))
  uncons xs = xs ^? _Cons

  head :: forall a s. (Cons s s a a) => TraversalP (s a) a
  head a2fsa sa = _Cons (_1 a2fsa) sa

  tail :: forall a s. (Cons s s a a) => TraversalP (s a) (s a)
  tail sa2fsa sa = _Cons (_2 sa2fsa) sa
