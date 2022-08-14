% JLREQクラスを用いたArticleのクラスファイル
% Yuta TESHIMA, 2022/06/28
%
% jlreq.clsに改造を施し，自分好みのスタイルに変更する．
% クラスファイルはjlreqを用いることを前提として設計されている．
% そのほかのクラスファイル（例えば，jsarticle）では動作しない．
\NeedsTeXFormat{LaTeX2e}[2022/01/01]
\ProvidesClass{mfg-article}[2022/06/29 the MFG article package developed by yteshima]

\LoadClassWithOptions{jlreq}

\RequirePackage[ipaex]{luatexja-preset}
\RequirePackage{amsmath, amssymb, physics}
\RequirePackage{mathtools}
\RequirePackage{unicode-math}
\unimathsetup{math-style=ISO,bold-style=ISO}

\RequirePackage{tikz}
\RequirePackage[unicode=true]{hyperref}
\RequirePackage[framemethod=tikz]{mdframed}
\RequirePackage[explicit]{titlesec}						% section，subsectionなどを装飾するために使用
\RequirePackage{fancyhdr}

% 等幅フォントにMiguを使うか否かのオプション
\newif\if@yteshi@migu
\@yteshi@migufalse
\DeclareOption{migu}{\@yteshi@migutrue}
\DeclareOption{nomigu}{\@yteshi@migufalse}
\ProcessOptions\relax

%% Fonts
\setmainfont{Libertinus Serif}
\setsansfont{Libertinus Sans}
\setmathfont{TeX Gyre Pagella Math}
\if@yteshi@migu
	\setmonofont[
		Extension = .ttf,
		BoldFont  = migu-1m-bold
	]{migu-1m-regular}
	\setmonojfont[
		Extension = .ttf,
		BoldFont  = migu-1m-bold
	]{migu-1m-regular}
\else\fi

\let\boldsymbol\symbf\relax

%% Page style
\setlength{\topmargin}{0pt}
\setlength{\headheight}{\baselineskip}
\setlength{\headsep}{10pt}
\setlength{\textheight}{668pt}
\addtolength{\textheight}{-\baselineskip}

%% Misc. commands
\renewcommand{\today}{\the\year/\the\month/\the\day}
\let\keepbaselineskip\jlreq@keepbaselineskip

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Headings
\def\@catpaw{%
\begin{tikzpicture}[baseline=0pt]
	% にゃんこのフレーム（デバッグ用）
	% \draw (0, -0.4\baselineskip) rectangle +(0.6\baselineskip, 0.6\baselineskip); 
	\node[inner sep=\z@, anchor=south west] (cat) at (0, -0.15\baselineskip)
	{\includegraphics[height=0.6\baselineskip]{catpaw.pdf}};
\end{tikzpicture}%
}

\fancypagestyle{titlepagestyle}
{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[C]{\@catpaw\hskip1ex\thepage\hskip1ex\@catpaw}
}

