# Module Documentation

## Module Optic.Cons

### Type Classes

    class Cons s t a b where
      _Cons :: Prism (s a) (t b) (Tuple a (s a)) (Tuple b (t b))


### Type Class Instances

    instance consArray :: Cons Prim.Array Prim.Array a b


### Values

    (<|) :: forall a s. (Cons s s a a) => a -> s a -> s a

    cons :: forall a s. (Cons s s a a) => a -> s a -> s a

    head :: forall a s. (Cons s s a a) => TraversalP (s a) a

    tail :: forall a s. (Cons s s a a) => TraversalP (s a) (s a)

    uncons :: forall a s. (Cons s s a a) => s a -> Maybe (Tuple a (s a))


## Module Optic.Snoc

### Type Classes

    class Snoc s t a b where
      _Snoc :: Prism (s a) (t b) (Tuple (s a) a) (Tuple (t b) b)


### Type Class Instances

    instance snocArray :: Snoc Prim.Array Prim.Array a b


### Values

    (|>) :: forall a s. (Snoc s s a a) => s a -> a -> s a

    init :: forall a s. (Snoc s s a a) => TraversalP (s a) (s a)

    last :: forall a s. (Snoc s s a a) => TraversalP (s a) a

    snoc :: forall a s. (Snoc s s a a) => s a -> a -> s a

    unsnoc :: forall a s. (Snoc s s a a) => s a -> Maybe (Tuple (s a) a)



