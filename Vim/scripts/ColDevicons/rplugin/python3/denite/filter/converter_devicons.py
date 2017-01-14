# ============================================================================
# FILE: converter_devicons.py
# AUTHOR: 0phoff
# License: MIT license
# ============================================================================

from .base import Base
from os.path import isdir, isfile


class Filter(Base):

    def __init__(self, vim):
        super().__init__(vim)

        self.name = 'converter_devicons'
        self.description = 'add devicons in front of candidates'

    def filter(self, context):
        for candidate in context['candidates']:
            if isdir(candidate['word']):
                candidate['word'] = ' ' + self.vim.eval('g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol') + ' ' + candidate['word']
            elif isfile(candidate['word']):
                candidate['word'] = ' ' + self.vim.funcs.WebDevIconsGetFileTypeSymbol(candidate['word']) + candidate['word']
        return context['candidates']