\fancypagestyle{plain}{%
	\fancyhf{}
	\fancyhead[L, R]{}
	\fancyhead[C]{%
		\setmainjfont[
			Extension = .ttf,
			BoldFont  = GenJyuuGothic-P-Heavy
		]{GenJyuuGothic-P-Medium}%
		\setmainfont[
			Extension = .ttf,
			BoldFont  = GenJyuuGothic-P-Heavy
		]{GenJyuuGothic-P-Medium}
		\yteshi@title
	} %ヘッダ中央
	\fancyfoot[L, R]{}
	\fancyfoot[C]{%
	\@catpaw\hskip1ex\thepage\hskip1ex\@catpaw%
	} %フッタ中央．ページ番号を表示
}
\pagestyle{plain}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Title page
\gdef\yteshi@title{}
\if@titlepage
\else
	\ExplSyntaxOn
	% `jlreq.cls' から基本的には変更していない．
	% pagestyleの箇所のみ変更を加えている．
	\renewcommand{\maketitle}{%
    \par
    \begingroup
      \renewcommand{\thefootnote}{\fnsymbol{footnote}}%
      \renewcommand{\@makefnmark}{\hbox{%
        \jlreq@iftdir{\yoko}{}%
        \rlap{\@textsuperscript{\normalfont\@thefnmark}}%
      }}%
      \renewcommand{\jlreq@referencemark@format}[1]{\@makefnmark}% うーん
      \if@twocolumn
        \ifnum\col@number=\@ne
          \@maketitle
        \else
          \twocolumn[\@maketitle]%
        \fi
      \else
        \newpage
        \global\@topnum\z@
        \@maketitle
      \fi
      % \pagestyle{empty}の時はそのまま．
      \bool_if:nT {!(
        \tl_if_empty_p:o \@oddhead &&
        \tl_if_empty_p:o \@evenhead &&
        \tl_if_empty_p:o \@oddfoot &&
        \tl_if_empty_p:o \@evenfoot
      )} { \thispagestyle{titlepagestyle} }	% modified by yteshima
      \@thanks
    \endgroup
    \jlreq@endofmaketitle
  }
	\ExplSyntaxOff
	\renewcommand{\@maketitle}{%
		\null%
		\vskip-\baselineskip % \nullで足されてしまった分を引く
		% \vskip-\headsep% \headsep + \headheightの高さ分だけ上にシフトさせる
		\vskip-\headheight%
		\noindent\hrulefill\par% 横線
		\vskip0.5\baselineskip%
		\begingroup\centering
		\setmainjfont[
			Extension = .ttf,
			BoldFont  = GenJyuuGothic-P-Heavy
		]{GenJyuuGothic-P-Medium}%
		\setmainfont[
			Extension = .ttf,
			BoldFont  = GenJyuuGothic-P-Heavy
		]{GenJyuuGothic-P-Medium}
		{
			\jlreq@keepbaselineskip{\LARGE}\@title
		}%
		\par\vskip0.3\baselineskip
		{
			\jlreq@keepbaselineskip{\small}
			\ifx\@date\@empty%
				\vphantom{\@date}%
			\else
				\sffamily\@date%		
			\fi%
		}%
		\par\vskip0.3\baselineskip
		{
			\jlreq@keepbaselineskip{\large}
			\begin{tabular}[t]{c}
				\@author
			\end{tabular}
		}
		\par
		\endgroup
		\noindent\hrulefill% 横線
		\vskip\baselineskip
		\ifvoid\jlreq@abstractbox\else\unvbox\jlreq@abstractbox\fi%
		\global\edef\yteshi@title{\@title\relax}
	}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Section
\titleformat{\section}[block]
{% 書式
	\setmainjfont[
		Extension = .ttf,
		BoldFont  = GenJyuuGothic-P-Heavy
	]{GenJyuuGothic-P-Medium}%
	\setmainfont[
		Extension = .ttf,
		BoldFont  = GenJyuuGothic-P-Heavy
	]{GenJyuuGothic-P-Medium}%
	\jlreq@keepbaselineskip{\Large}%
}{% ラベル書式
	\thesection%
	\hskip0.5em%
	\begin{tikzpicture}[overlay]
		% にゃんこのフレーム（デバッグ用）
		%\draw (0, -0.4\baselineskip) rectangle +(0.815\baselineskip, 1.5\baselineskip); 
		\node[inner sep=\z@, anchor=south west] (cat) at (0, -0.4\baselineskip)
		{\includegraphics[height=1.5\baselineskip]{fatcat.pdf}};
	\end{tikzpicture}
}{% ラベルと見出し文字列の間の空き
	\baselineskip%
}{% 見出しの直前に入るコード
	#1%
}
%[% 見出しの直後に入るコード
%{\addvspace{0.4ex}\titlerule[2pt]}%
%]
\titlespacing*{\section}
{0pt} % 左の空き
{1\baselineskip plus .3\baselineskip minus .06\baselineskip} % 上の空き
{1\baselineskip plus .1\baselineskip}	% その後の本文との空き

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Subsection
\titleformat{\subsection}[block]
{% 書式
	\setmainjfont[
		Extension = .ttf,
		BoldFont  = GenJyuuGothic-P-Heavy
	]{GenJyuuGothic-P-Medium}%
	\setmainfont[
		Extension = .ttf,
		BoldFont  = GenJyuuGothic-P-Heavy
	]{GenJyuuGothic-P-Medium}%
	\jlreq@keepbaselineskip{\large}%
}{% ラベル書式
	\rule[-0.5\baselineskip]{1ex}{1.5\baselineskip}%
	\hskip1ex
	\thesubsection%
}{% ラベルと見出し文字列の間の空き
	0.5em%
}{% 見出しの直前に入るコード
	#1%
}
\titlespacing{\subsection}
{1ex} %左の空き
{.7\baselineskip plus .21\baselineskip minus .042\baselineskip} % 上の空き
{.7\baselineskip plus .07\baselineskip} % 後の本文との空き

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Subsubsection
\titleformat{\subsubsection}[block]
{% 書式
	\setmainjfont[
		Extension = .ttf,
		BoldFont  = GenJyuuGothic-P-Heavy
	]{GenJyuuGothic-P-Medium}%
	\setmainfont[
		Extension = .ttf,
		BoldFont  = GenJyuuGothic-P-Heavy
	]{GenJyuuGothic-P-Medium}%
	\jlreq@keepbaselineskip{\normalsize}%
}{% ラベル書式
	\thesubsubsection%
}{% ラベルと見出し文字列の間の空き
	0.5em%
}{% 見出しの直前に入るコード
	#1%
}
\titlespacing{\subsubsection}
{1ex} %左の空き
{.7\baselineskip plus .21\baselineskip minus .042\baselineskip} % 上の空き
{.7\baselineskip plus .07\baselineskip} % 後の本文との空き
