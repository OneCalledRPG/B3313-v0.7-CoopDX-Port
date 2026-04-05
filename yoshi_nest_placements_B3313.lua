-- name: [RYP] Rideable Yoshis for B3313 0.7
-- description: File that spawns Yoshi Eggs in B3313 levels. Have fun

NestPlacementsB331307 = { -- Nest co-ords and area.
    [-1] = {
        nests = { },
    },

    [LEVEL_BOB] = {
        nests = {
            --{ x = 8455, y = 981, z = 3636, area = 7 },
            { x = 5012, y = 41, z = 4777, area = 7 },
            { x = -8751, y = 3425, z = -960, area = 7 },
        },
    },


    [LEVEL_JRB] = {
        nests = {
            { x = 12159, y = 2064, z = -2264, area = 1 },
            { x = 7615, y = 871, z = -7808, area = 1 },
            { x = 5583, y = 2958, z = -13944, area = 1 },

            { x = 7738, y = 2009, z = 4912, area = 3 },
        },
    },

    [LEVEL_BBH] = {
        nests = {
            { x = -3452, y = 2344, z = -3189, area = 1 },
            { x = -8545, y = 4337, z = 227, area = 1 },

            { x = 1825, y = -1012, z = -64, area = 3 },

            --{ x = -15292, y = 729, z = -8584, area = 5 },
            { x = -13978, y = 2438, z = -8579, area = 5 },
        },
    },

    [LEVEL_HMC] = {
        nests = {
            { x = -2222, y = 112, z = 14665, area = 3 },
            { x = -486, y = 0, z = -5999, area = 3 },
        },
    },

    [LEVEL_SSL] = {
        nests = {
            { x = -7434, y = 251, z = -1372, area = 1 },
            { x = 1856, y = 186, z = -10894, area = 1 },
            { x = -3136, y = 1474, z = -13184, area = 1 },

            { x = -2832, y = 1055, z = -9070, area = 2 },

            { x = 1118, y = 3618, z = 15931, area = 5 },
        },
    },

    [LEVEL_DDD] = {
        nests = {
            { x = -3816, y = -1429, z = -5504, area = 7 },
            { x = 1020, y = 148, z = 3523, area = 7 },
            { x = -4008, y = 3983, z = -2935, area = 7 },
        },
    },

    [LEVEL_SL] = {
        nests = {
            { x = 1696, y = 647, z = 188, area = 5 },
        },
    },

    [LEVEL_WDW] = {
        nests = {
            { x = -3816, y = -1429, z = -5504, area = 3 },
            { x = 1020, y = 148, z = 3523, area = 3 },
            { x = -4008, y = 3983, z = -2935, area = 3 },

            { x = -4399, y = 9896, z = -7422, area = 4 },
            { x = -6274, y = 5430, z = -6172, area = 4 },

            { x = 840, y = -1358, z = 3834, area = 7 },
            { x = 1671, y = 2769, z = 6835, area = 7 },
        },
    },

    [LEVEL_TTM] = {
        nests = {
            { x = 4906, y = -3848, z = 5141, area = 1 },
            { x = 1126, y = 2310, z = 394, area = 1 },
            { x = 2493, y = -1506, z = 1332, area = 1 },
        },
    },

    [LEVEL_THI] = {
        nests = {
            { x = 2168, y = -1084, z = -9610, area = 1 },

            { x = 62, y = 412, z = -10565, area = 2 },

            { x = 3437, y = 965, z = 11043, area = 4 },
        },
	},

    [LEVEL_CASTLE_GROUNDS] = {
        nests = {
            { x = 4290, y = 7, z = -9535, area = 6 },
        },
	},

    [LEVEL_BITS] = {
        nests = {
            { x = 5493, y = 1302.9, z = -1370, area = 4 },
            { x = -2479, y = 1207, z = -2858, area = 4 },
            { x = 4505, y = 3072, z = -1674, area = 4 },
        },
	},

    [LEVEL_SA] = {
        nests = {
            { x = 5184, y = 183, z = 10350, area = 3 },
            { x = -2813, y = 5933, z = -3720, area = 3 },
        },
	},

    [LEVEL_PSS] = {
        nests = {
            { x = 7983, y = 627, z = -1669, area = 5 },
            { x = 13424, y = 3993, z = -6776, area = 5 },
        },
	},

    [LEVEL_VCUTM] = {
        nests = {
            { x = 297, y = 0, z = -8498, area = 5 },
        },
	},

    [LEVEL_COTMC] = {
        nests = {
            { x = -4937, y = -2188, z = -1069, area = 4 },
            { x = 2839, y = -2065, z = -532, area = 4 },
            { x = 3117, y = -54, z = 1435, area = 4 },

            { x = 5081, y = 3578, z = -1791, area = 5 },
        },
	}

}

if _G.RYExists then
    --_G.RideableYoshi.insert_romhack_placement_data("[v0.7] \\#F78AF5\\B\\#F94A36\\3\\#4C5BFF\\3\\#EDD83D\\1\\#16C31C\\3", NestPlacementsB331307)
    _G.RideableYoshi.insert_romhack_placement_data("[v0.7] \\#F78AF5\\B\\#F94A36\\3\\#4C5BFF\\3\\#EDD83D\\1\\#16C31C\\3", NestPlacementsB331307)

-- Yoshi introduction dialogue swap, he now tells you about rideable Yoshi's, but only if the mod is enabled (0.7 Edition)
smlua_text_utils_dialog_replace(DIALOG_075,1,5,30,200, ("w e l c o m e  t o \
a  n e w  \
a d v e n t u r e !\
\
\
t h e r e  a r e  s o  \
m a n y   w o r l d s\
t o  v i s i t \
a n d  s o  l i t t l e \
t i m e .\
y o u  m u s t\
b e  \
w o n d e r i n g \
w h e r e   t o  g o \
f i r s t ,  r i g h t ?\
l e t  m e \
t e l l  y o u \
\
\
\
l e t   y o u r \
d e c i s i o n s\
b e  t h e  p a t h \
t o  f o l l o w .\
\
h i n t , \
l o o k  a t \
t h e  s k y  \
i n s i d e  t h e \
c a s t l e  i f \
y o u  h a v e \
1 0  p o w e r \
s t a r s , a n d \
y o u  m i g h t \
s e e  t h e  w o r l d\
s h i f t  r i g h t \
i n  f r o n t \
o f  y o u r \
e y e s .\
\
a n d  r e m e m b e r\
t h a t  y o u  c a n  \
s w i t c h\
p l u m b e r s  a t\
a n y  t i m e\
t h r o u g h  t h e\
p a u s e  m e n u !\
\
\
\
a n d  i f  y o u\
s e e  a n  e g g\
o n  y o u r\
t r a v e l s ,\
d o n ' t  b e  s h y .\
m y  f r i e n d s\
a r e  m o r e  t h a n\
h a p p y  t o  g i v e\
y o u  a  r i d e .\
\
c a n  y o u  h e a r \
t h e  p r i n c e s s \
c a l l i n g ?\
\
\
o h ,  a n d  \
d o n ' t   e n t e r\
t h i s   c a v e\
u n l e s s   y o u  \
w a n t   t o  \
s e e   y o u r\
d e e p e s t  \
f e a r s   u n f o l d ."))

end