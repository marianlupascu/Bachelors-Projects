
import           Prelude hiding (lookup)
import qualified Data.List as List
import qualified Prelude (lookup)

addInOrderedList :: Ord k => (k, v) -> [(k, v)] -> [(k, v)]
addInOrderedList (k, v) [] = [(k, v)]
addInOrderedList (k, v) ((kh, vh):t)
  | k < kh = (k,v) : ((kh, vh):t)
  | k > kh = (kh, vh) : (addInOrderedList (k, v) t)

deleteFromOderList :: Ord k => k -> [(k, v)] -> [(k, v)]
deleteFromOderList _ [] = []
deleteFromOderList k ((kh, hv):t)
  | k == kh = t
  | otherwise = (kh, hv):(deleteFromOderList k t)

class Collection c where
  empty :: c key value
  singleton :: key -> value -> c key value
  insert
      :: Ord key
      => key -> value -> c key value -> c key value
  lookup :: Ord key => key -> c key value -> Maybe value
  delete :: Ord key => key -> c key value -> c key value
  keys :: c key value -> [key]
  values :: c key value -> [value]
  toList :: c key value -> [(key, value)]
  fromList :: Ord key => [(key,value)] -> c key value

newtype PairList k v
  = PairList { getPairList :: [(k, v)] }
  deriving Show

instance Collection PairList where
  empty = PairList []
  singleton k v = PairList [(k, v)]
  insert k v (PairList l) = PairList (addInOrderedList (k, v) l)
  lookup k (PairList l) = Prelude.lookup k l
  delete k (PairList l) = PairList (deleteFromOderList k l)
  keys (PairList l) = map fst l
  values (PairList l) = map snd l
  toList (PairList l) = l
  fromList l = (PairList l)

data SearchTree key value
  = Empty
  | Node
      (SearchTree key value) -- elemente cu cheia mai mica 
      key                    -- cheia elementului
      (Maybe value)          -- valoarea elementului
      (SearchTree key value) -- elemente cu cheia mai mare

order = 1

data Element k v
  = Element k (Maybe v)
  | OverLimit

data BTree key value
  = BEmpty
  | BNode [(BTree key value, Element key value)]

--singleton 3 5 :: PairList Int Int
