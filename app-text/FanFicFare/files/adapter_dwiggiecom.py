# -*- coding: utf-8 -*-

# Copyright 2011 Fanficdownloader team
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

import logging
import re

from ..htmlcleanup import stripHTML
from .. import exceptions as exceptions
from ..six.moves.urllib.error import HTTPError

from .base_adapter import BaseSiteAdapter,  makeDate

logger = logging.getLogger(__name__)


def getClass():
    return DwiggieComAdapter

# Class name has to be unique.  Our convention is camel case the
# sitename with Adapter at the end.  www is skipped.


class DwiggieComAdapter(BaseSiteAdapter):

    def __init__(self, config, url):
        BaseSiteAdapter.__init__(self, config, url)

#         1252 is a superset of iso-8859-1.  Most sites that claim to be
#         iso-8859-1 (and some that claim to be utf8) are really windows-1252.
        self.decode = ["Windows-1252", "utf8"]

#         if left empty, site doesn't return any message at all.
        self.username = "NoneGiven"
        self.password = ""
        self.is_adult = False
        self.sectionUrl = ""
        self.section = []
        self.chapters = dict()


#        # get storyId from url--url validation guarantees query is only
#        # sid=1234
#        self.story.setMetadata('storyId',self.parsedUrl.query.split('=',)[1])
#        logger.debug("storyId: (%s)"%self.story.getMetadata('storyId'))

#         get storyId from url--url validation guarantees query correct
        m = re.match(self.getSiteURLPattern(), url)
        if m:
            self.story.setMetadata('storyId', m.group('id'))
            logger.debug("storyId: (%s)" % self.story.getMetadata('storyId'))
            # normalized story URL.
            self._setURL('https://www.' + self.getSiteDomain() +
                         '/derby/'+self . story.getMetadata('storyId')+'.htm')
        else:
            raise exceptions.InvalidStoryURL(url,
                                             self.getSiteDomain(),
                                             self.getSiteExampleURLs())

#         Each adapter needs to have a unique site abbreviation.
        self.story.setMetadata('siteabbrev', 'dwg')

#         The date format will vary from site to site.
#         http://docs.python.org/library/datetime.html#strftime-strptime-behavior
        self.dateformat = "%m/%d/%y"

    @staticmethod  # must be @staticmethod, don't remove it.
    def getSiteDomain():
        # The site domain.  Does have www here, if it uses it.
        return 'dwiggie.com'

    @classmethod
    def getAcceptDomains(cls):
        return ['www.dwiggie.com', 'dwiggie.com', 'thedwg.com', 'TheDWG.com']

    def getSiteExampleURLs(self):
        return "https://"+self.getSiteDomain()+"/derby/name1b.htm"

    def getSiteURLPattern(self):
        # https://www.dwiggie.com/derby/mari17b.htm
        return r"https?://(www.)?(thedwg|TheDWG|dwiggie)\.com/derby/(?P<id>(old_\d{4}\/|old[a-z]\/)?[a-z]+\d+)(?P<part>[a-z]*)\.htm$"

    def tryArchivePage(self, url):
        try:
            data = self.get_request(url)

        except HTTPError as e:
            if e.code == 404:
                # need to change the exception returned
                raise exceptions.StoryDoesNotExist(self.meta)
            else:
                raise e

        archivesoup = self.make_soup(data)
        m = re.compile(r"/derby/" +
                       self.story.getMetadata('storyId')+"[a-z]?.htm$")
#        print(m.pattern)
#        print(archivesoup)
        a = archivesoup.find('a', href=m)

        return a

    def getGenre(self, url):
        if re.search('id=E', url):
            genre = 'Epilogue Abbey'
        else:
            genre = 'Fantasia Gallery'
        self.story.addToList('genre', genre)

    def getItemFromArchivePage(self):

        urls = ["https://www.dwiggie.com/toc/index.php?id=E&page=all&comp=n",
                "https://www.dwiggie.com/toc/index.php?id=F&page=all&comp=n"]
        for url in urls:
            a = self.tryArchivePage(url)
            if a is not None:
                self.getGenre(url)
                return a.parent
        else:
            return None

    def getMetaFromSearch(self):

        params = {}
        params['title_name'] = self.story.getMetadata('title')

        searchUrl = "https://" + self.getSiteDomain() + "/toc/search.php"

        d = self._postUrl(searchUrl, params)
#        print(d)

        searchsoup = self.make_soup(d)
        m = re.compile(r"/derby/" + self.story.getMetadata('storyId') +
                       "[a-z]?.htm$")
