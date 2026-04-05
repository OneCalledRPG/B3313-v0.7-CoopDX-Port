--dialog handler
--Changes the dialogue to b3313 0.7's dialogue
--dialog IDs marked in the list are skipped, and set to render at a height of 400 as skipped dialogue still renders for about half a second before fully skipping

local skipdialogs = {
  [DIALOG_067] = true,
  [DIALOG_092] = true,
  [DIALOG_093] = true,
}
hook_event(HOOK_ON_DIALOG, function (dialogID)
    if skipdialogs[dialogID] then
        return false
    end
end)

smlua_text_utils_dialog_replace(DIALOG_000,1,4,95,200, ("t h i s  c a s t l e  i s \
e x c l u s i v e  t o  \
t h e  s h o w . \
\
i t ' s\
c o n n e c t e d  t o\
a  v a r i e t y\
o f  w o r l d s ,\
s o  o p e n  t h e  \
d o o r s  a h e a d \
a n d  g e t \
a d v e n t u r i n g ."))

smlua_text_utils_dialog_replace(DIALOG_001,1,5,30,200, ("e n t r a n c e  t o :\
\
F l o o r  3 b .\
E n t e r \
a t  y o u r  o w n\
r i s k ."))

smlua_text_utils_dialog_replace(DIALOG_002,1,4,95,200, ("( P l a c e h o l d e r \
t e x t )"))

smlua_text_utils_dialog_replace(DIALOG_003,1,5,95,200, ("l e a v e \
n o w"))

smlua_text_utils_dialog_replace(DIALOG_004,1,3,95,200, ("w e l c o m e  t o  \
m a r i o  \
w o n d e r l a n d .\
I f  y o u ' r e  t h e \
a d v e n t u r o u s  \
s o r t ,\
p a y  a  v i s i t  t o \
t h e  c a s t l e  \
a h e a d ."))

smlua_text_utils_dialog_replace(DIALOG_005,1,3,30,200, ("Hey, Mario! Is it true\
that you beat the Big\
Bob-omb? Cool!\
You must be strong. And\
pretty fast. So, how fast\
are you, anyway?\
Fast enough to beat me...\
Koopa the Quick? I don't\
think so. Just try me.\
How about a race to the\
mountaintop, where the\
Big Bob-omb was?\
Whaddya say? When I say\
''Go,'' let the race begin!\
\
Ready....\
\
//Go!////Don't Go"))

smlua_text_utils_dialog_replace(DIALOG_006,1,3,30,200, ("( P l a c e h o l d e r \
t e x t )"))

smlua_text_utils_dialog_replace(DIALOG_007,1,5,30,200, ("( P l a c e h o l d e r \
t e x t )"))

smlua_text_utils_dialog_replace(DIALOG_008,1,4,30,200, ("( P l a c e h o l d e r \
t e x t )"))

smlua_text_utils_dialog_replace(DIALOG_009,1,5,30,200, ("( P l a c e h o l d e r \
t e x t )"))

smlua_text_utils_dialog_replace(DIALOG_010,1,4,30,200, ("y o u ' v e  j u s t \
s t e p p e d  o n\
t h e  w i n g  C a p \
s w i t c h !\
s a v e ?\
\
//y e s////n o"))

smlua_text_utils_dialog_replace(DIALOG_011,1,4,30,200, ("y o u ' v e  j u s t \
s t e p p e d  o n\
t h e  M e t a l  C a p \
s w i t c h !\
s a v e ?\
\
//y e s////n o"))

smlua_text_utils_dialog_replace(DIALOG_012,1,4,30,200, ("y o u ' v e  j u s t \
s t e p p e d  o n\
t h e  v a n i s h  C a p \
s w i t c h !\
s a v e ?\
\
//y e s////n o"))

smlua_text_utils_dialog_replace(DIALOG_013,1,5,30,200, ("y o u ' v e  \
c o l l e c t e d \
1 0 0  c o i n s !\
s a v e ?\
//y e s////N o"))

smlua_text_utils_dialog_replace(DIALOG_014,1,4,30,200, ("p o w e r  s t a r !\
\
s a v e ?\
\
//y e s  //n o"))

smlua_text_utils_dialog_replace(DIALOG_015,1,5,30,200, ("w a r n i n g !\
y o u  h a v e\
e n t e r e d  t h e\
c o l d ,  c o l d \
c r e v a s s e !\
p l e a s e  w a t c h\
y o u r  s t e p s . . .\
 --c h i e f  \
s n o w m a n"))

smlua_text_utils_dialog_replace(DIALOG_016,1,3,30,200, ("p u r e  \
e m p t i n e s s ."))

smlua_text_utils_dialog_replace(DIALOG_017,1,4,30,200, ("i ' m  t h e \
b i g  b o b - o m b  \
f u t u r e  l o r d \
o f  a l l  b l a s t i n g \
m a t t e r \
h o w  d a r e \
y o u  e n t e r \
m y  f o r t r e s s ?\
i f  y o u  w a n t \
t h e  s t a r  \
y o u  m u s t  p r o v e\
y o u r s e l f  i n \
b a t t l e ."))

smlua_text_utils_dialog_replace(DIALOG_018,1,4,30,200, ("n e w \
a d v e n t u r e s\
a n d  n e w \
w o r l d s !\
w i l l  y o u  p l a y \
t h e  g a m e ,\
o r  w i l l  i t\
p l a y  y o u ?"))

smlua_text_utils_dialog_replace(DIALOG_019,1,2,30,200, ("s h h h !\
P l e a s e \
w a l k  q u i e t l y  \
i n  t h e  h a l l w a y !"))

smlua_text_utils_dialog_replace(DIALOG_020,1,6,95,150, ("Dear Mario:\
Please come to the\
castle. I've baked\
a cake for you.\
Yours truly--\
Princess Toadstool"))

smlua_text_utils_dialog_replace(DIALOG_021,1,5,95,200, ("Welcome.\
No one's home!\
Now scram--\
and don't come back!\
Gwa ha ha!"))

smlua_text_utils_dialog_replace(DIALOG_022,1,2,95,200, ("t h i s  d o o r  i s\
l o c k e d"))

smlua_text_utils_dialog_replace(DIALOG_023,1,3,95,200, ("w r o n g  k e y !"))

smlua_text_utils_dialog_replace(DIALOG_024,1,5,95,200, ("1  s t a r  l e f t"))

smlua_text_utils_dialog_replace(DIALOG_025,1,4,95,200, ("t h i s  d o o r  i s\
l o c k e d"))

smlua_text_utils_dialog_replace(DIALOG_026,1,4,95,200, ("t h i s  d o o r  i s\
l o c k e d"))

