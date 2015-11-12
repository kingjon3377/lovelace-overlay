# starconvert specification file for Gliese data catalog
# version 3-0.95

comments; 189; 257

[coordinates]
type; celestial

ra-hours; 13; 14
ra-min;   16; 17
ra-sec;   19; 20

dec-sign; 22
dec-deg;  23; 24
dec-min;  26; 29

[characteristics]
specclass; 55; 66

distance;  milliarcsec; 109; 114
magnitude; absolute;    122; 126

[systems]
component;  9; 10
separation; comments; a = ; Sep; sep

[names]
bayer;          comments # e.g. "Alpha Cen", "Tau Cet"
flamsteed;      comments # e.g. "40 Eri"
const-specific; comments # includes, e.g., "q Car", "VV Ori"
other;          comments; Ross; Wolf

other;          147; 152; HD # Henry Draper catalog number
dm;             154; 165     # Durchmusterung number BD / CD / CP
other;          comments; L = Luyten # i.e. substitute "Luyten" for "L"

other;          167; 175 # for Gliese catalog, this field is the Giclas number
other;          177; 181; LHS # for Gliese catalog, this field is LHS number
other;          183; 187 # for Gliese catalog, includes some other designations
other;          1; 8     # for Gliese catalog, includes Gliese and Woolley des.

# A whole bunch of other designations appear in the Gliese catalog "Remarks"
#  field, out of which I have no idea which ones are "preferred" by
#  astronomers; hence, they're alphabetical.  Rearrange as you like.

other;          comments; ADS; BPM; BS; CFS; DON; FK; GD; GJ; GR; GSC
other;          comments; Hei; Hy; IE; LDS; LE; LFT; LP; LTT; MW; NSV
other;          comments; PG; PS; RGO; Rob; RST; SA; San; Sm; Steph
other;          comments; USN; USNO; VA; VB; VVO; Wo; Wor; WOR

[substitutions]
case-sensitive

# Well-known common names of stars in the Gliese catalog:
Alpha CMa;         Sirius
Alpha Boo;         Arcturus
Alpha Lyr;         Vega
Alpha Aur;         Capella
Alpha CMi;         Procyon
Alpha Aql;         Altair
Alpha Tau;         Aldebaren
Beta Gem;          Pollux
Alpha PsA;         Fomalhaut
Alpha Gem;         Castor

# Gliese et al missed a lot of Bayer designations, so I've filled them in here.
#  There are probably others which I have missed.

HD 739;            Theta Scl
HD 3003;           Beta(3) Tuc
HD 3302;           Lambda(2) Phe
HD 11171;          Chi Cet
HD 17094;          Mu Cet   
HD 18907;          Epsilon For
HD 33111;          Beta Eri
HD 39091;          Pi Men
HD 40183;          Beta Aur
HD 56537;          Lambda Gem
HD 71878;          Beta Vol
HD 79096;          Pi(1) Cnc
HD 81997;          Tau(1) Hya
HD 95418;          Beta UMa
HD 96202;          Chi(1) Hya
HD 101198;         Iota Crt
HD 116656;         Zeta UMa # Mizar; see below
HD 118098;         Zeta Vir
HD 124850;         Iota Vir
HD 125161;         Iota Boo
HD 129502;         Mu Vir
HD 129972;         Omicron Boo
HD 130819;         Alpha(1) Lib
HD 130841;         Alpha(2) Lib
HD 134505;         Zeta Lup
HD 137108;         Eta CrB
HD 137391;         Mu(1) Boo
HD 137392;         Mu(2) Boo
HD 138905;         Gamma Lib
HD 141795;         Epsilon Ser
HD 142908;         Lambda CrB
HD 144070;         Xi Sco
HD 144197;         Delta Nor
HD 146362;         Sigma CrB
HD 146686;         Gamma(2) Nor
HD 146791;         Epsilon Oph
HD 147449;         Sigma Ser
HD 152786;         Zeta Ara
HD 153580;         Epsilon(2) Ara
HD 154906;         Mu Dra
HD 156164;         Delta Her
HD 160922;         Omega Dra
HD 162004;         Psi(1) Dra
HD 164764;         Tau Oph
HD 175190;         Nu(2) Sgr
HD 177241;         Omicron Sgr
HD 177716;         Tau Sgr
HD 177724;         Zeta Aql
HD 181577;         Rho(1) Sgr
HD 184406;         Mu Aql
HD 191862;         Xi(2) Cap
HD 197157;         Eta Ind
HD 201184;         Chi Cap
HD 202730;         Theta Ind
HD 210418;         Theta Peg
HD 211336;         Epsilon Cep
HD 212061;         Gamma Aqr
HD 215665;         Lambda Peg
HD 215789;         Epsilon Gru
HD 216131;         Mu Peg
HD 216336;         Gamma PsA
HD 216385;         Sigma Peg
HD 216435;         Tau(1) Gru
HD 219571;         Gamma Tuc
HD 219693;         Phi Gru
HD 219784;         Gamma Scl
HD 222107;         Lambda And
HD 222661;         Omega(2) Aqr