#        print(m.pattern)
#        print(self.story.getMetadata('storyId'))
        a = searchsoup.find('a', href=m)

        return a

    def getChaptersFromPage(self, url):
        try:
            data = self.get_request(url)
        except HTTPError as e:
            if e.code == 404:
                return []
            else:
                raise e

        s = self.story.getMetadata('storyId').split('/')
        s.reverse()
        storyId_trimmed = s[0]

        m = re.match(r'.*?<body[^>]*>(\s*<ul>)?(?P<content>.*?)(</body>|$)',
                     data, re.DOTALL)
        newdata = m.group('content')
        regex = re.compile(r'<a\ href\=\"' + storyId_trimmed +
                           r'[a-z]?.htm\">(Continued\ [Ii]n\ |Continue\ [Oo]n\ [Tt]o\ )?(the\ )?([Nn]ext\ [Ss]ection|[Ss]ection\ [0-9IVXCL]+)</a>')
        newdata = re.sub(regex, '', newdata)


#        pagesections = filter(lambda x: x!=None, re.split('(?m)<hr( \/)?>|<p>\s*<hr( \/)?>\s*<\/p>', newdata, re.MULTILINE))
#        pagesections = filter(lambda x: x!=None, re.split('(?m)(<p>\s*)*<hr( \/)?>(\s*<\/p>)?', newdata, re.MULTILINE))
        pagesections = filter(lambda x: x != None, re.split(r'<hr( \/)?>', newdata))
        pagesections = filter(lambda x: x.strip() != '/', pagesections)
#        regex = re.compile(r'(href\="'+storyId_trimmed+'[a-z]?.htm$"')
#        pagesections = filter(lambda x: re.search(re.compile(storyId_trimmed + "[a-z]?.htm$"),x)==None, pagesections)
        pagesections.pop(0)     # always remove header

        regex = re.compile(r'(?m)(href\="' + storyId_trimmed +
                           r'[a-z]?.htm\"|Copyright\ held\ by\ the\ author|<p>\s*(Section\ I|Beginning),\s*</?p>)', re.MULTILINE)
        s = filter(lambda x: regex.search(x), pagesections)
#        print(s)
        pagesections = filter(lambda x: not regex.search(x), pagesections)
#        print(pagesections[0])
        return pagesections

    # Getting the chapter list and the meta data, plus 'is adult' checking.
    def extractChapterUrlsAndMetadata(self):

        url = self.url
        meta = self.getItemFromArchivePage()
#        print(meta)

#         Title
        t = meta.a
        self.story.setMetadata('title', t.string.strip())

#         Author
        author = meta.find('a', 'author_link')
        if author is not None:
            self.story.setMetadata('author', author.string.strip())
            self.story.setMetadata('authorId', author['href'].split('=')[1])
            self.story.setMetadata('authorUrl', author['href'])
            author = author.parent
        else:
            author = meta.i
            self.story.setMetadata('author',
                                   author.string.replace('Written by', '')
                                   .strip())
            self.story.setMetadata('authorId', 'unknown')
            self.story.setMetadata('authorUrl', 'unknown')


#         DateUpdated
        dUpdate = meta.find('i', text=re.compile('Last update'))
        du = dUpdate.replace('Last update', '').replace('.', '').strip()
        try:
            self.story.setMetadata('dateUpdated',
                                   makeDate(du, self.dateformat))
        except ValueError:
            self.story.setMetadata('dateUpdated', makeDate(du, "%m/%d/%Y"))
        compImg = meta.find('img', alt="Dot")
        if compImg is not None:
            self.story.setMetadata('status', 'Completed')
        else:
            self.story.setMetadata('status', 'In-Progress')


#         Summary & Category
#         Get the summary components from the meta listing
        metalist = meta.contents
        s = []
        for x in range(0, len(metalist)-1):
            item = metalist[x]
            if item == author or item == compImg:
                s = []
                continue
            if item == dUpdate or item == dUpdate.parent:
                break
            s.append(item)

#         create a soup object from the summary components
        soup = self.make_soup("<p></p>")
        d = soup.p
        for x in s:
            d.append(x)
#        print(d)

#         extract category from summary text
        desc = stripHTML(d)
        books = re.compile(r'(?P<book>\~P&P;?\~|\~Em;?\~|\~MP;?\~|\~S\&S;?\~|\~Per;?\~|\~NA;?\~|\~Juv;?\~|\~Misc;?\~)')
        booklist = dict({'~P&P~': 'Pride and Prejudice', '~Em~': 'Emma',
                        '~MP~': 'Mansfield Park', '~S&S~':
                         'Sense and Sensibility', '~Per~': 'Persuasion',
                         '~NA~': 'Northanger Abbey', '~Juv~': 'Juvenilia',
                         '~Misc~': 'Miscellaneous'})
        m = re.search(books, desc)
        print(m.group('book'))
        book = booklist.get(m.group('book').replace(';', ''))
        print(book)
        self.story.addToList('category', book)