smlua_text_utils_dialog_replace(DIALOG_027,1,4,95,200, ("y o u  a r e \
n o t  w o r t h y \
\
\
c o l l e c t 30\
s t a r s ."))

smlua_text_utils_dialog_replace(DIALOG_028,1,4,95,200, ("t h i s  d o o r  i s\
l o c k e d"))

smlua_text_utils_dialog_replace(DIALOG_029,1,5,95,200, ("t h i s  d o o r  i s\
l o c k e d"))

smlua_text_utils_dialog_replace(DIALOG_030,1,5,30,200, ("i f  y o u  w a n t \
t o  f e e l  t h e \
w i n d  a t  y o u r \
b a c k , \
\
t r y  j u m p i n g  i n \
t h e  h o l e  o n  \
t h e  l e f t .\
t h e  s e n s a t i o n\
c a n ' t  b e  b e a t ."))

smlua_text_utils_dialog_replace(DIALOG_031,1,5,30,200, ("No way! You beat me...\
again!! And I just spent\
my entire savings on\
these new Koopa\
Mach 1 Sprint shoes!\
Here, I guess I have to\
hand over this Star to\
the winner of the race.\
Congrats, Mario!"))

smlua_text_utils_dialog_replace(DIALOG_032,1,4,30,200, ("i f  y o u ' v e\
a l w a y s\
d r e a m e d  o f\
f l y i n g ,\
y o u  s h o u l d\
t r y  o u t  t h e\
c a n n o n  o n\
y o u r  l e f t .\
c l i m b i n g\
t r e e s  i s\
a c t i v e l y\
e n c o u r a g e d !\
s o  t r y\
f i n d i n g  a\
w i n g e d  a l l y !"))

smlua_text_utils_dialog_replace(DIALOG_033,1,6,30,200, ("Ciao! You've reached\
Princess Toadstool's\
castle via a warp pipe.\
Using the controller is a\
piece of cake. Press [A] to\
jump and [B] to attack.\
Press [B] to read signs,\
too. Use the Control Stick\
in the center of the\
controller to move Mario\
around. Now, head for\
the castle."))

smlua_text_utils_dialog_replace(DIALOG_034,1,6,30,200, ("Good afternoon. The\
Lakitu Bros., here,\
reporting live from just\
outside the Princess's\
castle.\
\
Mario has just arrived\
on the scene, and we'll\
be filming the action live\
as he enters the castle\
and pursues the missing\
Power Stars.\
As seasoned cameramen,\
we'll be shooting from the\
recommended angle, but\
you can change the\
camera angle by pressing\
the [C] Buttons.\
If we can't adjust the\
view any further, we'll\
buzz. To take a look at\
the surroundings, stop\
and press [C]^.\
\
Press [A] to resume play.\
Switch camera modes with\
the [R] Button. Signs along\
the way will review these\
instructions.\
\
For now, reporting live,\
this has been the\
Lakitu Bros."))

smlua_text_utils_dialog_replace(DIALOG_035,1,3,30,200, (" "))

smlua_text_utils_dialog_replace(DIALOG_036,1,6,30,200, ("w o w !  y o u ' r e \
s m a c k  i n  \
t h e  m i d d l e  o f \
a  p e a c e f u l  \
r i v e r !\
\
b u t  h o w  l o n g \
i s  t h i s  p e a c e \
g o i n g  t o  l a s t ?\
\
\
\
y o u ' l l  f i n d\
t h e  s t a r s  t h a t\
t h e  k u p p a  k i n g\
s t o l e  i n s i d e\
t h e  p a i n t i n g\
w a l l s . \
f i r s t , t a l k \
t o  t h e  a l l y .\
h e ' l l  h e l p \
y o u  o u t ."))

smlua_text_utils_dialog_replace(DIALOG_037,1,2,30,200, ("I win! You lose!\
Ha ha ha ha!\
You're no slouch, but I'm\
a better sledder!\
Better luck next time!"))

smlua_text_utils_dialog_replace(DIALOG_038,1,3,95,200, ("r e a c t i n g \
t o  t h e  s t a r\
p o w e r ,  t h e \
d o o r  o p e n s ."))

smlua_text_utils_dialog_replace(DIALOG_039,1,4,30,200, ("No visitors allowed,\
by decree of\
the Big Bob-omb\
\
I shall never surrender my\
Stars, for they hold the\
power of the castle in\
their glow.\
They were a gift from\
Bowser, the Koopa King\
himself, and they lie well\
hidden within my realm.\
Not a whisper of their\
whereabouts shall leave\
my lips. Oh, all right,\
perhaps one hint:\
Heed the Star names at\
the beginning of the\
course.\
//--The Big Bob-omb"))

smlua_text_utils_dialog_replace(DIALOG_040,1,3,30,200, ("Warning!\
Cold, Cold Crevasse\
Below!"))

smlua_text_utils_dialog_replace(DIALOG_041,1,3,30,200, ("I win! You lose!\
Ha ha ha!\
\
That's what you get for\
messin' with Koopa the\
Quick.\
Better luck next time!"))

smlua_text_utils_dialog_replace(DIALOG_042,1,4,30,200, ("t e s t  l e v e l"))

smlua_text_utils_dialog_replace(DIALOG_043,1,5,30,200, ("g o o d  t h i n g \
y o u  p i c k e d \
t h i s  w a y\
b u t  w h a t  \
c a n  y o u \
e x p e c t \
a t  t h e \
o t h e r  s i d e\
o f  t h e  d o o r ?"))

smlua_text_utils_dialog_replace(DIALOG_044,1,5,95,200, ("w h o o o ' s \
t h e r e ?  W h o\
w o k e  m e  u p ? \
H e y , a s  l o n g \
a s  I ' m\
a w a k e , w h y  \
n o t  t a k e  a\
s h o r t  f l i g h t ?"))

smlua_text_utils_dialog_replace(DIALOG_045,1,6,95,200, ("w h e w !  I ' m\
j u s t  a b o u t\
f l a p p e d  o u t ."))

smlua_text_utils_dialog_replace(DIALOG_046,1,5,30,200, ("h e y  t h e r e ! \
m o u s t a c h e\
g u y .\
h a v e n ' t  s e e n \
y o u  a r o u n d\
h e r e  b e f o r e .\
I  g o t  s o m e \
s u s p i c i o n s\
y o u  s h o u l d \
t a k e  a  l o o k  a t  \
t h e  m o u n t a i n , \
i   w o u l d  c l i m b \
i t  m y s e l f  b u t \
i ' m  n o t  a s  \
f a s t\
o r  t a l l \
a s  t h e \
r a c e r !\
h a v e  y o u\
m e t  h i m ?"))

