# starconvert specification file for Yale bright stars catalog
# version 5-0.95

# no comments field for Yale catalog; if I'm feeling ambitious, I might
#  eventually add the ability to read comments from the accompanying notes.dat
#  file.

[coordinates]
type; celestial

ra-hours; 76; 77
ra-min;   78; 79
ra-sec;   80; 83

dec-sign; 84
dec-deg;  85; 86
dec-min;  87; 88
dec-sec;  89; 90

[characteristics]
specclass;           128; 147

distance; arcsec;    162; 166; 0.04 # don't trust parallaxes < 0.04"
magnitude; visual;   103; 107

distance; specclass
magnitude; visual;   103; 107

[systems]
# haven't yet figured out how to extract multiple star data from Yale catalog

[names]
bayer;          8; 14 
flamsteed;      5; 14
const-specific; 52; 60 # "const-specific" includes, e.g., "q Car", "VV Ori"
other;          26; 31; HD  # Henry Draper catalog number
other;          32; 37; SAO # Smithsonian Astrophysical Observatory catalog no.
dm;             15; 25      # Durchmusterung number BD / CD / CP
other;          45; 51; ADS # American Double Star catalog number
# other;        5; 14

[substitutions]
case-sensitive

Alpha CMa;         Sirius
Alpha Car;         Canopus
Alpha Boo;         Arcturus
Alpha Lyr;         Vega
Alpha Aur;         Capella
Beta Ori;          Rigel
Alpha CMi;         Procyon
Alpha Ori;         Betelgeuse
Alpha Eri;         Achernar
Alpha Aql;         Altair
Alpha Tau;         Aldebaren
Alpha Vir;         Spica
Alpha Sco;         Antares
Beta Gem;          Pollux
Alpha PsA;         Fomalhaut
Alpha Cyg;         Deneb
Alpha Leo;         Regulus
Alpha Gem;         Castor
Omicron Cet;       Mira
Alpha UMi;         Polaris
Beta Per;          Algol
Zeta UMa;          Mizar
80 UMa;            Alcor

# A few less well-known common names of stars.
# These should be inserted after their Bayer designations in priority.
# This only works with starconvert >= 0.95:
Alpha And;         Alpheratz;	2
Alpha(1) Cen;      Rigil Kent;	2
Beta Cen;          Hadar;	2
Alpha(1) Cru;      Acrux;	2
Beta Cru;          Mimosa;	2
Beta(1) Cyg;       Albireo;	2
Alpha Dra;         Thuban;	2
Alpha(1) Her;      Ras Algethi;	2
Beta Leo;          Denebola;	2
Alpha Oph;         Ras Alhague;	2
Gamma Ori;         Bellatrix;	2
Eta Tau;           Alcyone;	2
Alpha UMa;         Dubhe;	2
Beta UMa;          Merak;	2
Gamma UMa;         Phecda;	2
Delta UMa;         Megrez;	2
Epsilon UMa;       Alioth;	2
Eta UMa;           Alkaid;	2
