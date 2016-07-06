%% 
%% This is file `unmeereport.cls', generated 
%% on <1995/10/31> with the jwhhacks utility (3.2zzz).
%% 
%% The original source files were:
%% 
%% unmeereport.dtx 
%% 
%% 
%% This is a generated file. 
%% 
%% Copyright 1995 by James W. Howse IV. All rights reserved. 
%% Modified with permission by Neall E. Doren, January 27, 2000.
%% Further mods as per D. Bader, EECE, by N. Doren, March 07, 2000.
%% 
%% This file is distributed in the hope that it will be useful, 
%% but WITHOUT ANY WARRANTY; without even the implied warranty of 
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
%% 
%% This file is a modified form of the standard report format report.cls.  
%% It is based on report.cls version 1.3g dated 1995/06/26.
%%
%% The names of the source files used are shown above. 
%% 
%% 
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eeceTR}
              [1995/10/31
 UNM EECE report class-mod-05/10/00]
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@openright
\newif\if@openbib
\@openbibfalse
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
\DeclareOption{landscape}
   {\setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{openright}{\@openrighttrue}
\DeclareOption{openany}{\@openrightfalse}
\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
\DeclareOption{leqno}{\input{leqno.clo}}
\DeclareOption{fleqn}{\input{fleqn.clo}}
\DeclareOption{openbib}{\@openbibtrue}
\ExecuteOptions{letterpaper,10pt,oneside,onecolumn,final,openright}
\ProcessOptions
\RequirePackage{epsfig}
\RequirePackage{pslatex}
\input{unm1\@ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\newlength\@chosenpointsize
\setlength\@chosenpointsize{1\@ptsize\p@}
\setlength\parskip{0.5\@chosenpointsize \@plus \p@}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\renewcommand\topfraction{.7}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.7}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{0}
\renewcommand\floatpagefraction{1}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

\if@twoside
  \def\ps@headings{%
      \def\@oddfoot{\hfil\thepage\hfil}
      \let\@evenfoot\@oddfoot
      \def\@evenhead{{\slshape \@reporttype \@techrepnum\ }\hfil%
        {\bfseries \leftmark}}%
      \def\@oddhead{{\bfseries \rightmark}\hfil%
	{\slshape \@reporttype \@techrepnum\ }}%
      \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth {%
	##1}{}}
    \def\sectionmark##1{%
      \markright {%
        ##1}}}
\else
  \def\ps@headings{%
    \def\@oddfoot{\hfil\thepage\hfil}
    \def\@oddhead{{\slshape \@reporttype \@techrepnum\ }\hfil%
        {\bfseries \rightmark}}%
    \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markright {%
	##1}}}
\fi

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

\def\ps@myheadings{%
    \let\@oddfoot\@empty\let\@evenfoot\@empty
    \def\@evenhead{\thepage\hfil\slshape\leftmark}%
    \def\@oddhead{{\slshape\rightmark}\hfil\thepage}%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
    \let\sectionmark\@gobble
    }

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
% This material was taken from fancybox.sty by Timothy Van Zandt.  It is all
% part of the definition for the command '\thisfancypage' which allows a box
% to be put around an entire page.
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

\newbox\@fancybox
\@ifundefined{@tempdimc}{\newdimen\@tempdimc}{}

% \doublebox

\def\doublebox{\VerbBox\@doublebox}
\def\@doublebox#1{%
  \begingroup
    \setbox\@fancybox\hbox{{#1}}%
    \fboxrule=\fboxrule
    \setbox\@fancybox\hbox{\fbox{\box\@fancybox}}%
    \fboxrule=2.33\fboxrule
    \fboxsep=\fboxrule
    \advance\fboxsep 2pt
    \fbox{\box\@fancybox}%
  \endgroup}

% \VerbBox

\newtoks\do@VerbBox

\def\VerbBox#1{%
  \do@VerbBox{#1}%
  \afterassignment\begin@VerbBox
  \setbox\@fancybox=\hbox}
\def\begin@VerbBox{\aftergroup\end@VerbBox}
\def\end@VerbBox{\the\do@VerbBox{\box\@fancybox}}%

\def\fb@outputpage{%
  \let \protect \noexpand
  \shipout \vbox{%
    \set@typeset@protect
    \aftergroup\set@typeset@protect
    \if@specialpage
      \global\@specialpagefalse\@nameuse{ps@\@specialstyle}%
    \fi
    \if@twoside
      \ifodd\count\z@ \let\@thehead\@oddhead \let\@thefoot\@oddfoot
          \let\@themargin\oddsidemargin
      \else \let\@thehead\@evenhead
         \let\@thefoot\@evenfoot \let\@themargin\evensidemargin
      \fi
    \fi
  \reset@font
  \normalsize
  \baselineskip\z@skip \lineskip\z@skip \lineskiplimit\z@
%    \@shipoutsetup
    \@begindvi
%
    \ifx\this@fancypage\@empty\else
      \this@fancypage
      \gdef\this@fancypage{}%
    \fi
    \ifx\the@fancypage\@empty\else
      \setbox\@outputbox\hbox{\the@fancypage{\box\@outputbox}}%
    \fi
%
    \setbox\@outputbox \vbox{%
      \setbox\@tempboxa \vbox to\headheight{%
        \vfil
          \color@hbox
          \normalcolor
          \hb@xt@\textwidth {%
            \let \label \@gobble
            \let \index \@gobble
            \let \glossary \@gobble %% 21 Jun 91
            \@thehead
            }%
        \color@endbox
        }%                        %% 22 Feb 87
      \dp\@tempboxa \z@
      \box\@tempboxa
      \vskip \headsep
      \box\@outputbox
      \baselineskip \footskip
      \color@hbox
        \normalcolor
        \hb@xt@\textwidth{%
          \let \label \@gobble
          \let \index \@gobble      %% 22 Feb 87
          \let \glossary \@gobble   %% 21 Jun 91
          \@thefoot
          }%
      \color@endbox
    }%
%
    \ifx\the@@fancypage\@empty\else
      \setbox\@outputbox\hbox{\the@@fancypage{\box\@outputbox}}%
    \fi
%
    \vbox{%
%
%      \ifnum\fancyput@flag>-1 \do@fancyput\fi
%
      \vskip \topmargin
      \moveright\@themargin\box\@outputbox
    }%
  }%
  \global \@colht \textheight
  \stepcounter{page}%
  \let\firstmark\botmark
}

% \fancypage

\def\the@fancypage{}
\def\the@@fancypage{}
\def\this@fancypage{}

\def\fancypage#1#2{%
  \def\the@fancypage{#1}%
  \def\the@@fancypage{#2}%
  \def\@outputpage{\fb@outputpage}}

\def\thisfancypage#1#2{%
  \gdef\@outputpage{\fb@outputpage}%
  \gdef\this@fancypage{\def\the@fancypage{#1}\def\the@@fancypage{#2}}}

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
% Modified by James Howse 10/31/95
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

\def\techrepnum#1{\gdef\@techrepnum{#1}}
  \techrepnum{}
\def\reporttype#1{\gdef\@reporttype{#1}}
  \reporttype{UNM Technical Report: EECE-TR-}
\def\date#1{\gdef\@date{#1}}
  \date{\today}

\newcommand\maketitle{%
   \thisfancypage{%
     \setlength{\fboxsep}{10pt}%
     \doublebox}{}
   \@maketitle
  \if@twoside\begin{titlepage}\mbox{}\end{titlepage}\fi
}

\def\@maketitle{%
  \begin{titlepage}%
  \setlength{\topmargin}{-0.6in}
  \setlength{\oddsidemargin}{0.1in}
    \let\footnotesize\small
    \let\footnoterule\relax
    \null\vfil
    \begin{center}%
      \vspace{-4ex}%
      {\Huge\sc Department of Electrical and }%
      \vskip 0.5ex%
      {\Huge\sc Computer Engineering \par}%
      \vskip 2ex%
      \psfig{file=unm_logo.eps,width=1.5in}%
      \vskip 1ex%
      {\Huge\sc School of Engineering}%
      \vskip 0.5ex%
      {\Huge\sc University of New Mexico \par}%
      \vskip 3ex%
      {\Large\bfseries \@title \par}%
      \vskip 12ex plus2ex minus8ex%
      {\large %
      \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      \vskip 10ex plus2ex minus7ex%
      {\large  \@reporttype \@techrepnum \par}%
      \vskip 3ex%
      {\large Report Date: \@date \par}%
    \end{center}\par
    \@thanks
    \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \let\thanks\relax\let\maketitle\relax
  \gdef\@thanks{}\gdef\@author{}\gdef\@title{}
}

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

\newcommand*\chaptermark[1]{}
\setcounter{secnumdepth}{2}
\newcounter {part}
\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand\thepart         {\@Roman\c@part}
\renewcommand\thechapter      {\@arabic\c@chapter}
%\renewcommand\thesection      {\thechapter.\@arabic\c@section}
\renewcommand\thesection      {\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\newcommand\@chapapp{\chaptername}
\newcommand\part{\cleardoublepage
                 \thispagestyle{plain}%
                 \if@twocolumn
                     \onecolumn
                     \@tempswatrue
                   \else
                     \@tempswafalse
                 \fi
                 \hbox{}\vfil
                 \secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}
    {\centering
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >-2\relax
       \huge\bfseries \partname~\thepart
       \par
       \vskip 20\p@
     \fi
     \Huge \bfseries #2\par}%
    \@endpart}
\def\@spart#1{%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \Huge \bfseries #1\par}%
    \@endpart}
\def\@endpart{\vfil\newpage
              \if@twoside
                \hbox{}%
                \thispagestyle{empty}%
                \newpage
              \fi
              \if@tempswa
                \twocolumn
              \fi}
\newcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{plain}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter}#1}%
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}
\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
        \huge\bfseries \@chapapp{} \thechapter
        \par\nobreak
        \vskip 20\p@
    \fi
    \interlinepenalty\@M
    \Huge \bfseries #1\par\nobreak
    \vskip 40\p@
  }}
\def\@schapter#1{\if@twocolumn
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else
                   \@makeschapterhead{#1}%
                   \@afterheading
                 \fi}
\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \Huge \bfseries  #1\par\nobreak
    \vskip 40\p@
  }}
\newcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\Large\bfseries}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\large\bfseries}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries}}
\newcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\bfseries}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\bfseries}}
\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {2.5em}
\fi
\setlength\leftmarginii  {2.2em}
\setlength\leftmarginiii {1.87em}
\setlength\leftmarginiv  {1.7em}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {1em}
  \setlength\leftmarginvi {1em}
\fi
\setlength\leftmargin    {\leftmargini}
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{$\m@th\bullet$}
\newcommand\labelitemii{\normalfont\bfseries --}
\newcommand\labelitemiii{$\m@th\ast$}
\newcommand\labelitemiv{$\m@th\cdot$}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
% Modified by James Howse 10/31/95
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

\def\altempty#1{\gdef\@altempty{#1}}
  \altempty{}

\def\abstract#1{\gdef\@abstract{#1}}
\def\keywords#1{\gdef\@keywords{#1}}
  \keywords{}
\def\acknowledge#1{\gdef\@acknowledge{#1}}
  \acknowledge{}

\newcommand\makeabstract{\begin{titlepage}%
  \null\vskip 0pt plus 0.75fill%
  \begin{center}%
    {\Large \bfseries \abstractname \par}
  \end{center}%
  \@abstract \par
  \null\vskip 0pt plus 0.5fill%
  \if\@keywords\@altempty
  \else
  \begin{center}
    {\large \bfseries \keywordname} \par
    \@keywords \par
  \end{center}
  \fi
  \null\vskip 0pt plus 2fill%
  \if\@acknowledge\@altempty
  \else
  \begin{center}%
    {\bfseries \acknowledgename \par}%
  \end{center}%
  {\small \@acknowledge \par}%
  \fi
  \par%
  \end{titlepage}
\if@twoside\begin{titlepage}\mbox{}\end{titlepage}\fi
\let\keywords\relax\let\acknowledge\relax\let\makeabstract\relax}

%\def{\newenvironment{abstract}{%
%    \@endparpenalty\@M}
%    {\par}}{\gdef\@abstract}%
%\newenvironment{abstract}{}{}

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

\newenvironment{verse}
               {\let\\=\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item[]}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item[]}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item[]}
               {\endlist}
\newenvironment{titlepage}
    {%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \if@compatibility
        \setcounter{page}{0}
      \else
        \setcounter{page}{1}%
      \fi}%
    {\if@restonecol\twocolumn \else \newpage \fi
      \setcounter{page}{1}%
    }
%\newcommand\appendix{\par
%  \setcounter{chapter}{0}%
%  \setcounter{section}{0}%
%  \renewcommand\@chapapp{\appendixname}%
%  \renewcommand\thechapter{\@Alph\c@chapter}}
\newcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \renewcommand\@chapapp{\appendixname}%
  \renewcommand\thechapter{\@Alph\c@chapter}
  \renewcommand\thesection{\@Alph\c@section}}
\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}
\@addtoreset{equation}{chapter}
% \renewcommand\theequation{\thechapter.\@arabic\c@equation}
\renewcommand\theequation{\@arabic\c@equation}
%\newcounter{figure}[chapter]
% \renewcommand\thefigure{\thechapter.\@arabic\c@figure}
\newcounter{figure}
\renewcommand\thefigure{\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
%\newcounter{table}[chapter]
% \renewcommand\thetable{\thechapter.\@arabic\c@table}
\newcounter{table}
\renewcommand\thetable{\@Roman\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{0\p@}
\setlength\belowcaptionskip{0\p@}
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{#1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch{\relax}{\mathcal}}
\DeclareRobustCommand*\mit{\@fontswitch{\relax}{\mathnormal}}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{2}
\newcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{%
           \contentsname}{\contentsname}}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty{-\@highpenalty}%
    \addvspace{2.25em \@plus\p@}%
    \begingroup
      \setlength\@tempdima{3em}%
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}
    \endgroup
  \fi}
\newcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\newcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand*\l@subsection{\@dottedtocline{2}{3.8em}{3.2em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{7.0em}{4.1em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{10em}{5em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{12em}{6em}}
\newcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename
      \@mkboth{\listfigurename}%
              {\listfigurename}}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename
      \@mkboth{%
          \listtablename}{\listtablename}}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }
\let\l@table\l@figure
\newdimen\bibindent
\bibindent=1.5em
\newenvironment{thebibliography}[1]
     {\section*{\bibname
        \@mkboth{\bibname}{\bibname}}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \if@openbib
              \advance\leftmargin\bibindent
              \itemindent -\bibindent
              \listparindent \itemindent
              \parsep \z@
            \fi
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \if@openbib
        \renewcommand\newblock{\par}%
      \else
        \renewcommand\newblock{\hskip .11em \@plus.33em \@minus.07em}%
      \fi
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.=\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\newcommand\newblock{}
\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\@makeschapterhead{\indexname}]%
                \@mkboth{\indexname}%
                        {\indexname}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem{\par\hangindent 40\p@}
\newcommand\subitem{\par\hangindent 40\p@ \hspace*{20\p@}}
\newcommand\subsubitem{\par\hangindent 40\p@ \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule\@width.4\columnwidth
  \kern2.6\p@}
\@addtoreset{footnote}{chapter}
\long\def\@makefntext#1{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\bibname{References}
\newcommand\indexname{Index}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\chaptername{Chapter}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
\newcommand\keywordname{Keywords}
\newcommand\acknowledgename{Acknowledgments}
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
\newcommand\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
\pagestyle{headings}
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
\pagenumbering{arabic}
\if@twoside
\else
  \raggedbottom
\fi
\if@twocolumn
  \twocolumn
  \sloppy
  \flushbottom
\else
  \onecolumn
\fi
\endinput
%% 
%% End of file `unmeereport.cls'.