smlua_text_utils_dialog_replace(DIALOG_047,1,2,95,200, ("i ' l l  p r e p a r e \
t h e  c a n n o n \
f o r  y o u"))

smlua_text_utils_dialog_replace(DIALOG_048,1,4,30,200, ("Snow Mountain Summit\
Watch for slippery\
conditions! Please enter\
the cottage first."))

smlua_text_utils_dialog_replace(DIALOG_049,1,5,30,200, ("f u n h o u s e"))

smlua_text_utils_dialog_replace(DIALOG_050,1,4,30,200, ("Hold [Z] to crouch and\
slide down a slope.\
Or press [Z] while in the\
air to Pound the Ground!\
If you stop, crouch, then\
jump, you'll do a\
Backward Somersault!\
Got that?\
There's more. Crouch and\
then jump to do a\
Long Jump! Or crouch and\
walk to...never mind."))

smlua_text_utils_dialog_replace(DIALOG_051,1,6,30,200, ("Climbing's easy! When you\
jump at trees, poles or\
pillars, you'll grab them\
automatically. Press [A] to\
jump off backward.\
\
To rotate around the\
object, press Right or\
Left on the Control Stick.\
When you reach the top,\
press Up to do a\
handstand!\
Jump off from the\
handstand for a high,\
stylin' dismount."))

smlua_text_utils_dialog_replace(DIALOG_052,1,5,30,200, ("w o w !  y o u ' r e \
s m a c k  i n  t h e \
m i d d l e  o f  a . . . \
\
b a t t l e f i e l d ?\
W h e r e  d i d  t h e \
r i v e r  g o ?\
\
\
\
y o u ' l l  f i n d\
t h e  s t a r s  t h a t\
t h e  k u p p a  k i n g\
s t o l e  i n s i d e\
t h e  p a i n t i n g s .\
t h e r e ' s  n o\
a l l y  t h i s  t i m e .\
\
y o u ' r e  o n\
y o u r  o w n ."))

smlua_text_utils_dialog_replace(DIALOG_053,1,5,30,200, ("w e l c o m e\
t o  t h e\
p l e a s a n t ,\
p l e a s a n t\
f a l l s !\
o u r  p l a c e\
t o  r e l a x\
a f t e r  s o\
m a n y\
b a t t l e s .\
t h i s  m o u n t a i n\
h i d e s  m a n y\
s e c r e t s .  i\
w i s h  i  w a s  a b l e\
t o  c l i m b  i t !"))

smlua_text_utils_dialog_replace(DIALOG_054,1,5,30,200, ("e v e r y \
o n e \
i s  l o o k i n g \
f o r  t h e  k i n g !\
h e  w e n t  t o \
t h e  h i g h e s t \
t o w e r \
a n d  h e \
d i s s a p e a r e d ."))

smlua_text_utils_dialog_replace(DIALOG_055,1,4,30,200, ("Hey-ey, Mario, buddy,\
howzit goin'? Step right\
up. You look like a fast\
sleddin' kind of guy.\
I know speed when I see\
it, yes siree--I'm the\
world champion sledder,\
you know. Whaddya say?\
How about a race?\
Ready...\
\
//Go//// Don't Go"))

smlua_text_utils_dialog_replace(DIALOG_056,1,6,30,200, ("You brrrr-oke my record!\
Unbelievable! I knew\
that you were the coolest.\
Now you've proven\
that you're also the\
fastest!\
I can't award you a gold\
medal, but here, take this\
Star instead. You've\
earned it!"))

smlua_text_utils_dialog_replace(DIALOG_057,1,4,30,200, ("i  l o s t  m y \
b a b y !"))

smlua_text_utils_dialog_replace(DIALOG_058,1,4,30,200, ("y o u \
f o u n d \
m y  p r e c i o u s \
b a b y !  wh e r e\
h a v e  y o u  b e e n ?\
h e r e ,  t a k e  i t \
w i t h  m y \
e t e r n a l\
g r a t i t u d e ."))

smlua_text_utils_dialog_replace(DIALOG_059,1,4,30,200, ("t h a t ' s \
n o t  m y  b a b y !"))

smlua_text_utils_dialog_replace(DIALOG_060,1,4,30,200, ("( p l a c e h o l d e r )"))

smlua_text_utils_dialog_replace(DIALOG_061,1,4,30,200, ("s o r r y !\
b u t  t h e  \
p r i n c e s s  i s \
i n  a n o t h e r \
c a s t l e ."))

smlua_text_utils_dialog_replace(DIALOG_062,1,3,30,200, ("w a r n i n g !\
c o l d  ,  c o l d\
c r e v a s s e\
a h e a d !"))

smlua_text_utils_dialog_replace(DIALOG_063,1,3,30,200, ("w h a t  a r e  \
y o u  d o i n g \
u p  h e r e ?\
y o u  s h o u l d  b e\
l o o k i n g  f o r\
t h e  p r i n c e s s !\
w h a t   d o  \
y o u  e x p e c t ,\
s o m e  l i v e s ?\
t h e r e ' s \
n o  s e c o n d \
c h a n c e s ."))

smlua_text_utils_dialog_replace(DIALOG_064,1,5,30,200, ("t h e r e\
a r e \
s e c r e t s\
i n  t h e s e\
d o o r s \
s o m e  s a y \
t h a t  y o u \
s h o u l d n ' t \
b e  j u m p i n g \
a n d  \
m a k i n g \
n o i s e \
n e a r  t h e m \
a t  a l l ."))

smlua_text_utils_dialog_replace(DIALOG_065,1,6,30,200, ("l e a v e \
m e  a l o n e . . .\
i  d o n ' t \
w a n t  \
t r o u b l e\
i ' m  j u s t \
r e l a x i n g \
b y  t h e  f i r e\
b e f o r e\
y o u  f l o o d \
t h i s  \
w o r l d\
y o u  m o n s t e r .\
i t  i s  t h e \
c y c l e \
o f  l i f e ."))

smlua_text_utils_dialog_replace(DIALOG_066,1,3,30,200, ("w e l c o m e  t o\
m a r i o\
w o n d e r l a n d .\
i f  y o u ' r e  t h e\
a d v e n t u r o u s\
s o r t ,\
p a y  a  v i s i t  t o\
t h e  c a s t l e\
a h e a d ."))

smlua_text_utils_dialog_replace(DIALOG_067,1,5,30,200, ("t o u g h  l u c k , \
l u i g i !\
p r i n c e s s  \
t o a d s t o o l \
i s n ' t  h e r e\
y o u ' l l  n e v e r \
b e  a b l e  t o \
s w i n g \
m e  a r o u n d !"))

