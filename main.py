

from curses import nonl
from typing import List, Optional

class TreeNode:
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right
class Solution:
    def buildTree(self, preorder: List[int], inorder: List[int]) -> Optional[TreeNode]:
        hm = {val: idx for idx, val in enumerate(preorder)}
        i = 0
        def build():
            return 
        return root
            
sol = Solution()
sol.buildTree([3,9,20,15,7], [9,3,15,20,7])