# Here are a large number of HD -> Flamsteed conversions.
#  (Gliese et al included very few Flamsteed numbers in their catalog.)
HD 693;            6 Cet
HD 1835;           9 Cet
HD 3196;           13 Cet
HD 3651;           54 Psc
HD 4307;           18 Cet
HD 4676;           64 Psc
HD 7439;           37 Cet
HD 10476;          107 Psc
HD 13612;          66 Cet
HD 15814;          29 Ari
HD 16141;          79 Cet
HD 16739;          12 Per
HD 18803;          51 Ari
HD 19994;          94 Cet
HD 22484;          10 Tau
HD 25680;          39 Tau
HD 25998;          50 Per
HD 29503;          53 Eri
HD 30495;          58 Eri
HD 32537;          9 Aur
HD 32923;          104 Tau
HD 33021;          13 Ori
HD 33256;          68 Eri
HD 35296;          11 Tau
HD 37507;          49 Ori
HD 43042;          71 Ori
HD 43386;          74 Ori
HD 50635;          38 Gem
HD 50692;          37 Gem
HD 58855;          22 Lyn
HD 64096;          9 Pup
HD 68146;          18 Pup
HD 70958;          1 Hya
HD 78209;          15 UMa
HD 78418;          75 Cnc
HD 79028;          16 UMa
HD 79439;          18 UMa
HD 81937;          23 UMa
HD 82210;          24 UMa
HD 86146;          19 LMi
HD 86728;          20 LMi
HD 87696;          21 LMi
HD 89125;          39 Leo
HD 89449;          40 Leo
HD 90839;          36 UMa
HD 95128;          47 UMa
HD 99491;          83 Leo
HD 100563;         89 Leo
HD 101501;         61 UMa
HD 106251;         12 Vir
HD 110897;         10 CVn
HD 111998;         38 Vir
HD 115202;         57 Vir
HD 115383;         59 Vir
HD 115617;         61 Vir
HD 116842;         80 UMa # Alcor; see below
HD 116976;         69 Vir
HD 117176;         70 Vir
HD 119756;         1 Cen
HD 123999;         12 Boo
HD 124206;         50 Hya
HD 125451;         18 Boo
HD 132052;         16 Lib
HD 134083;         45 Boo
HD 142267;         39 Ser
HD 143333;         49 Lib
HD 146233;         18 Sco
HD 149661;         12 Oph
HD 153597;         19 Dra
HD 155886;         36 Oph
HD 157214;         72 Her
HD 157792;         44 Oph
HD 160269;         26 Dra
HD 160915;         58 Oph
HD 165341;         70 Oph
HD 165777;         72 Oph
HD 165908;         99 Her
HD 168151;         36 Dra
HD 173667;         110 Her
HD 174116;         29 Sgr
HD 180777;         59 Dra
HD 182572;         31 Aql
HD 186408;         16 Cyg
HD 187013;         17 Cyg
HD 190406;         15 Sge
HD 198809;         31 Vul
HD 207978;         15 Peg
HD 212698;         53 Aqr
HD 212754;         34 Peg
HD 217014;         51 Peg
HD 219080;         7 And
HD 219834;         94 Aqr
HD 224930;         85 Peg

# You can substitute more than once for the same star, but the substitutions
#  have to be in the right order.
Zeta UMa;          Mizar # follows "HD 116656" -> "Zeta UMa" substitution above
80 UMa;            Alcor # follows "HD 116842" -> "80 UMa" substitution above

# A few less well-known common names of stars.
# These should be inserted after their Bayer designations in priority.
# This only works with starconvert >= 0.95:
Alpha Cen;         Rigil Kent;	2
Beta Leo;          Denebola;	2
Alpha Oph;         Ras Alhague;	2
Beta UMa;          Merak;	2
Delta UMa;         Megrez;	2
Epsilon UMa;       Alioth;	2

# Well-known nearby dwarf stars
G001-027;          van Maanen's Star
HD 33793;          Kapteyn's Star
HD 95735;          Lalande 21185
BD +04°3561a;      Barnard's Star

# Companion stars
HD 10360;          P Eri B
HD 60178;          Castor B
HD 98230;          Xi UMa B
HD 110380;         Gamma Vir B
HD 114379;         Alpha Com B
HD 116657;         Mizar B
HD 128621;         Alpha Cen B
HD 144069;         Xi Sco B
HD 154905;         Mu Dra B
HD 155885;         36 Oph B
HD 177475;         Gamma CrA B
HD 201092;         61 Cyg B

Gl 23;             13 Cet B
Gl 105.4;          Epsilon Cet B
Gl 106.1;          Gamma Cet B
Gl 171.1;          Aldebaren B
Gl 188;            104 Tau B
Gl 194;            Capella B
Gl 271;            Delta Gem B
Gl 291;            9 Pup B
Gl 337;            Pi(1) Cnc B
Gl 351;            Psi Vel B
Gl 354;            Theta UMa B
Gl 366.1;          Theta Ant B
Gl 387;            39 Leo B
Gl 527;            Tau Boo B
Gl 550.2;          Phi Vir B
Gl 560;            Alpha Cir B
Gl 566;            Xi Boo B
Gl 575;            I Boo B
Gl 635;            Zeta Her B
Gl 656.1;          Eta Oph B
Gl 695;            Mu Her B
Gl 816.2;          Eta Cap B
Gl 822;            Delta Equ B

Wo 9220;           38 Gem B
W049;              Sirius B
W053;              Procyon B
LHS 122;           Eta Cas B
LHS 459;           70 Oph B
LHS 3325;          Mu Her B

BD -02°2902;       Tau(1) Hya B
BD -03°335;        66 Cet B