smlua_text_utils_dialog_replace(DIALOG_068,1,5,30,200, ("It's Lethal Lava Land!\
If you catch fire or fall\
into a pool of flames,\
you'll be hopping mad, but\
don't lose your cool.\
You can still control\
Mario--just try to keep\
calm!"))

smlua_text_utils_dialog_replace(DIALOG_069,1,6,30,200, ("( p l a c e h o l d e r )"))

smlua_text_utils_dialog_replace(DIALOG_070,1,3,30,200, ("s h o u l d  i \
w a s t e  m y  t i m e \
i n  t h i s ?"))

--[[smlua_text_utils_dialog_replace(DIALOG_071,1,3,30,200, ("Danger Ahead!\
Beware of the strange\
cloud! Don't inhale!\
If you feel faint, run for\
higher ground and fresh\
air!\
Circle: Shelter\
Arrow: Entrance-Exit"))]]

smlua_text_utils_dialog_replace(DIALOG_071,1,2,30,200, ("w h a t  a r e  y o u\
d o i n g  h e r e ?"))

--[[smlua_text_utils_dialog_replace(DIALOG_072,1,4,30,200, ("High winds ahead!\
Pull your Cap down tight.\
If it blows off, you'll\
have to find it on this\
mountain."))]]

smlua_text_utils_dialog_replace(DIALOG_072,1,2,30,200, ("h a v e n ' t  y o u\
d o n e  e n o u g h ?"))

--[[smlua_text_utils_dialog_replace(DIALOG_073,1,4,95,200, ("Aarrgh! Ahoy, matey. I\
have sunken treasure,\
here, I do.\
\
But to pluck the plunder,\
you must open the\
Treasure Chests in the\
right order.\
What order is that,\
ye say?\
\
\
I'll never tell!\
\
//--The Cap'n"))]]

smlua_text_utils_dialog_replace(DIALOG_073,1,1,95,200, ("d o n ' t .\
y o u .\
d a r e ."))

--[[smlua_text_utils_dialog_replace(DIALOG_074,1,5,30,200, ("You can grab on to the\
edge of a cliff or ledge\
with your fingertips and\
hang down from it.\
\
To drop from the edge,\
either press the Control\
Stick in the direction of\
Mario's back or press the\
[Z] Button.\
To get up onto the ledge,\
either press Up on the\
Control Stick or press [A]\
as soon as you grab the\
ledge to climb up quickly."))]]

smlua_text_utils_dialog_replace(DIALOG_074,1,3,30,200, ("c a n ' t  y o u\
s e e  t h e  p a i n\
h e ' s  i n ?"))

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

smlua_text_utils_dialog_replace(DIALOG_076,1,2,30,200, ("l o o k \
w h a t  I  f o u n d !"))

smlua_text_utils_dialog_replace(DIALOG_077,1,2,150,200, ("t h e  q u i e t \
w a r  h a s  b e g u n \
wi t h  s i l e n t \
w e a p o n s .\
t h e y  w i l l  \
a t t a c k \
u n t i l  t h e r e ' s \
n o t h i n g  l e f t .\
n o t h i n g \
m a t t e r s ."))

smlua_text_utils_dialog_replace(DIALOG_078,1,5,30,200, ("i n t e r n a l \
s e w e r \
s y s t e m .\
\
\
b u i l t  b y \
t h e  k o o p a \
k r e w !\
\
\
o u r  s u b  \
d i d n ' t  f i t \
i n  t h i s  \
p a t h e t i c \
c a s t l e\
s o  w e  h a d \
t o  m a k e \
s o m e  m o r e \
s p a c e !\
h a  h a  h a  h a !"))

smlua_text_utils_dialog_replace(DIALOG_079,1,4,30,200, ("Owwwuu! Let me go!\
Uukee-kee! I was only\
teasing! Can't you take\
a joke?\
I'll tell you what, let's\
trade. If you let me go,\
I'll give you something\
really good.\
So, how about it?\
\
//Free him/ Hold on"))

smlua_text_utils_dialog_replace(DIALOG_080,1,1,30,200, ("Eeeh hee hee hee!"))

smlua_text_utils_dialog_replace(DIALOG_081,1,4,30,200, ("t h e  \
m y s t e r y \
i s  o f  w e t\
o r  d r y .\
a n d  w h e r e \
d o e s  t h e \
s o l u t i o n \
l i e ?\
t h e  c i t y \
w e l c o m e s \
v i s i t o r s\
w i t h  t h e  \
d e p t h  t h e y \
b r i n g\
a s  t h e y\
e n t e r ."))

smlua_text_utils_dialog_replace(DIALOG_082,1,4,30,200, ("h e r e ,  t a k e \
t h i s . \
I ' v e  b e e n \
k e e p i n g \
i t  f o r  y o u ."))

smlua_text_utils_dialog_replace(DIALOG_083,1,6,30,200, ("t h i s  w o r l d \
i s  s o  s t r a n g e !\
I ' v e  s e e n \
r o o m s  c h a n g e\
t h e i r  s h a p e  \
a n d  c o l o u r s !\
i  f e e l  l i k e \
i ' m  g o i n g  \
c r a z y !\
h e y,  c a t c h !"))

smlua_text_utils_dialog_replace(DIALOG_084,1,3,30,200, ("u n h a n d  m e !\
o u c h !\
t a k e  i t \
t h e n ! \
a  g i f t \
f r o m \
k u p p a , i t  w a s .\
n o w  l e t \
m e  b e !"))

smlua_text_utils_dialog_replace(DIALOG_085,1,5,30,200, ("You don't stand a ghost\
of a chance in this house.\
If you walk out of here,\
you deserve...\
...a Ghoul Medal..."))

smlua_text_utils_dialog_replace(DIALOG_086,1,3,30,200, ("y o u  m a n a g e d \
t o  f i n d  u s . \
b r a v o  \
t h i s  i s  t h e \
p l a c e  w e  \
e s c a p e d  s i n c e \
y o u  m o n s t e r \
f l o o d e d \
o u r  h o u s e s \
a n d  k i l l e d  \
o u r  f r i e n d s .\
\
i  k i n d l y  a s k\
y o u ,  p l e a s e \
l e a v e , \
d o n ' t  t a k e  \
t h e  e n e r g y   \
f r o m  o u r \
h o u s e s  a g a i n \
\
\
e v e r y t h i n g \
a n d   e v e r y o n e \
w i l l   d i e .\
\
i t ' s  y o u r \
d e c i s i o n \
t o  c h o o s e \
t h e   p a t h \
y o u  f o l l o w ."))

