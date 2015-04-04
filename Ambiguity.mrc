;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Ambiguity v1.0 by Ryan && Sara ;;

;; For mIRC 7.x and up ;;

;; irc.swiftirc.net @ #msl ;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

alias theme return Ambigüity

alias tversion return v1.0

alias ttimestamp return 14《 15hh14:15nn14:15sstt 14》

alias pre return $b($+($c1(›),›))

alias pre2 return $+([,$c1(⃠),])

alias b return $+(,$1-,)

alias u return $+(,$1-,)

alias i return $+(,$1-,)

alias error return $pre $b(Error:)

alias c1 return $+(04,$1-,)

alias c2 return $+(15,$1-,)

alias c3 return $+(14,$1-,)

alias mc return $+(08,$1-,)

alias vmsg { msg + $+ $chan $$1- }

alias hmsg { msg % $+ $chan $$1- }

alias omsg { msg @ $+ $chan $$1- }

alias acolor return $regsubex($1,/^.+?!(.+?)@(.+?)$/,$+(\1,$c1(@),\2))

alias ccolor return $replace($1,~,05~,&,04&,@,04@,%,07%,+,12+)

alias pnick return $iif($2 ison $1,$regsubex($nick($1,$2).pnick,/^([~&!@%+]+)/,$left(\1,1)),$2)

alias changeday echo -a $pre Day changed to $asctime($calc($ctime + 600),dddd mmmm doo $+ $chr(44) yyyy)

alias atime return $time($1,ddd mmm dd yyyy @ HH:nn)

alias qnotify if ($query($1)) echo $color(other) $1 $pre $2-

alias services { return ChanServ|NickServ|BotServ|HostServ|MemoServ|OperServ|HelpServ|Global }

alias br return $+(,$c1([),,$1-,,$c1(]),)

alias par {

if ($prop == p) { return $+($b($chr(40)),$1-,$b($chr(41))) }

else { return $+($c1($b($chr(40))),$1-,$c1($b($chr(41)))) }

}

alias gmtc {

var %time $calc($ctime($1-) - $gmt + $daylight)

$iif($isid,return,echo -a) $+([,$iif($duration(%time) < 0,04- $duration($abs(%time)),09+ $duration(%time)),])

}



on *:LOAD:{

echo $pre $theme $tversion by Sara loaded

.timestamp -f $ttimestamp

}

on *:UNLOAD:{ echo $pre $theme $tversion by Sara unloaded }

on *:START:{

.timestamp -f $ttimestamp

.timerday -io 00:00:01 1 0 changeday

.titlebar $version - Ambigüity $tversion by Sara

inc %loads

echo -s $pre mIRC $version :: $theme $tversion by Sara :: Loaded %loads times

;;.timertitle -o 0 1 titlebar $version - Ambigüity $tversion by Sara - Idle: $!duration($idle) - Session: $!duration($duration($uptime(mirc,1)))

}

on &*:INPUT:*:{

if (($left($1,1) != /) || ($ctrlenter) || ($inpaste)) {

haltdef

var %text $1-

.raw privmsg $active : $+ %text

echo -ct own $active $c2(⁞) 「 $b($iif($chan,$regsubex($pnick($chan,$me),/^([~&@%+])?(.+)/,$iif(\2,\1) $+ $+(,$nick($chan,$me).color,$me,)),$mc($me))) 」 %text

}

}

on ^*:TEXT:*:*:{

haltdef

echo -ctml other $iif($chan,$chan,$nick) $c2(⁞ 「) $b($iif($chan && $nick ison $chan,$regsubex($pnick($chan,$nick),/^([~&!@%+])?(.+)/,$iif(\2,\1) $+ $+(,$nick($chan,$nick).color,$iif(\2,\2,\1),)),$iif($chan,$nick,$+(10,$nick,)))) $iif($chan && $left($target,1) != $chr(35),$+($chr(40),$ccolor($left($target,1)),$chr(41))) $c2(」) $1-

}

on ^*:ACTION:*:*:{

haltdef

echo -ctml action $iif($chan,$chan,$nick) $c2(⁞) ⵘⵘ $b($iif($chan,$pnick($chan,$nick),$nick)) $1-

}

on ^*:RAWMODE:#:{

haltdef

echo -ct mode $chan $c2(⁞) ໑ $b($pnick($chan,$nick)) sets mode: $b($1-)

}