#         assign summary info
        desc = stripHTML(desc).replace(book, '').strip()
        desc = re.sub(r'^.\s*', '', desc)
        if desc is not None:
            self.setDescription(url, desc)

#        # Chapters (Sections in this case-don't know if we can subdivide them)

#         get the last Section from the archive page link
#        chapters = ["https://www.dwiggie.com"+t['href']]

#         get the section letter from the last page
        tempUrl = t['href']
        if "http://thedwg.com/" in tempUrl:
            tempUrl = tempUrl.replace("http://thedwg.com/", "/")
        elif "http://TheDWG.com/" in tempUrl:
            tempUrl = tempUrl.replace("http://TheDWG.com/", "/")
        elif "https://thedwg.com/" in tempUrl:
            tempUrl = tempUrl.replace("https://thedwg.com/", "/")
        elif "https://TheDWG.com/" in tempUrl:
            tempUrl = tempUrl.replace("https://TheDWG.com/", "/")
        m = re.match("/derby/" + self.story.getMetadata('storyId') +
                     "(?P<section>[a-z]?).htm$", tempUrl)
        inc = m.group('section')
        if inc == '':
            inc = 'a'

#         get the presumed list of section urls with 'lower' section letters
        sections = []
        baseurl = "https://www.dwiggie.com/derby/"+self.story.getMetadata('storyId')
        extension = ".htm"
        ordend = ord(inc)
        ordbegin = ord('a')
        for numinc in range(ordbegin, ordend+1):
                inc = chr(numinc)
                if inc == 'a':
                    sections.append(baseurl+extension)
                else:
                    sections.append(baseurl+inc+extension)

        # Process List of Chapters
        # create 'dummy' urls for individual chapters in the form
        # 'pageurl#pageindex' where page index is an index starting with 0 per
        # page
        c = 0
        postdate = None
        chapters = []
        for x in range(0, len(sections)):
            section = sections[x]
            i = 0
            for chapter in self.getChaptersFromPage(section):
                c += 1
                chaptersoup = self.make_soup(chapter)
#                self.chapterUrls.append(('Chapter '+str(c),section+'#'+str(i)))
                cUrl = section+'#'+str(i)
                t = chaptersoup.find('font', size="+1", color="#336666")
                ctitle = ''
                if t is not None:
                    ctitle = stripHTML(t)
#                self.chapterUrls.append(('Chapter '+str(c),cUrl))
                self.chapterUrls.append((ctitle, cUrl))
                chapters.append((cUrl, chaptersoup))
                if postdate is None:
                    regex = re.compile(r'Posted\ on\:?\ (?P<date>\d{4}\-\d{2}\-\d{2}|\w+,\ \d+\ \w+\ \d{4})')
                    # Sunday, 21 March 2004, at 6:00 a.m.
                    m = re.search(regex, chapter)
                    if m is not None:
                        postdate = m.group('date')
                i += 1
        self.chapters = dict(chapters)
#        print(postdate)
        pubdate = None
        if postdate is not None:
            format1 = re.match(re.compile(r'\d{4}\-\d{2}\-\d{2}'), postdate)
            format2 = re.match(re.compile(r'\w+,\ \d+\ \w+\ \d{4}'), postdate)
            if format1 is not None:
                pubdate = makeDate(postdate, "%Y-%m-%d")
            if format2 is not None:
                pubdate = makeDate(postdate, "%A, %d %B %Y")

        if pubdate is None:
            pubdate = makeDate(self.story.getMetadata('dateUpdated'),
                               "%Y-%m-%d")
#        print(pubdate)
        self.story.setMetadata('datePublished', pubdate)
#        print(self.story.getMetadata('dateUpdated'))
#        print(self.story.getMetadata('datePublished'))
        self.story.setMetadata('numChapters', c)
        logger.debug("numChapters: (%s)" % self.story.getMetadata('numChapters'))

    # grab the text for an individual chapter.
    def getChapterText(self, url):
        logger.debug('Getting chapter text from: %s' % url)

        chapter = self.chapters.get(url)
#        for c in self.chapters:
#            if c[0] == url:
#                chapter = c[1]
#                chapter = self.make_soup(c[1])

#        chapter = find(lambda c: c[0] == url, self.chapters)[1]
#        page_url = url.split('#')[0]
#        x = url.split('#')[1]
#        if self.sectionUrl != page_url:
#            self.sectionUrl = page_url
#            self.section = self.getChaptersFromPage(page_url)
#
#        chapter = self.make_soup(self.section[int(x)])

#        chapter = self.make_soup(self.getChaptersFromPage(page_url)[int(x)])

        return self.utf8FromSoup(url, chapter)