smlua_text_utils_dialog_replace(DIALOG_087,1,4,30,200, ("t h e  e n t i r e \
t o w n ' s\
g o n e  m a d ! \
\
t r y  t o   f l o o d \
t h e  v i l l a g e \
a n d  c o o l  t h e  \
v i l l a g e r s  \
d o w n ."))

smlua_text_utils_dialog_replace(DIALOG_088,1,5,30,200, ("y o u   h a v e  \
r e a c h e d  a n \
i n c o m p l e t e \
a r e a \
t u r n  o f f\
y o u r  s y s t e m\
n o w ."))

smlua_text_utils_dialog_replace(DIALOG_089,1,5,95,200, ("e n t e r \
a t  y o u r  o w n \
r i s k ."))

smlua_text_utils_dialog_replace(DIALOG_090,1,6,30,200, ("Bwa ha ha ha!\
You've stepped right into\
my trap, just as I knew\
you would! I warn you,\
''Friend,'' watch your\
step!"))

smlua_text_utils_dialog_replace(DIALOG_091,2,2,30,200, ("Danger!\
Strong Gusts!\
But the wind makes a\
comfy ride."))

smlua_text_utils_dialog_replace(DIALOG_092,1,5,30,200, ("p e s t e r i n g \
m e  a g a i n , a r e\
y o u ,  l u i g i ? \
c a n ' t  y o u  s e e \
t h a t   I ' m  \
h a v i n g  a  m e r r y\
l i t t l e  t i m e , \
m a k i n g  \
m i s c h i e f  w i t h \
m y  m i n i o n s ?\
n o w ,  r e t u r n \
t h o s e  s t a r s !\
m y  t r o o p s \
i n  t h e   w a l l s\
n e e d  t h e m !"))

smlua_text_utils_dialog_replace(DIALOG_093,1,5,30,200, ("l u i g i !  y o u  \
a g a i n ! \
I ' v e  b e e n \
l o o k i n g  f o r \
s o m e t h i n g\
t o  f r y  wi t h \
m y  f i r e \
b r e a t h !\
y o u r  f r i e n d s \
a r e  a l l \
t r a p p e d \
w i t h i n  t h e i r\
w a l l s ...\
j u s t  l i k e  y o u .\
t h e  o n e \
c o n t r o l l i n g \
h i m . . .\
y o u ' l l  n e v e r \
s e e  t h e \
p r i n c e s s  \
a g a i n \
 b w a  h a  h a  h a !"))

smlua_text_utils_dialog_replace(DIALOG_094,1,4,30,200, ("Get a good run up the\
slope! Do you remember\
the Long Jump? Run, press\
[Z], then jump!"))

smlua_text_utils_dialog_replace(DIALOG_095,1,4,30,200, ("To read a sign, stand in\
front of it and press [B],\
like you did just now.\
\
When you want to talk to\
a Koopa Troopa or other\
animal, stand right in\
front of it.\
Please recover the Stars\
that were stolen by\
Bowser in this course."))

smlua_text_utils_dialog_replace(DIALOG_096,1,4,30,200, ("d i f f e r e n t \
p a t h s . . .\
d i s t a n t  \
i m a g e s . . .\
a r e n ' t \
y o u  h a p p y \
t o  k n o w \
t h a t  h e ' s \
f r e e  n o w ?"))

smlua_text_utils_dialog_replace(DIALOG_097,1,3,30,200, ("l e f t  o r  r i g h t ?\
I t ' s  u p  t o  y o u .\
\
m a k e  g o o d \
u s e  o f  t h e \
c  b u t t o n s \
t o  m o v e  \
q u i c k l y  b u t \
c a u t i o u s l y !"))

smlua_text_utils_dialog_replace(DIALOG_098,1,2,95,200, ("Come on in here...\
...heh, heh, heh..."))

smlua_text_utils_dialog_replace(DIALOG_099,1,5,95,200, ("e h  h e  h e . . . \
y o u ' r e  m i n e , \
n o w , h e e  h e e !\
I ' l l  p a s s  r i g h t \
t h r o u g h  t h i s \
w a l l . C a n  y o u \
d o t h a t ? \
H e h ,  h e h ,  h e h !"))

smlua_text_utils_dialog_replace(DIALOG_100,1,3,95,200, ("Ukkiki...Wakkiki...kee kee!\
Ha! I snagged it!\
It's mine! Heeheeheeee!"))

smlua_text_utils_dialog_replace(DIALOG_101,1,3,95,200, ("Ackk! Let...go...\
You're...choking...me...\
Cough...I've been framed!\
This Cap? Oh, all right,\
take it. It's a cool Cap,\
but I'll give it back.\
I think it looks better on\
me than it does on you,\
though! Eeeee! Kee keee!"))

smlua_text_utils_dialog_replace(DIALOG_102,1,5,30,200, ("Pssst! The Boos are super\
shy. If you look them\
in the eyes, they fade\
away, but if you turn\
your back, they reappear.\
It's no use trying to hit\
them when they're fading\
away. Instead, sneak up\
behind them and punch."))

smlua_text_utils_dialog_replace(DIALOG_103,1,4,95,200, ("Upon four towers\
one must alight...\
Then at the peak\
shall shine the light..."))

smlua_text_utils_dialog_replace(DIALOG_104,1,5,30,200, ("The shadowy star in front\
of you is a ''Star\
Marker.'' When you collect\
all 8 Red Coins, the Star\
will appear here."))

smlua_text_utils_dialog_replace(DIALOG_105,1,3,95,200, ("Ready for blastoff! Come\
on, hop into the cannon!\
\
You can reach the Star on\
the floating island by\
using the four cannons.\
Use the Control Stick to\
aim, then press [A] to fire.\
\
If you're handy, you can\
grab on to trees or poles\
to land."))

smlua_text_utils_dialog_replace(DIALOG_106,1,2,95,200, ("Ready for blastoff! Come\
on, hop into the cannon!"))

smlua_text_utils_dialog_replace(DIALOG_107,1,3,95,200, ("g h o s t s ...\
...d o n ' t ...\
...d i e !\
h e h, h e h, h e h !\
c a n  y o u  g e t \
o u t  o f  h e r e ...\
...a l i v e ?"))

smlua_text_utils_dialog_replace(DIALOG_108,1,2,95,200, ("h a  h a  h a  h a . . ."))

smlua_text_utils_dialog_replace(DIALOG_109,1,4,95,200, ("Ooooo Nooooo!\
Talk about out-of-body\
experiences--my body\
has melted away!\
Have you run in to any\
headhunters lately??\
I could sure use a new\
body!\
Brrr! My face might\
freeze like this!"))