on ^*:USERMODE:{

haltdef

echo -cts mode $pre Usermode: $b($1-)

}

on ^*:NICK:{

haltdef

var %a 1

while (%a <= $comchan($newnick,0)) {

echo -ct nick $comchan($newnick,%a) $c2(⁞) $c1(⌫) Nick change: $b($nick) $c1(➜) $b($newnick)

inc %a

}

}

on ^*:JOIN:#:{

haltdef

if ($nick == $me) { echo $color(join) -t $chan $c1(⇉) You joined $par($chan) }

else {

echo -ct join $chan $c2(⁞) $c1(⇉) Joins: $b($nick) $par($acolor($fulladdress))

qnotify $nick $nick has joined $chan

}

}

on ^*:PART:#:{

haltdef

if ($nick != $me) {

echo -ct part $chan $c2(⁞) $c1(⇇) Parts: $b($pnick($chan,$nick)) $par($acolor($fulladdress)) $iif($1-,$par($1-).p)

qnotify $nick $nick parted from $chan

}

}

on ^*:QUIT:{

haltdef

var %a 1

while (%a <= $comchan($nick,0)) {

echo -ct quit $comchan($nick,%a) $c2(⁞) $c1(⇇⇇) Quits: $b($pnick($comchan($nick,%a),$nick)) $par($acolor($fulladdress)) $par($1-).p $iif(Quit:* !iswm $1- && Banned from isin $1- && ($ctime($5-9)),$+([,$duration($calc($ctime($5-9) - $gmt + $daylight)),]))

inc %a

}

qnotify $nick $nick has left IRC

}

on ^*:KICK:#:{

haltdef

if ($knick == $me) {

echo -ct kick $chan ※ You have been kicked from $chan by $b($pnick($chan,$nick)) $par($1-).p

echo -cst kick ⏎ You have been kicked from $chan by $b($pnick($chan,$nick)) $par($1-).p

}

else {

echo -ct kick $chan $c2(⁞) ※ Kicked $b($knick) $iif($address($knick,5),$par($acolor($address($knick,5)))) from $chan by $b($pnick($chan,$nick)) $par($1-).p

}

if ($nick == $me) inc %kicks

qnotify $knick $knick was kicked from $chan by $nick

}

on *:BAN:*:{

if ($ialchan($remove($banmask,~n:,~r:,~q:),$chan,0)) {

var %i = $v1,%r

while (%i) {

%r = %r $nick($chan,$ialchan($remove($banmask,~n:,~r:,~q:),$chan,%i).nick).pnick

if ($len(%r) > 500) {

%r = %r $+ ...

break

}

dec %i

}

echo -t $chan $c2(⁞) This ( $+ $banmask $+ ) ban affects: $replace(%r,$chr(32),$chr(44) $+ $chr(32))

}

if ($banmask iswm $address($me,5)) && (%autounban == on) { mode $chan -b $banmask }

}

on ^*:TOPIC:#:{

haltdef

echo -ct topic $chan $c2(⁞) ༶ Topic change: $1- by $b($pnick($chan,$nick))

}

on ^*:NOTICE:*:#:{

haltdef

if (*invited*into the channel* iswm $1-) { echo $color(notice) -t $chan $c2(⁞) $+($c1(«),$c2(«) $b($c2($chr(40))),$nick,$b(/),$chan,$b($c2($chr(41)))) ⁞ $b($1) invited $b($3) into the channel. }

else {

$iif($cid == $activecid,echo -ctm notice,scid $v1 echo -ct notice) $chan $c2(⁞) $+(,$c1(«),$c2(«),$chr(32),$c2($chr(40)),,$nick,$b(/),$chan,,$c2($chr(41)),,:) $1-

}

}

on ^*:NOTICE:*:?:{

haltdef

if ($cid != $activecid) { scid $v1 echo -cst notice $+(,$c1(«),$c2(«),$chr(32),$c2($chr(40)),,$nick,,$c2($chr(41)),,:) $replace($1-,$chr(124),$!chr(124),$chr(36),$!chr(36),$chr(37),$!chr(37)) }

else { echo -catm notice $+(,$c1(«),$c2(«),$chr(32),$c2($chr(40)),,$nick,,$c2($chr(41)),,:) $1- }

$iif(!$window(@Notices),window -e @Notices)

$iif(!$istok($services,$nick,124) && [*] !iswm $1 && $nick != iKick,echo -t @Notices $+([,$network,]) $+(-,$b($nick),-) $1-)

}

