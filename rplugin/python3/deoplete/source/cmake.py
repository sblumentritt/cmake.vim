#!/usr/bin/env python3

import subprocess
from deoplete.source.base import Base


class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)

        # deoplete related variables
        self.rank = 1000
        self.name = "cmake"
        self.mark = "[cmake]"
        self.input_pattern = r"[^\w\s]$"

        self.min_pattern_length = 1
        self.filetypes = ["cmake"]
        self.vars = {}


    def gather_candidates(self, context):
        completion_candidates = []

        completion_candidates += self.vim.call("cmake#gather_candidates", "command")
        completion_candidates += self.vim.call("cmake#gather_candidates", "variable")
        completion_candidates += self.vim.call("cmake#gather_candidates", "property")

        return completion_candidates