smlua_text_utils_dialog_replace(DIALOG_110,1,5,95,200, ("I need a good head on my\
shoulders. Do you know of\
anybody in need of a good\
body? Please! I'll follow\
you if you do!"))

smlua_text_utils_dialog_replace(DIALOG_111,1,4,95,200, ("Perfect! What a great\
new body! Here--this is a\
present for you. It's sure\
to warm you up."))

smlua_text_utils_dialog_replace(DIALOG_112,1,4,30,200, ("t h e r e ' s \
n o t h i n g  f o r\
y o u  u p  h e r e ,\
m o u s t a c h e  b o y .\
g o  c o l l e c t \
y o u r \
t i n y  s t a r s .\
\
n o t h i n g \
m a t t e r s\
a n y w a y ."))

smlua_text_utils_dialog_replace(DIALOG_113,1,6,30,200, ("There are special Caps in\
the red, green and blue\
blocks. Step on the\
switches in the hidden\
courses to activate the\
Cap Blocks."))

smlua_text_utils_dialog_replace(DIALOG_114,1,5,95,200, ("i t  m a k e s \
m e  s o  m a d !  w e\
b u i l d  y o u r \
h o u s e s , y o u r\
c a s t l e s. \
a n d  s t i l l  y o u\
w a l k  a l l  o v e r \
u s .\
i  t h i n  k  I ' l l \
c r u s h  y o u  \
j u s t  f o r  f u n !"))

smlua_text_utils_dialog_replace(DIALOG_115,1,5,95,200, ("n o !  c r u s h e d \
a g a i n !"))

smlua_text_utils_dialog_replace(DIALOG_116,1,5,95,200, ("y o u ' l l  p a y \
f o r  t h i s ...\
l a t e r !"))

smlua_text_utils_dialog_replace(DIALOG_117,1,1,95,200, ("w h o ... w a l k \
... h e r e ?\
w h o ...b r e a k ...\
s e a l?\
w e  n o  l i k e \
...i n t r u d e  r s !\
n o w  b a t t l e ...\
...h a n d ...\
...t o...\
...h a n d !"))

smlua_text_utils_dialog_replace(DIALOG_118,1,6,95,200, ("w e ...s l e e p \
... d a r k n e s s."))

smlua_text_utils_dialog_replace(DIALOG_119,1,6,30,200, ("y o u ' l l  p a y \
f o r  t h i s ...\
l a t e r !"))

smlua_text_utils_dialog_replace(DIALOG_120,1,4,30,200, ("y o u ' l l  p a y \
f o r  t h i s ...\
l a t e r !"))

smlua_text_utils_dialog_replace(DIALOG_121,1,5,30,200, ("y o u ' l l  p a y \
f o r  t h i s ...\
l a t e r !"))

smlua_text_utils_dialog_replace(DIALOG_122,1,4,30,200, ("The Black Hole\
Right: Work Elevator\
/// Cloudy Maze\
Left: Underground Lake"))

smlua_text_utils_dialog_replace(DIALOG_123,1,4,30,200, ("Metal Cavern\
Right: To Waterfall\
Left: Metal Cap Switch"))

smlua_text_utils_dialog_replace(DIALOG_124,1,4,30,200, ("Work Elevator\
Danger!!\
Read instructions\
thoroughly!\
Elevator continues in the\
direction of the arrow\
activated."))

smlua_text_utils_dialog_replace(DIALOG_125,1,3,30,200, ("Hazy Maze-Exit\
Danger! Closed.\
Turn back now."))

smlua_text_utils_dialog_replace(DIALOG_126,2,3,30,200, ("n o t h i n g \
s u s p i c i o u s \
a r o u n d  h e r e"))

smlua_text_utils_dialog_replace(DIALOG_127,3,4,30,200, ("Underground Lake\
Right: Metal Cave\
Left: Abandoned Mine\
///(Closed)\
A gentle sea dragon lives\
here. Pound on his back to\
make him lower his head.\
Don't become his lunch."))

smlua_text_utils_dialog_replace(DIALOG_128,1,4,95,200, ("I t  i s  a g a i n s t \
t h e  r u l e s \
t o  t h r o w  t h e\
k i n g  o u t \
o f  t h e  r i n g !"))

smlua_text_utils_dialog_replace(DIALOG_129,1,5,30,200, ("Welcome to the Vanish\
Cap Switch Course! All of\
the blue blocks you find\
will become solid once you\
step on the Cap Switch.\
You'll disappear when you\
put on the Vanish Cap, so\
you'll be able to elude\
enemies and walk through\
many things. Try it out!"))

smlua_text_utils_dialog_replace(DIALOG_130,1,5,30,200, ("Welcome to the Metal Cap\
Switch Course! Once you\
step on the Cap Switch,\
the green blocks will\
become solid.\
When you turn your body\
into metal with the Metal\
Cap, you can walk\
underwater! Try it!"))

smlua_text_utils_dialog_replace(DIALOG_131,1,5,30,200, ("Welcome to the Wing Cap\
Course! Step on the red\
switch at the top of the\
tower, in the center of\
the rainbow ring.\
When you trigger the\
switch, all of the red\
blocks you find will\
become solid.\
\
Try out the Wing Cap! Do\
the Triple Jump to take\
off and press [Z] to land.\
\
\
Pull back on the Control\
Stick to go up and push\
forward to nose down,\
just as you would when\
flying an airplane."))

smlua_text_utils_dialog_replace(DIALOG_132,1,4,30,200, ("Whoa, Mario, pal, you\
aren't trying to cheat,\
are you? Shortcuts aren't\
allowed.\
Now, I know that you\
know better. You're\
disqualified! Next time,\
play fair!"))

smlua_text_utils_dialog_replace(DIALOG_133,1,6,30,200, ("c a n  y o u \
h e a r  t h e \
d i s t a n t\
s c r e a m s ?\
i  d o ."))

smlua_text_utils_dialog_replace(DIALOG_134,1,5,30,200, ("w e ' r e  a l l \
w a i t i n g  f o r \
y o u r  h e l p !"))

smlua_text_utils_dialog_replace(DIALOG_135,1,5,30,200, ("t h e  f u n \
h a s \
j u s t \
b e g u n"))

smlua_text_utils_dialog_replace(DIALOG_136,1,6,30,200, ("( p l a c e h o l d e r )"))

smlua_text_utils_dialog_replace(DIALOG_137,1,6,30,200, ("t h e  c a s t l e \
i s  r e c o v e r i n g \
i t s  e n e r g y \
a s  y o u  \
r e t r i e v e  p o w e r\
s t a r s !"))

smlua_text_utils_dialog_replace(DIALOG_138,1,3,30,200, ("Down: Underground Lake\
Left: Black Hole\
Right: Hazy Maze (Closed)"))