on *:DEOP:#: {

if ($opnick == $me) && ($nick != $me) && ($chan != $active) { echo -a $pre You have been deopped in $b($chan) by $b($nick) }

}

on *:DEHELP:#: {

if ($hnick == $me) && ($nick != $me) && ($chan != $active) { echo -a $pre You have been dehalfopped in $b($chan) by $b($nick) }

}

on *:DEVOICE:#: {

if ($vnick == $me) && ($nick != $me) && ($chan != $active) { echo -a $pre You have been devoiced in $b($chan) by $b($nick) }

}

on ^*:TOPIC:#:{

haltdef

echo -ct topic $chan $pre Topic change: $1- by $b($pnick($chan,$nick))

}

on ^*:INVITE:#:{

haltdef

$iif($cid == $activecid,echo -at,scid $v1 echo -st) $pre -!- Invite: $b($nick) invited you to join $b($chan)

}

#dns on

alias dns {

haltdef

.dns $$1-

}

on *:DNS:{

haltdef

var %d $dns(0)

if (%d == 0) { echo -a $pre DNS: Unable to resolve host }

else {

if (%d > 1) {

echo -a $c2(-----<dns>------------------------------)

while (%d > 0) {

echo -a $pre $+([,%d,]) DNS: $c1($dns(%d)) resolved to $c1($iif($dns(%d).addr == $dns(%d),$dns(%d).ip,$dns(%d).addr))

dec %d

}

echo -a $c2(----</dns>------------------------------)

}

else {

echo -a $pre DNS: $c1($dns(1)) resolved to $c1($raddress)

}

}

}

#dns end

on *:CTCPREPLY:*:{

haltdef

if (ping isin $1-) { var %p $duration($calc($ctime - $($+(%,ping.,$nick),2))) }

$iif($cid == $activecid,echo -at,scid $v1 echo -st) $pre CTCP $qt($1) reply from $b($nick) $+ : $iif(%p,%p,$2-)

}

ctcp *:*:*:{

haltdef

$iif($cid == $activecid,echo -at,scid $v1 echo -st) $pre CTCP $qt($1) from $b($nick) $par($$2-)

}

alias notice {

haltdef

.raw notice $$1 $$2-

echo -ct notice $+(,$c1(»),$c2(»),$c1(»),$chr(32),$c2($chr(40)),,$1,,$c2($chr(41)),,:) $2-

}

#msg on

alias msg {

haltdef

.raw privmsg $$1 $$2-

if ($left($1,1) isin +%@&~) { var %c $remove($1,+,%,@,&,~) | if ($me ison %c) { echo -ct msg %c $c2(⁞) $c2(「) $b($regsubex($pnick(%c,$me),/^([~&@%+])?(.+)/,$iif(\2,\1) $+ $+(,$nick(%c,$me).color,$me,))) $+($chr(40),$ccolor($left($1,1)),$chr(41)) $c2(」) $2- } }

else { var %c $1 | $iif($window($1),echo -ct msg $1 $c2(⁞) 「 $b($iif($me ison %c,$regsubex($pnick(%c,$me),/^([~&@%+])?(.+)/,$iif(\2,\1) $+ $+(,$nick(%c,$me).color,$me,)),$+ $mc($me))) 」 $2-) }

$iif(%c != $active,echo -t $c1(») $+ $c2(») $par($1) · $2-)

}

alias say {

haltdef

msg $active $$1-

}

#msg end

alias ctcp {

haltdef

if ($2 == ping) { set -u5 $+(%,ping.,$1) $ctime }

.ctcp $$1 $$2-

echo -cat ctcp $pre CTCP to $b($1) $+ : $2-

}

alias describe {

haltdef

.describe $$1 $$2-

echo -cat action $c2(⁞) ⵘⵘ $b($iif($chan,$pnick($chan,$me),$me)) $$2-

}

alias me {

haltdef

.describe $active $$1-

}

alias whois { set -u10 $+(%,whois.,$1) on | .whois $$1- }

alias names { set -u10 $+(%,names.,$1) on | names $$1 }

alias bans { set -u10 $+(%,bans.,$iif($1,$1,$active)) on | mode $iif($1,$1,$active) b }

#raw on

