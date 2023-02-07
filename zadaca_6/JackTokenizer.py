from JackOutput import *
from JackError import *

#
#   Konstante.
#

# Tipovi tokena.
TK_KEYWORD = 1
TK_SYMBOL = 2
TK_IDENTIFIER = 3
TK_INT_CONST = 4
TK_STRING_CONST = 5
tokenTypes = ('<unknown>', '<keyword>', '<symbol>', '<identifier>',
              '<integer constant>', '<string constant>')

# Tipovi kljucnih rijeci u Jack jeziku.
KW_BOOLEAN = 1
KW_CHAR = 2
KW_CLASS = 3
KW_CONSTRUCTOR = 4
KW_DO = 5
KW_ELSE = 6
KW_FALSE = 7
KW_FIELD = 8
KW_FUNCTION = 9
KW_IF = 10
KW_INT = 11
KW_LET = 12
KW_METHOD = 13
KW_NULL = 14
KW_RETURN = 15
KW_STATIC = 16
KW_THIS = 17
KW_TRUE = 18
KW_VAR = 19
KW_VOID = 20
KW_WHILE = 21
keywords = {
    'boolean' : KW_BOOLEAN,
    'char' : KW_CHAR,
    'class' : KW_CLASS,
    'constructor' : KW_CONSTRUCTOR,
    'do' : KW_DO,
    'else' : KW_ELSE,
    'false' : KW_FALSE,
    'field' : KW_FIELD,
    'function' : KW_FUNCTION,
    'if' : KW_IF,
    'int' : KW_INT,
    'let' : KW_LET,
    'method' : KW_METHOD,
    'null' : KW_NULL,
    'return' : KW_RETURN,
    'static' : KW_STATIC,
    'this' : KW_THIS,
    'true' : KW_TRUE,
    'var' : KW_VAR,
    'void' : KW_VOID,
    'while' : KW_WHILE
}

# Simboli.
symbols = '{}()[].,;+-*/&|<>=~'

# Znamenke.
numberChars = '0123456789'

# Znakovi kojima pocinju int konstante.
numberStart = numberChars

# Znakovi kojima pocinju korisnicki zadana imena.
identStart = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_'

# Znakovi koje mogu sadrzavati korisnicki zadana imena.
identChars = identStart + numberChars
#
#
#