smlua_text_utils_dialog_replace(DIALOG_139,1,6,30,200, ("Above: Automatic Elevator\
Elevator begins\
automatically and follows\
pre-set course.\
It disappears\
automatically, too."))

smlua_text_utils_dialog_replace(DIALOG_140,1,6,30,200, ("Elevator Area\
Right: Hazy Maze\
/// Entrance\
Left: Black Hole\
///Elevator 1\
Arrow: You are here"))

smlua_text_utils_dialog_replace(DIALOG_141,1,5,150,200, ("y o u ' v e  \
r e c o v e r e d  o n e \
o f  t h e  s t o l e n \
p o w e r  s t a r s !"))

smlua_text_utils_dialog_replace(DIALOG_142,1,5,150,200, ("y o u ' v e  \
r e c o v e r e d  \
t h r e e \
o f  t h e  s t o l e n \
p o w e r  s t a r s !"))

smlua_text_utils_dialog_replace(DIALOG_143,1,6,150,200, ("y o u ' v e  \
r e c o v e r e d  \
e i g h t \
o f  t h e  s t o l e n \
p o w e r  s t a r s !"))

smlua_text_utils_dialog_replace(DIALOG_144,1,6,150,200, ("y o u ' v e  \
r e c o v e r e d  30 \
o f  t h e  s t o l e n \
p o w e r  s t a r s !"))

smlua_text_utils_dialog_replace(DIALOG_145,1,6,150,200, ("y o u ' v e  \
r e c o v e r e d  50 \
o f  t h e  s t o l e n \
p o w e r  s t a r s !"))

smlua_text_utils_dialog_replace(DIALOG_146,1,6,150,200, ("y o u ' v e  \
r e c o v e r e d  70\
o f  t h e  s t o l e n \
p o w e r  s t a r s !"))

smlua_text_utils_dialog_replace(DIALOG_147,1,5,30,200, ("( p l a c e h o l d e r )"))

smlua_text_utils_dialog_replace(DIALOG_148,1,6,30,200, ("y o u ' r e  f i n a l l y \
h e r e !\
e n j o y  t h i s \
d e l i c i o u s \
c a k e , a s  i \
p r o m i s e d !"))

smlua_text_utils_dialog_replace(DIALOG_149,1,3,30,200, ("c o l d , c o l d\
c r e v a s s e\
p l e a s e\
w a t c h \
y o u r\
s t e p s . . .\
- c h i e f \
s n o w m a n"))

smlua_text_utils_dialog_replace(DIALOG_150,1,5,30,200, ("w a a a a ! \
y o u ' v e \
f l o o d e d  m y\
h o u s e ! \
w h - w h y ?? \
e v e r y t h i n g ' s \
b e e n  g o i n g \
w r o n g  e v e r \
s i n c e  I  g o t \
t h i s  s t a r ..."))

smlua_text_utils_dialog_replace(DIALOG_151,1,4,30,200, ("y o u  a r e  t h e \
o n e  t h a t  \
f l o o d e d  m y\
h o u s e ! \
w h - w h y ?? \
e v e r y t h i n g ' s \
b e e n  g o i n g \
w r o n g  e v e r \
s i n c e  I  g o t \
t h i s  s t a r ...\
n o w  I ' m \
r e a l l y  m a d !\
w a a a a a a a a ! !"))

smlua_text_utils_dialog_replace(DIALOG_152,1,3,30,200, ("o w w c h ! \
o k a y , I  g i v e.\
t a k e  t h i s\
s t a r !\
i  d o n ' t \
r e a l l y  n e e d \
i t  a n y m o r e ...,\
p l e a s e , c o m e\
b a c k  a n d \
v i s i t  a n y t i m e ."))

smlua_text_utils_dialog_replace(DIALOG_153,1,4,30,200, ("Hey! Who's there?\
What's climbing on me?\
Is it an ice ant?\
A snow flea?\
Whatever it is, it's\
bugging me! I think I'll\
blow it away!"))

smlua_text_utils_dialog_replace(DIALOG_154,1,5,30,200, ("t h e \
p r i n c e s s \
i s  s t i l l\
l o s t\
j u s t \
l i k e  y o u .\
p l e a s e  h e l p"))

smlua_text_utils_dialog_replace(DIALOG_155,1,6,30,200, ("t h a n k s \
t o  t h e  p o w e r \
o f  t h e  s t a r s \
l i f e  i s\
r e t u r n i n g \
t o  t h e  c a s t l e !"))

smlua_text_utils_dialog_replace(DIALOG_156,1,5,30,200, ("t h i s  w o r l d \
i s  s o  s t r a n g e !\
I ' v e  s e e n \
r o o m s  c h a n g e\
t h e i r  s h a p e  \
a n d  c o l o u r s !\
i  f e e l  l i k e \
i ' m  g o i n g  \
c r a z y !\
m a y b e  \
w e  a r e !"))

smlua_text_utils_dialog_replace(DIALOG_157,1,5,30,200, ("g o o d  t o  s e e  \
y o u  a g a i n , \
o l d  f r i e n d \
i  s e e  y o u ' r e \
e s c a p i n g \
r e a l i t y  a g a i n . \
t r y i n g  t o  f i n d \
g o l d  i n s i d e \
b r i c k s . . . \
\
a r e  y o u \
f e e l i n g  o k a y ? \
\
\
\
y o u  k n o w  y o u \
c a n  a l w a y s \
t u r n  o f f   t h i s \
g a m e . \
\
\
\
b u t  b o t h \
o f  u s  k n o w . . . \
\
t h a t  y o u ' r e \
s t i l l  t r a p p e d \
i n s i d e  y o u r \
o w n   w a l l s \
\
\
\
\
a r e n ' t  y o u ?"))

smlua_text_utils_dialog_replace(DIALOG_158,1,6,30,200, ("1. If you jump repeatedly\
and time it right, you'll\
jump higher and higher.\
If you run really fast and\
time three jumps right,\
you can do a Triple Jump.\
2. Jump into a solid wall,\
then jump again when you\
hit the wall. You can\
bounce to a higher level\
using this Wall Kick."))

smlua_text_utils_dialog_replace(DIALOG_159,1,6,30,200, ("t h e s e  \
w o r l d s  s e e m  \
s t r a n g e r \
e v e r y  d a y !\
l a s t  t i m e  i  \
w a s  h e r e\
t h e r e  w a s \
a  t o w e r \
a n d  a  p r e t t y\
s t a r  u p \
h e r e\
w h e r e  d i d \
i t  g o ?\
e h h ,  i  d o n ' t \
c a r e\
i  s h o u l d  g o \
v i s i t  t h e  \
k i n g\
a n y w a y\
h e ' s  i n s i d e \
h i s  n e w  \
f o r t r e s s . . ."))

