# Copyright (c) 2009
#   Dafydd Harries    <daf@rhydd.org>
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:

# 1. Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.

# 2. Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.

# 3. The names of the contributors may not be used to endorse or promote
# products derived from this software without specific prior written
# permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

import unittest

def read_file(path):
    fh = file(path)
    contents = fh.read()
    fh.close()
    return contents

def load_module(name, path):
    # hacketty hack

    mod = __builtins__.__class__(name)
    code = compile(read_file(path), path, 'exec')

    g, l = {}, {}
    exec code in g, l

    for k, v in l.iteritems():
        setattr(mod, k, v)

    return mod

xword = load_module('xword', 'xword')

class TestPuzzle(xword.Puzzle):
    def __init__(self):
        # Override Puzzle.__init__ to avoid having to read a file.
        pass

def dump_map(width, height, m):
    return ''.join([
        ' '.join([
            '%s' % m.get((x, y), '#')
            for x in xrange(width)]) + '\n'
        for y in xrange(height)])

class SetupTest(unittest.TestCase):
    def test_american(self):
        puzzle = TestPuzzle()
        puzzle.width = 5
        puzzle.height = 5
        puzzle.clues = [
            'a1', 'd1', 'd2', 'd3', 'a4', 'd5', 'a6', 'd7', 'a8', 'a9']
        puzzle.responses = dict([
            ((x, y), ' .'[int(x + y == 4 and x != 2 and y != 2)])
            for x in xrange(5)
            for y in xrange(5)])

        puzzle.setup()

        self.assertEquals([], puzzle.clues)

        self.assertEquals(
            {1: True, 2: False, 3: False, 4: True, 5: False, 6: True, 7: False,
             8: True, 9: True},
            puzzle.is_across)
        self.assertEquals(
            {8: 'a8', 1: 'a1', 4: 'a4', 6: 'a6', 9: 'a9'},
            puzzle.across_clues)
        self.assertEquals(
            '1 1 1 1 #\n'
            '4 4 4 # #\n'
            '6 6 6 6 6\n'
            '# # 8 8 8\n'
            '# 9 9 9 9\n',
            dump_map(puzzle.width, puzzle.height, puzzle.across_map))

        self.assertEquals(
            {1: True, 2: True, 3: True, 4: False, 5: True, 6: False, 7: True,
             8: False, 9: False},
            puzzle.is_down)
        self.assertEquals(
            {1: 'd1', 2: 'd2', 3: 'd3', 5: 'd5', 7: 'd7'},
            puzzle.down_clues)
        self.assertEquals(
            '1 2 3 # #\n'
            '1 2 3 # 5\n'
            '1 2 3 7 5\n'
            '1 # 3 7 5\n'
            '# # 3 7 5\n',
            dump_map(puzzle.width, puzzle.height, puzzle.down_map))

    def test_british(self):
        puzzle = TestPuzzle()
        puzzle.width = 5
        puzzle.height = 5
        puzzle.clues = ['a1', 'd1', 'd2', 'd3', 'a4', 'a5']
        puzzle.responses = dict([
            ((x, y), ' .'[int(x % 2 != 0 and y % 2 != 0)])
            for x in xrange(5)
            for y in xrange(5)])

        puzzle.setup()

        self.assertEquals([], puzzle.clues)

        self.assertEquals(
            {1: True, 2: False, 3: False, 4: True, 5: True},
            puzzle.is_across)
        self.assertEquals(
            {1: 'a1', 4: 'a4', 5: 'a5'},
            puzzle.across_clues)
        self.assertEquals(
            '1 1 1 1 1\n'
            '# # # # #\n'
            '4 4 4 4 4\n'
            '# # # # #\n'
            '5 5 5 5 5\n',
            dump_map(puzzle.width, puzzle.height, puzzle.across_map))

        self.assertEquals(
            {1: True, 2: True, 3: True, 4: False, 5: False},
            puzzle.is_down)
        self.assertEquals(
            {1: 'd1', 2: 'd2', 3: 'd3'},
            puzzle.down_clues)
        self.assertEquals(
            '1 # 2 # 3\n'
            '1 # 2 # 3\n'
            '1 # 2 # 3\n'
            '1 # 2 # 3\n'
            '1 # 2 # 3\n',
            dump_map(puzzle.width, puzzle.height, puzzle.down_map))

if __name__ == '__main__':
    unittest.main()