# Klasa tokenizer
#
# Prima input file i (opcionalno) output file. Parsira input file i razdvaja tzv.
# tokene koji mogu biti:
# - kljucne rijeci (_keyword),
# - integer i string konstante (_intVal i _stringVal),
# - simboli (_symbol),
# - korisnicki definirana imena (_identifier, npr. imena varijabli i funkcija).
#
# Ideja ove klase je da bude sastavni dio vece klase: kompajlera. Pozivom na metodu
# next ona dohvaca iduci token te za njega sprema informacije:
# - tokenType (jedna od TK_ konstanti)
# - keyword (ako je tokenType == TK_KEYWORD)
# - symbol (ako je tokenType == TK_SYMBOL)
# - identifier (ako je tokenType == TK_IDENTIFIER)
# - intVal (ako je tokenType == TK_INT_CONST)
# - stringVal (ako je tokenType == TK_STRING_CONST)
# Te informacije je moguce dohvatiti pomocu već implementiranih get metoda.
#
class Tokenizer:

    # Konstruktor prima input file i output file (ako je potreban).
    def __init__(self, ifile, ofile = None):
        self._ifile = ifile # Input.
        self._ofile = ofile # Output.

        # Ove su varijable potrebne za pravilno funkcioniranje klase.
        self._line = ""         # Linija u kojoj se trenutno nalazimo.
        self._rawline = ""      # Originalna linija, bez znaka '\n' u kojoj se trenutno nalazimo.
        self._lineNum = 0       # Broj linije u kojoj se trenutno nalazimo.
        self._comment = False   # Nalazimo li se u viselinijskom komentaru?

    # Pozivom na svaki next u vec navedene varijable spremaju se potrebni podaci
    # vezani uz sljedeci pronadjeni token. Metoda vraca True ukoliko parsiranje
    # nije zavrseno, inace False.
    def next(self):
        # While petlja parsira linije do pronalaska prvog tokena i iz njih
        # uklanja komentare. Petlja staje kada je input do kraja procitan.
        while True:
            if len(self._line) == 0:
                # 0. Citamo liniju iz inputa, popunjavamo potrebne varijable. Ako je
                #    _ofile razlicit od None, u njega upisujemo _rawLine bez znaka
                #    novog reda.
                self._rawline = self._ifile.readline()
                if len(self._rawline) == 0: return False
                self._rawline = self._rawline.replace('\n', ' ')
                self._lineNum += 1
                self._line = self._rawline

                if (self._ofile != None):
                        self._ofile.writeXML('source', '/// %d: %s' %(self._lineNum, self._rawline))

                # 1. Po potrebi uklanjamo viselinjske komentare kojih moze biti
                #    proizvoljno mnogo.
                if self._comment:
                    i = self._line.find("*/")
                    if i == -1:
                        self._line = ""
                    else:
                        self._line = self._line[i + 2:]
                        self._comment = False

                while True:
                    i = self._line.find("/*")
                    if i == -1: break
                    j = self._line.find("*/")
                    if j == -1:
                        self._comment = True
                        self._line = self._line[:i]
                        break
                    else:
                        self._line = self._line[:i] + ' ' + self._line[j + 2:]

                self._line = self._line.replace('\t', ' ').strip()

                # 4. Ako je nakon uklanjanja komentara linija i dalje neprazna u njoj
                #    trazimo token. Parsiranje tokena neka se vrsi u metodi _parseToken.
                # 5. Ako je nakon uklanjanja komentara linija prazna, ucitavamo novu
                #    liniju.
				
				# Uklonimo jednolinijski komentar (npr. find, split).
                i = self._line.find("//")
                if i != -1: self._line = self._line[:i]

                if len(self._line) == 0: continue

            self._parseToken()
            if (self._tokenType == None): continue
            return True

    # Funkcija iz trenutne linije (_line) parsira iduci token TE GA IZ NJE UKLANJA.
    def _parseToken(self):
        # Dolje su podaci koje trebamo postaviti za svaki pronadjeni token. Postavljamo
        # samo one podatke koji se odnose na pronadjeni token.
        self._tokenType = None   # Tip tokena (iz konstanti).
        self._keyword = None     # Kljucna rijec (iz konstanti).
        self._symbol = None      # Simbol (iz konstanti).
        self._identifier = None  # Korisnicki definiran naziv (iz konstanti).
        self._intVal = None      # Int konstanta (iz konstanti).
        self._stringVal = None   # String konstanta (iz konstanti).
        # Tokene prepoznajemo po charovima kojima pocinju.
        # - Ovdje preskacemo razmake. NE MORAJU svi tokeni biti odvojeni
        #   razmacima (npr. "objekt.varijabla su 3 tokena").
        # - Simboli su duljine jednog chara.
        # - Samo integer konstante pocinju znamenkama (koristiti _parseInt).
        # - Identifieri i keywordovi koriste isti alfabet, pa ih je potrebno
        #   razlikovati. Sjetite se, lista keywordova je konstantna. Koristiti
        #   metodu _parseIdent.
        # - String konstante pocinju i zavrsavaju znakom dvostrukog navodnika.
        #   Koristiti metodu _parseString.
        # - Nepoznatom tokenu postaviti tip TK_NONE.

        while len(self._line):
            c = self._line[0]

            if c == ' ':
                self._line = self._line[1:]
                continue
            if c in symbols:
                self._line = self._line[1:]
                self._tokenType = TK_SYMBOL
                self._symbol = c
                return
            if c in numberStart:
                self._tokenType = TK_INT_CONST
                self._intVal = self._parseInt()
                return
            if c in identStart:
                ident = self._parseIdent()
                if ident in keywords:
                    self._tokenType = TK_KEYWORD
                    self._keyword = ident
                else:
                    self._tokenType = TK_IDENTIFIER
                    self._identifier = ident
                return
            if c == '"':
                self._tokenType = TK_STRING_CONST
                self._stringVal = self._parseString()
                return

            raise JackError('Sytax error in line ' + str(self._lineNum) + ': illegal character "' + c + '".')

        self._tokenType = TK_NONE

    # Znamo da je token int pa ga parsiramo.
    def _parseInt(self):
        ret = 0
        while len(self._line):
            c = self._line[0]
            if c in numberChars:
                ret = ret * 10 + int(c)
            else:
                if c in ';)] ':
                    break
                raise JackError('Syntax error in line ' + str(self._lineNum) + ': number is not a valid integer.')
            if ret >= 32768:
                raise JackError('Overflow in line ' + str(self._lineNum) + ': number bigger than max integer constant.')
            self._line = self._line[1:]
        return ret

    # Znamo da je token keyword ili identifier pa ga parsiramo.
    def _parseIdent(self):
        ret = ""
        while len(self._line):
            c = self._line[0]
            if c in identChars:
                ret = ret + c
                self._line = self._line[1:]
            else:
                break
        return ret

    # Znamo da je token string pa ga parsiramo.
    def _parseString(self):
        ret = ""
        self._line = self._line[1:]
        while len(self._line):
            c = self._line[0]
            if c == '"':
                self._line = self._line[1:]
                return ret
            else:
                ret = ret + c
                self._line = self._line[1:]
        raise JackError('Sytax error in line ' + str(self._lineNum) + ': open string constant.')

    # Get metode - koristimo ih izvan klase.

    # Vraca broj trenutne linije.
    def lineNum(self):
        return self._lineNum

    # Vraca trenutnu liniju u izvornom obliku.
    def lineRaw(self):
        return self._rawline

    # Vraca trenutnu liniju, parsiranu.
    def line(self):
        return self._line

    # Vraca tip trenutnog tokena.
    def tokenType(self):
        return self._tokenType

    # Vraca ime tipa trenutnog tokena.
    def tokenTypeStr(self):
        if self._tokenType == TK_SYMBOL:
            return '"' + self._symbol + '"'
        if self._tokenType == TK_KEYWORD:
            return '"' + self._keyword + '"'
        return tokenTypes[self._tokenType]

    # Ako je trenutni token kljucna rijec, ovdje vracamo njezin tip.
    def keyword(self):
        return keywords[self._keyword]

    # Ako je trenutni token kljucna rijec, ovdje vracamo ime njezinog tipa.
    def keywordStr(self, keywordId = None):
        if (keywordId != None):
            for k in keywords:
                if keywords[k] == keywordId:
                    return k
            raise ValueError
        return self._keyword

    # Ako je trenutni token simbol, vracamo ga.
    def symbol(self):
        return self._symbol

    # Ako je trenutni token korisnicki zadano ime, vracamo ga.
    def identifier(self):
        return self._identifier

    # Ako je trenutni token int konstanta, vracamo ju.
    def intVal(self):
        return self._intVal

    # Ako je trenutni token string konstanta, vracamo ju.
    def stringVal(self):
        return self._stringVal