raw *:*:{

var %n $numeric, %e -s $pre, %t

if (%n isnum && %n > 0) && (!$istok(322,%n,32)) {

haltdef

if $istok(001 002 003 004 005 006 007,%n,32) { %t = $2- }

elseif (%n == 008) { %t = Snomask: $b($remove($5,$chr(40),$chr(41))) }

elseif (%n == 205) { %t = [trace] $4-5 • Lag: $6 }

elseif (%n == 221) { %t = Usermode: $b($2-) }

elseif (%n == 229) { var %raw off | %t = $+([,$2,]) $3-4  $+(,$8,)  $+($chr(123),$9,$chr(125))  $+(06,$10-,)  $+([,$duration($6) ago,]) }

elseif (%n isnum 210-250) { var %raw off | %t = $iif($len($2) == 1,$+([,$2,]),$2) $3- }

elseif (%n == 251) { %t = $4 users and $7 invisible on $10 servers }

elseif (%n == 252) { %t = Operators: $2 }

elseif (%n == 253) { %t = Unknown: $2- }

elseif (%n == 254) { %t = Channels: $2 }

elseif (%n == 255) { %t = Users: $4 }

elseif (%n == 256) { %t = Administrative info • $5 }

elseif (%n == 257) || (%n == 258) { %t = $2-3 $iif($5,• $5) }

elseif (%n == 265) { %t = Local: $5 $par(max: $7) }

elseif (%n == 266) { %t = Global: $5 $par(max: $7) }

elseif (%n == 302) { %t = Userhost: $2- }

elseif (%n == 303) { %t = [ison] $replace($c1($2-),$chr(32), $c2(•) ) }

elseif (%n == 324) { var %raw off | %e = -t $2 $c1(Ѳ) | %t = Modes: $3- }

elseif (%n == 329) {

if (%chalt) { var %halt on }

else { var %raw off | %e = -t $2 $c1(Ѳ) | %t = Created: $atime($3) }

}

elseif (%n == 332) { var %raw off | %e = -ct topic $2 $c1($chr(3894)) | %t = Topic: $3- }

elseif (%n == 333) { var %raw off | %e = -ct topic $2 $c1($chr(3894)) | %t = $i(Set by $b($c1($gettok($3,1,33))) $iif($gettok($3,2,33),$par($acolor($v1))) on $atime($4)) }

elseif (%n == 341) { var %halt on }

elseif (%n == 346) || (%n == 347) { var %halt on | $iif($($+(%,invite.,$2),2),echo -s $pre $+([,$2,]) $3-,halt) }

elseif (%n == 348) || (%n == 349) { var %halt on | $iif($($+(%,except.,$2),2),echo -s $pre $+([,$2,]) $3-,halt) }

elseif (%n == 353) { var %halt on | $iif($($+(%,names.,$3),2),echo -s $pre $+([,$3,]) Names: $replace($4-,~,5~,&,5&,@,4@,%,7%,+,12+),halt) }

elseif (%n == 366) { var %halt on | $iif($($+(%,names.,$2),2),echo -s $pre $+([,$2,]) End of /NAMES,halt) }

elseif (%n == 367) {

var %halt on

if ($($+(%,bans.,$2),2)) { echo -s $pre $+([,$2,]) $c1($3) $+(,$4,) $duration($calc($ctime - $5)) ago }

if ($(,$+(%,bm.,$2))) {

if ($v1 iswm $3) { echo -ag $pre $+([,$2,]) Match found: $c1($3) set by $+(,$4,) $duration($calc($ctime - $5)) ago }

}

}

elseif (%n == 401) || (%n == 402) { %e = -a $pre | %t = No such $iif(#* iswm $2,channel:,nick:) $2 }

elseif (%n == 421) { %e = -a $pre | %t = $upper($2) $3- }

elseif (%n == 518) { %e = -a $pre }

elseif (%n == 605) { if ($istok(Nerd Ghost Pluto,$2,32)) { %e = -a $pre | %t = 04 $+ $2 is online! } }

; Whois raws

elseif ($istok(311 379 615 378 319 312 330 338 616 301 310 313 307 335 671 275 337 320 536 537 317 318,%n,32) && $(,$+(%,whois.,$2))) {

if (%n == 311) { var %raw off | echo -a $+(15----------,$c2(<),15whois,$c2(>),15-----------------------------------) | %e = -a $pre2 | %t = $c2(Nick) : $2 $par($+($3,$c1(@),$c3($4))) • $6- }

elseif ($istok(379 615,%n,32)) { var %raw off | %e = -a $pre2 | %t = $c2(Usermodes) : $6- }

elseif (%n == 378) { var %raw off | %e = -a $pre2 | %t = $c2(Connecting from) : $6 • $c1($7) }

elseif (%n == 319) {

var %chan $3-

if ($comchan($2,0) > 0) {

var %i 1, %common, %c, %regex = $+(/(?<=^| )[~&@%+]*\Q,$v1,\E(?=$| )/i)

while ($comchan($2,%i)) {

%chan = $remtok(%chan,$wildtok(%chan,$+(*,$comchan($2,%i)),1,32),1,32)

%c = $addtok(%c,$+($regsubex($nick($v1,$2).pnick,/(?!(?<=^)[~&@%+])./g,),$v1),44)

inc %i

}

%chan = $regsubex(%chan,$(%regex),)

%common = $replace(%c,$chr(44),$chr(32))

}

var %halt on, %raw off

$iif(%chan,echo -a $pre2 $iif(!%raw,$br(%n)) $c2(Channels) : $ccolor(%chan) $br($numtok(%chan,32)))

$iif(%common,echo -a $pre2 $iif(!%raw,$br(%n)) $c2(Common Channels) : $ccolor(%common) $br($numtok(%common,32)))

}

elseif (%n == 312) { var %raw off | %e = -a $pre2 | %t = $c2(Server) : $3 $par($c3($4-)) }

elseif (%n == 330) { var %raw off | %e = -a $pre2 | %t = $c2(Authname) : $3 }

elseif (%n == 338 || %n == 616) { var %raw off | %e = -a $pre2 | %t = $c2(Connecting from) : $iif(%n == 616 || $4 == actually,$5 • $c1($6),$3 • $c1($4)) }

elseif (%n == 301) { var %raw off | %e = -a $pre2 | %t = $c2(Away) : $par($3-) }

elseif (%n == 310) { var %raw off | %e = -a $pre2 | %t = $iif(helper isin $3-,$c2(Network Helper) : Yes.,$c2(Usermodes) : $6-) }

elseif (%n == 313) { var %raw off | %e = -a $pre2 | %t = $c2(Network Functions) : $5- }

elseif (%n == 307) { var %raw off | %e = -a $pre2 | %t = $c2(Registered) : Yes }

elseif (%n == 335) { var %raw off | %e = -a $pre2 | %t = $c2(Bot) : Yes }

elseif ($istok(671 275 337,%n,32)) { var %raw off | %e = -a $pre2 | %t = $c2(Secure Connection) : Yes }

elseif (%n == 320) { var %raw off | %e = -a $pre2 | %t = $c2(Swhois) : $3- }

elseif (%n == 536) { var %raw off | %e = -a $pre2 | %t = $c2(Filtering Messages) : Yes }

elseif (%n == 537) { var %raw off | %e = -a $pre2 | %t = $c2(Immune to Filtering) : Yes }

elseif (%n == 317) { var %raw off | %e = -a $pre2 | %t = $c2(Idle) : $duration($3) $par($c3(Sign-on: $atime($4))) }

elseif (%n == 318) { var %halt on | echo -a $+(15---------,$c2(<),15/whois,$c2(>),15-----------------------------------) }

}

;

; Whowas raws

elseif (%n == 406) { var %halt on | echo -a $+(15-----,$c2(<),15whowas,$c2(>),15-------------------------------) | echo -a $pre2 There was no nickname: $2 }

elseif (%n == 314) { var %raw off | echo -a $+(15-----,$c2(<),15whowas,$c2(>),15------------------------------) | %e = -a $pre2 | %t = Nick: $2 $par($+($3,04@,07,$4)) • $6- }

elseif (%n == 312) { var %raw off | %e = -a $pre2 | %t = Server: $3 $par($4-) }

elseif (%n == 369) { var %halt on | echo -a $+(15-----,$c2(<),15/whowas,$c2(>),15-----------------------------) }

;

; Who raws - if you don't want to see these, change them both to { halt }

elseif (%n == 352) { var %raw off | %e = -sg $pre | %t = $+($c2([),$2,$c2(])) $+(,$ccolor($iif($right($7,1) !isincs rHBG,$right($7,1))),,$6) $par($+($3,@,$4)) • $+($9-,$chr(15)) $iif(* isin $7,$b(OPER) on) $+($chr(123),$5,$chr(125)) $iif($left($7,1) == G,[Away]) }

elseif (%n == 315) { var %raw off | %e = -sg $pre | %t = $+($c2([),$2,$c2(])) End of /WHO list }

;

; Watch

elseif $istok(603,%n,32) { var %halt on }

if (!%halt) { echo %e $iif(!%raw,$br(%n)) $iif(%t,%t,$2-) }

}

}

#raw end



alias acommands {

echo -ag $pre $theme $tversion included features:

echo -ag $pre /aidle ON/OFF - Enables/disables anti-idle (resets idle time every 10 seconds)

echo -ag $pre /gmtc time - Returns the amount of time since/until the specified time

echo -ag $pre /cls #channel - Scans for clones

echo -ag $pre /bm #channel *!*@hostmask - Checks for matching bans

echo -ag $pre /box (color1,color2) text - A fun colored box alias

echo -ag $pre /bau text - The most annoying text effect alias ever created

}



alias cls {

if ($active !ischan) && (!$1) echo -a 10 Error: you must specify a channel

elseif ($1) && ($me !ison $1) echo -a 10 Error: you are not on $1

else {

tokenize 32 $iif($1,$1,$active)

who $1

.timer 1 1 clonecheck $1-

}

}

alias clonecheck {

var %a $nick($1,0), %x 0

while (%x <= %a) {

var %b = $address($nick($1,%x),2)

if ($ialchan(%b,$1,0) > 1) && (!$istok(%d,%b,44)) {

var %y = 1, %e = $ialchan(%b,$1,0), %f = yes

while (%y <= %e) {

var %g = $gettok($ialchan(%b,$1,%y),1,33)

var %c = $iif(%c,10 $+ %c $+  &) $+(10,%g,)

inc %y

}

echo -a 10›› $+([,$1,]) $chr(40) $+(10,$numtok(%c,38),) clones @ $gettok(%b,2,64) $chr(41) - %c

var %d = $addtok(%d,%b,44)

unset %c

}

inc %x

}

if (!%f) echo -a 10›› No clones found in $1

}

alias bm {

if ($active !ischan) && (!$1) echo -a 10›› Error: you must specify a channel

elseif ($1) && ($me !ison $1) echo -a 10›› Error: you are not on $1

else {

tokenize 32 $iif(#* iswm $1,$1,$active) $$2-

set -u10 $+(%,bm.,$1) $2-

echo -a $pre Scanning $b($1) for bans matching $c1($2-)

mode $1 b

}

}

alias aidle {

if ($1 == ON) { .timeraidle -o 0 10 $!iif($status == connected,.raw privmsg $me $+ @ $+ $server AIDLE) | .ignore $me | echo -a $pre AIDLE set to ON }

else if ($1 == OFF) { .timeraidle off | .ignore -r $me | echo -a $pre AIDLE set to OFF }

else { echo -a $pre AIDLE is $iif($timer(aidle),ON,OFF) }

}



alias unicode { $iif($1,msg $1,echo -a) $u(http://www.tamasoft.co.jp/en/general-info/unicode.html) }

alias ears { return ᕳ(●̮̮̃•̃)ᕲ }

alias butterfly { return Ƹ̵̡Ӝ̵̨̄Ʒ }

alias fish { return ༕ ༖ ༗ }

alias mouse { return ꘐ }

alias house { return 仚 }

alias heart { return ♥ }

alias apple { return Ѿ }

aias music { return ♩ ♪ ♫ ♬ ♭ ♮ ♯ }

alias fu { return ꗿ }



alias box var %color1 = $iif($regsubex($$1,/^(\d+)[\s|\x2C].*/,\1) isnum 0-15,$v1,04), %color2 = $iif($regsubex($1,/.+\x2C(\d+)$/,\1) isnum 0-15,$v1,14), %line = $+($chr(160),$chr(160),$iif($left($1,1) isnum,$2-,$1-),$chr(160),$chr(160)) | say $+(,%color1,$chr(44),%color1,%line) | say $+(01,$chr(44),%color1,%line,,%color2,$chr(44),%color2,$chr(160)) | say $+(,%color1,$chr(44),%color1,%line,,%color2,$chr(44),%color2,$chr(160)) | say $+($chr(160),,%color2,$chr(44),%color2,%line)

alias bau say $regsubex($$1-,/(.)/g,$+($+($chr(3),$r(0,15),$chr(44),$r(0,15)),$token($chr(2) $chr(31) $chr(29), $r(1,3), 32),$iif($r(0,1),$upper(\1),$lower(\1)),$chr(15)))