smlua_text_utils_dialog_replace(DIALOG_160,1,4,30,200, ("Press [B] while running\
fast to do a Body Slide\
attack. To stand while\
sliding, press [A] or [B]."))

smlua_text_utils_dialog_replace(DIALOG_161,1,4,30,200, ("Mario!!!\
It that really you???\
It has been so long since\
our last adventure!\
They told me that I might\
see you if I waited here,\
but I'd just about given\
up hope!\
Is it true? Have you\
really beaten Bowser? And\
restored the Stars to the\
castle?\
And saved the Princess?\
I knew you could do it!\
Now I have a very special\
message for you.\
''Thanks for playing Super\
Mario 64! This is the\
end of the game, but not\
the end of the fun.\
We want you to keep on\
playing, so we have a\
little something for you.\
We hope that you like it!\
Enjoy!!!''\
\
The Super Mario 64 Team"))

smlua_text_utils_dialog_replace(DIALOG_162,1,4,30,200, ("o w w w !\
l e t  m e  g o !"))

smlua_text_utils_dialog_replace(DIALOG_163,1,5,30,200, ("y o u ' v e \
r e a l l y \
b e a t e n \
m e  t h i s  t i m e .\
i  c a n ' t  s t a n d \
l o s i n g  t o  y o u !\
I ' m  o u t t a \
h e r e !\
j u s t  y o u \
w a i t  u n t i l \
n e x t  t i m e .\
b u w a a  h a  h a !"))

smlua_text_utils_dialog_replace(DIALOG_164,1,4,30,200, ("Mario! What's up, pal?\
I haven't been on the\
slide lately, so I'm out\
of shape.\
Still, I'm always up for a\
good race, especially\
against an old sleddin'\
buddy.\
Whaddya say?\
Ready...set...\
\
//Go//// Don't Go"))

smlua_text_utils_dialog_replace(DIALOG_165,1,5,30,200, ("I take no responsibility\
whatsoever for those who\
get dizzy and pass out\
from running around\
this post."))

smlua_text_utils_dialog_replace(DIALOG_166,1,4,30,200, ("I'll be back soon.\
I'm out training now,\
so come back later.\
//--Koopa the Quick"))

smlua_text_utils_dialog_replace(DIALOG_167,1,4,30,200, ("Princess Toadstool's\
castle is just ahead.\
\
\
Press [A] to jump, [Z] to\
crouch, and [B] to punch,\
read a sign, or grab\
something.\
Press [B] again to throw\
something you're holding."))

smlua_text_utils_dialog_replace(DIALOG_168,1,5,30,200, ("h e y !  k n o c k  \
i t  o f f !"))

smlua_text_utils_dialog_replace(DIALOG_169,1,4,30,200, ("Keep out!\
That means you!\
Arrgghh!\
\
Anyone entering this cave\
without permission will\
meet certain disaster."))

DIALOG_B3313_INTRO_AND_WARNING = smlua_text_utils_allocate_dialog()
smlua_text_utils_dialog_replace(DIALOG_B3313_INTRO_AND_WARNING,1,6,30,200, ("w a r n i n g ! \
t h i s  g a m e  h a s\
g l i t c h e s  t h a t\
m a y  a f f e c t\
p l a y e r s  w i t h\
e p i l e p s y .\
i f  y o u  a r e\
p r o n e  t o\
s e i z u r e s ,\
p l e a s e  t u r n\
o f f  y o u r\
s y s t e m .\
t h a n k  y o u\
f o r  y o u r\
c o o p e r a t i o n !\
a n d  w e l c o m e\
t o  m a r i o\
w o n d e r l a n d .\
i f  y o u ' r e  t h e\
a d v e n t u r o u s\
s o r t ,\
p a y  a  v i s i t  t o\
t h e  c a s t l e\
a h e a d ."))

DIALOG_CASTLE_ENTRY = DIALOG_066
DIALOG_LOBBY_ENTRY = DIALOG_000
DIALOG_MOUNTAIN_ENTRY = DIALOG_032
DIALOG_FIREBUBBLE_ENTRY = DIALOG_097
DIALOG_SNOWSLIDE_ENTRY = DIALOG_030
DIALOG_WATERLAND_ENTRY = DIALOG_035
DIALOG_RIVER_ENTRY = DIALOG_036
DIALOG_BATTLEFIELD_ENTRY = DIALOG_052
DIALOG_CREVASSE_ENTRY = DIALOG_015
DIALOG_SEWER_ENTRY = DIALOG_078
DIALOG_CAKE_ENTRY = DIALOG_148

DIALOG_BOBOMB_SECRET_1 = DIALOG_071
DIALOG_BOBOMB_SECRET_2 = DIALOG_072
DIALOG_BOBOMB_WARNING_1 = DIALOG_073
DIALOG_BOBOMB_WARNING_2 = DIALOG_074

DIALOG_BC_1 = smlua_text_utils_allocate_dialog()
smlua_text_utils_dialog_replace(DIALOG_BC_1,1,2,30,200, ("e e e e e e e e e e\
e e h h h h h h h h\
w h a t ' s  u p ,\
d o c ?"))

DIALOG_BC_2 = smlua_text_utils_allocate_dialog()
smlua_text_utils_dialog_replace(DIALOG_BC_2, 1,4,30,200, ("''t h a t 'l l  h o l d\
'e m  a l r i g h t !\
h e e  h e e  h e e\
h e e  h e e  h e e ! ''\
p h o o e y ! !"))

DIALOG_BC_3 = smlua_text_utils_allocate_dialog()
smlua_text_utils_dialog_replace(DIALOG_BC_3,1,3,30,200, ("g o o d  t h i n g \
y o u  p i c k e d \
t h i s  w a y ,  d o c .\
b u t  w h a t  \
c a n  y o u \
e x p e c t \
a t  t h e \
o t h e r  s i d e\
o f  t h e  d o o r ?"))

DIALOG_YOSHI_ALL_STARS = smlua_text_utils_allocate_dialog()
smlua_text_utils_dialog_replace(DIALOG_YOSHI_ALL_STARS,1,4,30,200, ("w o w !  y o u ' v e\
m a n a g e d  t o\
c o l l e c t  a l l\
t h e  s t a r s ! \
@y o u  a r e @\
@a  s u p e r @\
@p l a y e r @\
\
b u t  t h e  r e a l\
f u n  h a s\
o n l y  j u s t\
b e g u n .\
t h e  p a t h\
a h e a d  s t i l l\
l i e s  w i t h i n\
y o u r  c h o i c e s ."))